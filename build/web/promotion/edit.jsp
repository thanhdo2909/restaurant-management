<%-- 
    Document   : edit
    Created on : Jul 14, 2025, 10:54:34 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Promotion"%>
<%
    Promotion p = (Promotion) request.getAttribute("promotion");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa mã giảm giá</title>
</head>
<body>
    <h2>Sửa mã giảm giá</h2>

    <form action="promotion" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= p.getPromoID() %>">

        Mã giảm giá:
        <input type="text" name="code" value="<%= p.getPromoCode() %>" required><br><br>

        Phần trăm giảm:
        <input type="number" name="percent" value="<%= p.getDiscountPercent() %>" required><br><br>

        Hạn sử dụng:
        <input type="date" name="expire" value="<%= p.getExpirationDate().toLocalDate() %>" required><br><br>

        Trạng thái:
        <select name="active">
            <option value="true" <%= p.isIsActive() ? "selected" : "" %>>Mở</option>
            <option value="false" <%= !p.isIsActive() ? "selected" : "" %>>Khóa</option>
        </select><br><br>

        <input type="submit" value="Cập nhật">
    </form>

    <a href="promotion">← Quay lại</a>
</body>
</html>
