<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lỗi Đặt Bàn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .popup-content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .popup-content h4 {
            margin-bottom: 20px;
            color: #dc3545;
        }

        .popup-content .btn {
            margin: 0 10px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
    <% String error = (String) session.getAttribute("error");
       if (error != null) { %>
        <div class="popup-overlay" id="popupOverlay">
            <div class="popup-content">
                <h4>Lỗi Đặt Bàn</h4>
                <p><%= error %></p>
                <div>
                    <a href="${pageContext.request.contextPath}/home/Home.jsp" class="btn btn-secondary">Trở lại Home</a>
                    <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="btn btn-primary">Xem bàn</a>
                </div>
            </div>
        </div>
        <% session.removeAttribute("error"); %>
    <% } else { %>
        <% response.sendRedirect(request.getContextPath() + "/ViewRoomsServlet"); %>
    <% } %>
</body>
</html>