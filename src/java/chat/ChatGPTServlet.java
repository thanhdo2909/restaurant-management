package chat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/chat")
public class ChatGPTServlet extends HttpServlet {

    // ✅ Thay bằng API key mới của bạn
    private static final String OPENAI_API_KEY = "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";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = request.getParameter("message");

        // Xử lý message với ChatGPT hoặc API
        String reply = "Xin chào! Bạn đã gửi: " + message;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print("{\"choices\":[{\"message\":{\"content\":\"" + reply + "\"}}]}");
        out.flush();
    }
    private String callOpenAI(String prompt) throws IOException {
        URL url = new URL("https://api.openai.com/v1/chat/completions");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Authorization", "Bearer " + OPENAI_API_KEY);
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        String jsonInputString = "{"
                + "\"model\": \"gpt-4o\","
                + "\"messages\": [{\"role\": \"user\", \"content\": \"" + escapeJson(prompt) + "\"}]"
                + "}";

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int responseCode = con.getResponseCode();
        InputStream inputStream = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            return response.toString();
        }
    }

    private String escapeJson(String str) {
        return str.replace("\"", "\\\"");
    }
}
