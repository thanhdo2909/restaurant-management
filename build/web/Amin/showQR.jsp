<%-- 
    Document   : showQR
    Created on : Jul 20, 2025, 3:49:02 PM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mã QR các bàn</title>
    <style>
        .qr-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .qr-item {
            text-align: center;
            cursor: pointer;
        }
        .qr-item img {
            width: 200px;
            height: 200px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <h1>📱 Mã QR gọi món từng bàn</h1>
    <div class="qr-container">
        <%
            for (int i = 1; i <= 10; i++) {
        %>
            <div class="qr-item" onclick="confirmRegenerate(<%= i %>)">
                <p><strong>Bàn <%= i %></strong></p>
                <img src = "img/QR/table_" + tableId + ".png?ts=" + new Date().getTime() ">
            </div>
        <%
            }
        %>
    </div>

    <script>
        function confirmRegenerate(tableId) {
            if (confirm("Bạn muốn tạo mới QR code cho bàn " + tableId + "?")) {
                fetch("GenerateQRServlet?table=" + tableId)
                    .then(response => {
                        if (response.ok) {
                            const img = document.getElementById("qr-img-" + tableId);
                            img.src = "qrcodes/table_" + tableId + ".png?ts=" + new Date().getTime(); // Bypass cache
                            alert("Đã tạo mới QR cho bàn " + tableId);
                        } else {
                            alert("Lỗi khi tạo lại QR!");
                        }
                    });
            }
        }
    </script>
</body>
</html>
