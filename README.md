# Grading API

A Java web app that reads a photo of a marked test and pulls out the student's name, grade, course code, and topic, using OpenAI's GPT-4o vision model.

I built this as my Grade 11 Computer Science final project (March to June 2024), and it earned a 98%.

**Demo video:** [youtube.com/watch?v=dd3trAH_h2Q](https://www.youtube.com/watch?v=dd3trAH_h2Q)

## How it works

1. A teacher uploads a photo of a marked test on the web page.
2. A Java servlet checks that the file is an image, encodes it, and sends it to GPT-4o with a prompt that explains the grading scale and the exact reply format.
3. The servlet splits the reply into fields and shows them on the results page.
4. If the photo has no grade on it, like a page of class notes, the app says "No grade was found."

Level grades are converted to percentages with this scale:

| Level | 4+ | 4 | 4- | 3+ | 3 | 3- | 2+ | 2 | 2- | 1+ | 1 | 1- |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Percent | 98 | 90 | 80 | 78 | 75 | 70 | 68 | 66 | 60 | 58 | 55 | 50 |

## Built with

- Java, Servlets, and JSP
- Maven and Tomcat 7 (through the Maven plugin)
- OpenAI API (GPT-4o) through the simple-openai library
- Tailwind CSS and daisyUI for the interface

## Run it locally

You need Java 21, Maven, and an OpenAI API key.

```bash
git clone https://github.com/hakeemkashif-34/grading-api.git
cd grading-api
export OPENAI_API_KEY=your-key-here
mvn install
mvn tomcat7:run
```

Then open http://localhost:8081/ in your browser.

## Project structure

- `src/main/java/com/finalproject/servlet/MainServlet.java`: handles uploads and calls OpenAI
- `src/main/java/com/finalproject/servlet/Html.java`: escapes text before it's shown on a page
- `src/main/webapp/index.jsp`: the upload page
- `src/main/webapp/results.jsp`: the results page

## Security notes

- The API key is read from an environment variable and is never stored in the code.
- Results are escaped before they're shown, so text in an uploaded image can't run as code on the page.

## Updates (October 2026)

- Cleaned up the code and removed unused files.
- Added the course code and topic extraction shown in the demo video to the published code.
- Added checks for missing or non-image uploads.
- Fixed a cross-site scripting bug on the results page.
