<!DOCTYPE html>
<html>
<head>
    <title>Audio Link Form</title>
    <script>
        function submitForm(event) {
            event.preventDefault(); // Prevent form submission
            var form = event.target;
            var audioLink = form.audioLink.value;

            // Show loading icon
            document.getElementById("loading").style.display = "block";

            fetch("AudioTranscriptionServlet", {
                method: "POST",
                body: new URLSearchParams({ audioLink: audioLink }),
                headers: { "Content-Type": "application/x-www-form-urlencoded" }
            })
            .then(response => response.text())
            .then(text => {
                // Hide loading icon
                document.getElementById("loading").style.display = "none";

                // Update the UI with the response
                document.getElementById("result").textContent = text;
            })
            .catch(error => {
                console.error("Error:", error);
                // Hide loading icon
                document.getElementById("loading").style.display = "none";

                // Display error message
                document.getElementById("result").textContent = "Error processing the audio link.";
            });
        }
    </script>
</head>
<body>
    <h1>Submit Audio Link</h1>
    <form onsubmit="submitForm(event)">
        <label for="audioLink">Enter Audio Link:</label>
        <input type="text" id="audioLink" name="audioLink" required>
        <button type="submit">Submit</button>
    </form>

    <!-- Loading icon -->
    <div id="loading" style="display: none;">
        <img src="loading.gif" alt="Loading..." width="50" height="50">
        <p>Loading...</p>
    </div>

    <!-- Display the result -->
    <div id="result"></div>
</body>
</html>
