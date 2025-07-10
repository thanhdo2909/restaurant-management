package Groq;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/groq")
public class GroqServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userMessage = req.getParameter("message");
        System.out.println("User message: " + userMessage);
        String apiKey = "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"; 
        String requestBody = """
        {
            "model": "llama3-70b-8192",
            "messages": [
                {"role": "user", "content": "%s"}
            ]
        }
        """.formatted(userMessage);

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.groq.com/openai/v1/chat/completions"))
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            resp.setContentType("application/json");
            PrintWriter out = resp.getWriter();
            out.print(response.body());
        } catch (InterruptedException e) {
            e.printStackTrace();
            resp.sendError(500, "Groq API call failed");
        }
    }
}
