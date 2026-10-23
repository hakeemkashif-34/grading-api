package com.finalproject.servlet;

/**
 * Escapes text before it is shown on a page, so text from the AI or the user
 * can never run as HTML or JavaScript (prevents cross-site scripting).
 */
public final class Html {

    private Html() {
    }

    public static String escape(Object value) {
        if (value == null) {
            return "";
        }
        String text = value.toString();
        StringBuilder out = new StringBuilder(text.length());
        for (char c : text.toCharArray()) {
            switch (c) {
                case '<': out.append("&lt;"); break;
                case '>': out.append("&gt;"); break;
                case '&': out.append("&amp;"); break;
                case '"': out.append("&quot;"); break;
                case '\'': out.append("&#39;"); break;
                default: out.append(c);
            }
        }
        return out.toString();
    }
}
