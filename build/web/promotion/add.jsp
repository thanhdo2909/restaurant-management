<%-- 
    Document   : add
    Created on : Jul 14, 2025, 10:54:27 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm mã giảm giá</title>
</head>
<body>
    <h2>Thêm mã giảm giá</h2>
    <form action="promotion" method="post">
        <input type="hidden" name="action" value="add">
        Mã giảm giá: <input type="text" name="code" required><br><br>
        Phần trăm giảm: <input type="number" name="percent" required><br><br>
        Hạn sử dụng: <input type="date" name="expire" required><br><br>
        <input type="submit" value="Thêm">
    </form>
    <a href="promotion">← Quay lại</a>
</body>
</html>
