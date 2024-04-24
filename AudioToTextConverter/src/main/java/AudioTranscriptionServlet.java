import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/AudioTranscriptionServlet")
public class AudioTranscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String audioLink = request.getParameter("audioLink");
        if (audioLink != null && !audioLink.isEmpty()) {
            try {
                Transcript transcript = new Transcript();
                transcript.setAudio_url(audioLink);
                Gson gson = new Gson();
                String jsonRequest = gson.toJson(transcript);

                HttpRequest postRequest = HttpRequest.newBuilder()
                        .uri(new URI("https://api.assemblyai.com/v2/transcript"))
                        .header("Authorization", "52d3f97301884e43b51a5974de5452db")
                        .POST(BodyPublishers.ofString(jsonRequest))
                        .build();

                HttpClient httpClient = HttpClient.newHttpClient();
                HttpResponse<String> postResponse = httpClient.send(postRequest, HttpResponse.BodyHandlers.ofString());

                // Handle the postResponse (e.g., send back response to JSP)
                response.getWriter().println(postResponse.body());
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error processing the audio link.");
            }
        } else {
            response.getWriter().println("Please enter a valid audio link.");
        }
    }
}
