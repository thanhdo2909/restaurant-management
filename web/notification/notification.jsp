<%-- 
    Document   : notification
    Created on : Jun 15, 2025, 3:21:27 PM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông Báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="mb-4">📢 Danh sách Thông Báo</h3>
<div class="list-group">
    <c:forEach var="n" items="${notification}">
        <a href="${pageContext.request.contextPath}/NotificationServlet?id=${n.id}" 
           class="list-group-item list-group-item-action ${n.isRead ? 'text-muted' : 'fw-bold'}">
            <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1">${n.title}</h5>
                <small>${n.createdAt}</small>
            </div>
            <p class="mb-1">${n.message}</p>
        </a>
    </c:forEach>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
