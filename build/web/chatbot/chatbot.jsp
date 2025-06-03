<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ChatGPT Chatbot Java Servlet</title>
    <script>
        async function sendMessage(event) {
            // Ngăn form submit mặc định
            event.preventDefault();  

            const message = document.getElementById("message").value.trim();
            if (!message) return;

            try {
                const response = await fetch("chat", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "message=" + encodeURIComponent(message)
                });

                const data = await response.json();

                if (data.error) {
                    alert(data.error);
                    return;
                }

                const answer = data.choices[0].message.content;
                const chatBox = document.getElementById("chatBox");
                chatBox.innerHTML += "<b>Bạn:</b> " + message + "<br/>";
                chatBox.innerHTML += "<b>ChatGPT:</b> " + answer + "<br/><br/>";
                chatBox.scrollTop = chatBox.scrollHeight;

                document.getElementById("message").value = "";
            } catch (error) {
                alert("Lỗi khi gửi yêu cầu: " + error);
            }
        }
    </script>
</head>
<body>
<h2>ChatGPT Chatbot Java Servlet</h2>
<form id="chatForm">
    <div id="chatBox" style="border:1px solid #ccc; height:300px; overflow:auto; padding:5px; margin-bottom:10px;"></div>
    <input type="text" id="message" placeholder="Nhập câu hỏi..." style="width:70%;"/>
    <button type="submit">Gửi</button>
</form>

<script>
    // Gắn sự kiện submit cho form
    document.getElementById("chatForm").addEventListener("submit", sendMessage);
</script>
</body>
</html>
