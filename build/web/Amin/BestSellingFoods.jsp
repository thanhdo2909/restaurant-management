<%-- 
    Document   : BestSellingFoods
    Created on : Jul 14, 2025, 8:10:36 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Món ăn bán chạy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
<h2>Món ăn bán chạy</h2>
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Mã món</th>
            <th>Tên món</th>
            <th>Số lượng đã bán</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="food" items="${bestFoods}">
            <tr>
                <td>${food.foodID}</td>
                <td>${food.foodName}</td>
                <td>${food.totalSold}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>