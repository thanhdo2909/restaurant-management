<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>QR Tables</title>
    <style>
        .qr-container { margin: 20px; text-align: center; float: left; }
        .qr-img { width: 150px; height: 150px; border: 1px solid #ccc; cursor: pointer; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>QR Code cho các bàn</h2>
    
    <%-- Hiển thị lỗi nếu có --%>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    
    <%-- Hiển thị thông báo thành công --%>
    <% if (request.getAttribute("tableNumber") != null) { %>
        <div style="color: green;">
            Đã tạo QR thành công cho bàn <%= request.getAttribute("tableNumber") %>
        </div>
    <% } %>
    
    <div>
        <% 
        String qrPath = application.getRealPath("/img/QR");
        for (int i = 1; i <= 10; i++) {
            File qrFile = new File(qrPath, "table_" + i + ".png");
        %>
            <div class="qr-container">
                <p>Bàn <%= i %></p>
                <% if (qrFile.exists()) { %>
                    <img id="qr_<%= i %>" src="img/QR/table_<%= i %>.png?ts=<%= System.currentTimeMillis() %>" 
                         alt="QR Bàn <%= i %>" class="qr-img"
                         onclick="regenerateQR(<%= i %>)"/>
                <% } else { %>
                    <div style="width:150px;height:150px;background:#eee;text-align:center;line-height:150px;">
                        <button onclick="regenerateQR(<%= i %>)">Tạo QR</button>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <script>
    function regenerateQR(tableId) {
        if (confirm("Tạo QR code cho bàn " + tableId + "?")) {
            window.location.href = "GenerateQRServlet?table=" + tableId;
        }
    }
    </script>
</body>
</html>