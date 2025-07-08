package controller.user;

import DAO.ChatDAO;
import Model.ChatMessage;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

@WebServlet(name = "ChatboxServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyCypH4mifQ5Th7SQVjc7Kyu2ubZvHowCNY";
    private static final String GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + GEMINI_API_KEY;

    private ChatDAO chatDAO = new ChatDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        String userMessage = request.getParameter("message");

        chatDAO.saveMessage(new ChatMessage(userId, userMessage, "user"));

        String botResponse = generateBotResponse(userMessage);

        chatDAO.saveMessage(new ChatMessage(null, botResponse, "bot"));

        response.getWriter().write(botResponse);
    }

    private String generateBotResponse(String message) {

        try {
            return callGeminiAPI(message);
        } catch (Exception e) {
            return "Hiện tại tôi không thể trả lời câu hỏi này.";
        }
    }

    private String callGeminiAPI(String userMessage) throws IOException {
        URL url = new URL(GEMINI_ENDPOINT);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        JsonObject requestBody = new JsonObject();
        requestBody.add("contents", JsonParser.parseString("[{\"role\":\"user\",\"parts\":[{\"text\":\"" + userMessage + "\"}]}]"));

        try (OutputStream os = conn.getOutputStream()) {
            os.write(requestBody.toString().getBytes(StandardCharsets.UTF_8));
        }

        InputStream stream = (conn.getResponseCode() == 200)
                ? conn.getInputStream() : conn.getErrorStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8));
        String response = br.lines().collect(Collectors.joining());

        JsonObject jsonResponse = JsonParser.parseString(response).getAsJsonObject();
        return jsonResponse.getAsJsonArray("candidates")
                .get(0).getAsJsonObject()
                .get("content").getAsJsonObject()
                .get("parts").getAsJsonArray()
                .get(0).getAsJsonObject()
                .get("text").getAsString();
    }

    @Override
    public String getServletInfo() {
        return "Chatbot servlet using Gemini API";
    }
}
