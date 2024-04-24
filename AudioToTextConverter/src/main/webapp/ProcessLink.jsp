<%@ page import="java.net.URI" %>
<%@ page import="java.net.http.HttpClient" %>
<%@ page import="java.net.http.HttpRequest" %>
<%@ page import="java.net.http.HttpResponse" %>
<%@ page import="java.net.http.HttpRequest.BodyPublishers" %>
<%@ page import="java.net.http.HttpResponse.BodyHandlers" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.rest.practice.Transcript" %>

<%
    // Get the audio link submitted by the user
    String audioLink = request.getParameter("audioLink");
    if (audioLink != null && !audioLink.isEmpty()) {
        // Process the audioLink using Gson and HttpClient
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
            HttpResponse<String> postResponse = httpClient.send(postRequest, BodyHandlers.ofString());

            // Handle the postResponse (e.g., print or process the response)
            out.println(postResponse.body());
        } catch (Exception e) {
            out.println("Error processing the audio link.");
            e.printStackTrace();
        }
    } else {
        out.println("Please enter a valid audio link.");
    }
%>
