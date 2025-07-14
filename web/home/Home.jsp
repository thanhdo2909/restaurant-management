<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../includes/Nappar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Restaurantly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
    /* Hero Section */
    #hero {
        position: relative;
        height: 100vh;
        padding-top: 120px;
        background-color: #000;
        color: #fff;
        overflow: hidden;
    }

    #hero img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: 1;
        opacity: 0.6;
    }

    #hero .container {
        position: relative;
        z-index: 2;
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 100%;
    }

    #hero h2 {
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    #hero h2 span {
        color: #ffc107;
    }

    #hero p {
        font-size: 18px;
        margin-bottom: 30px;
    }

    .cta-btn {
        background-color: #ffc107;
        color: #000;
        padding: 10px 25px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        margin-right: 15px;
        transition: background-color 0.3s ease;
    }

    .cta-btn:hover {
        background-color: #e0a800;
        color: #fff;
    }

    /* Chat UI */
    #chat-toggle {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #ffc107;
        color: #000;
        padding: 12px;
        font-size: 18px;
        border-radius: 50%;
        cursor: pointer;
        z-index: 9999;
    }

    #chat-popup {
        position: fixed;
        bottom: 80px;
        right: 20px;
        width: 300px;
        background: white;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
        display: none;
        flex-direction: column;
        z-index: 10000;
    }

    #chat-header {
        background: #ffc107;
        padding: 10px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }

    #chat-body {
        padding: 10px;
    }

    #chat-log {
        height: 160px;
        overflow-y: auto;
        font-size: 14px;
        border: 1px solid #ccc;
        padding: 5px;
        margin-bottom: 10px;
        color: #000;
    }

    .chat-input-group {
        display: flex;
        gap: 5px;
    }

    #chat-input {
        flex: 1;
        padding: 6px;
        font-size: 14px;
    }

    #chat-body button {
        background: #ffc107;
        color: #000;
        font-weight: bold;
        border: none;
        padding: 6px 12px;
        cursor: pointer;
    }
    </style>
</head>

<body>
    <!-- 🔥 Hero Section -->
    <section id="hero" class="hero section dark-background">
        <img src="${pageContext.request.contextPath}/assets/img/hero-bg.jpg" alt="Hero Background">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 d-flex flex-column align-items-center align-items-lg-start">
                    <h2>Welcome to <span>Restaurantly</span></h2>
                    <p>Delivering great food for more than 18 years!</p>
                    <div class="d-flex mt-4">
                        <a href="${pageContext.request.contextPath}/MenuServlet" class="cta-btn">Our Menu</a>
                        <a href="#book-a-table" class="cta-btn">Book a Table</a>
                    </div>
                    <div class="d-flex mt-3">
                        <a href="${pageContext.request.contextPath}/promotion" class="cta-btn">
                            🎟 Mã Giảm Giá
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 💬 Chat Toggle Button -->
    <div id="chat-toggle" onclick="toggleChat()">💬</div>

    <!-- 💬 Chat Popup -->
    <div id="chat-popup">
        <div id="chat-header">
            Ask Groq <span onclick="toggleChat()" style="cursor:pointer;">×</span>
        </div>
        <div id="chat-body">
            <div id="chat-log"></div>
            <div class="chat-input-group">
                <input type="text" id="chat-input" placeholder="Type your question...">
                <button onclick="sendToGroq()">Send</button>
            </div>
        </div>
    </div>

    <!-- 📜 Chat Script -->
    <script>
        function escapeHtml(str) {
            return str.replace(/[&<>"']/g, function (m) {
                return {
                    '&': '&amp;',
                    '<': '&lt;',
                    '>': '&gt;',
                    '"': '&quot;',
                    "'": '&#39;'
                }[m];
            });
        }

        function toggleChat() {
            const popup = document.getElementById("chat-popup");
            popup.style.display = popup.style.display === "none" ? "flex" : "none";
        }

        function sendToGroq() {

            const input = document.getElementById("chat-input");
            const log = document.getElementById("chat-log");
            const message = input.value.trim();
            if (!message) return;
            log.innerHTML += "<div><b>You:</b> " + escapeHtml(message) + "</div>";
            input.value = "";

            fetch("groq", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "message=" + encodeURIComponent(message)
            })
            .then(res => res.json())
            .then(data => {
                const reply = data.choices?.[0]?.message?.content || "No reply from Groq.";
                log.innerHTML += "<div><b>Assistance:</b> " + escapeHtml(reply) + "</div>";
                log.scrollTop = log.scrollHeight;
            })
            .catch(err => {
                log.innerHTML += `<div><b>Assistance:</b> Chatbot is currently unavailable, please come back later.</div>`;
            });
        }
    </script>
</body>
</html>
