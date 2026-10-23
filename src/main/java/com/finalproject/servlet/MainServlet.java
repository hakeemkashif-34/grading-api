package com.finalproject.servlet;

import io.github.sashirestela.openai.SimpleOpenAI;
import io.github.sashirestela.openai.common.content.ContentPart.ContentPartImageUrl;
import io.github.sashirestela.openai.common.content.ContentPart.ContentPartImageUrl.ImageUrl;
import io.github.sashirestela.openai.common.content.ContentPart.ContentPartText;
import io.github.sashirestela.openai.domain.chat.Chat;
import io.github.sashirestela.openai.domain.chat.ChatMessage.SystemMessage;
import io.github.sashirestela.openai.domain.chat.ChatMessage.UserMessage;
import io.github.sashirestela.openai.domain.chat.ChatRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Receives a photo of a marked test, sends it to OpenAI's GPT-4o model,
 * and shows the student's name, grade, course code, and topic on the results page.
 */
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10 MB limit per image
public class MainServlet extends HttpServlet {

    private static final String NO_GRADE = "No grade was found";

    // Tells the model how to turn level grades (like 4+) into percentages.
    private static final String SYSTEM_PROMPT =
            "You read photos of marked school tests and quizzes. Convert level grades to percentages "
            + "with this scale: 4+ = 98%, 4 = 90%, 4- = 80%, 3+ = 78%, 3 = 75%, 3- = 70%, "
            + "2+ = 68%, 2 = 66%, 2- = 60%, 1+ = 58%, 1 = 55%, 1- = 50%.";

    // Asks for a fixed four-line format so the reply is easy to split into fields.
    private static final String USER_PROMPT =
            "Read this test and reply with exactly these four lines and nothing else:\n"
            + "Name: the student's name\n"
            + "Grade: the overall grade as a percentage, or one percentage per part separated by commas\n"
            + "Course code: the course code, like SPH3U\n"
            + "Topic: the topic of the test, like Kinematics\n"
            + "Write Unknown for any line you cannot find. "
            + "If there is no grade on the page, reply with exactly: " + NO_GRADE;

    private SimpleOpenAI openAI;

    @Override
    public void init() throws ServletException {
        super.init();
        // The API key comes from an environment variable so it is never stored in the code.
        String apiKey = System.getenv("OPENAI_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new ServletException("Set the OPENAI_API_KEY environment variable before starting the server.");
        }
        openAI = SimpleOpenAI.builder().apiKey(apiKey).build();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Check the upload
        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            showError(request, response, "Please choose an image to upload.");
            return;
        }
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            showError(request, response, "The file must be an image, like a JPG or PNG.");
            return;
        }

        // 2. Turn the image into a data URL the API accepts
        byte[] imageBytes;
        try (InputStream in = filePart.getInputStream()) {
            imageBytes = in.readAllBytes();
        }
        String imageUri = "data:" + contentType + ";base64," + Base64.getEncoder().encodeToString(imageBytes);

        // 3. Ask GPT-4o to read the test
        ChatRequest chatRequest = ChatRequest.builder()
                .model("gpt-4o")
                .messages(List.of(
                        SystemMessage.of(SYSTEM_PROMPT, "system"),
                        UserMessage.of(List.of(
                                ContentPartText.of(USER_PROMPT),
                                ContentPartImageUrl.of(ImageUrl.of(imageUri))))))
                .build();

        String reply;
        try {
            Chat chatResponse = openAI.chatCompletions().create(chatRequest).join();
            reply = chatResponse.getChoices().get(0).getMessage().getContent();
        } catch (Exception e) {
            log("OpenAI request failed", e);
            showError(request, response, "Something went wrong while reading the image. Please try again.");
            return;
        }

        // 4. Split the reply into fields and show the results page
        if (reply == null || reply.trim().startsWith(NO_GRADE)) {
            request.setAttribute("noGrade", Boolean.TRUE);
        } else {
            Map<String, String> fields = parseReply(reply);
            request.setAttribute("name", fields.getOrDefault("name", "Unknown"));
            request.setAttribute("grade", fields.getOrDefault("grade", "Unknown"));
            request.setAttribute("courseCode", fields.getOrDefault("course code", "Unknown"));
            request.setAttribute("topic", fields.getOrDefault("topic", "Unknown"));
        }
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }

    /** Turns lines like "Grade: 98%" into a map entry: "grade" -> "98%". */
    static Map<String, String> parseReply(String reply) {
        Map<String, String> fields = new HashMap<>();
        for (String line : reply.split("\\r?\\n")) {
            int colon = line.indexOf(':');
            if (colon > 0) {
                String key = line.substring(0, colon).trim().toLowerCase();
                String value = line.substring(colon + 1).trim();
                if (!value.isEmpty()) {
                    fields.put(key, value);
                }
            }
        }
        return fields;
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }
}
