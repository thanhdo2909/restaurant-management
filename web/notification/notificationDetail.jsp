<%-- 
    Document   : notificationDatail
    Created on : Jun 15, 2025, 4:35:31 PM
    Author     : ACER
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thông báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <a href="${pageContext.request.contextPath}/NotificationServlet" class="btn btn-secondary mb-3">← Quay lại danh sách</a>

    <c:choose>
        <c:when test="${not empty notification}">
            <div class="card">
                <div class="card-header">
                    <h4>${notification.title}</h4>
                </div>
                <div class="card-body">
                    <p class="card-text">${notification.message}</p>
                    <hr>
                    <p><strong>Thời gian:</strong> ${notification.createdAt}</p>
                    <p><strong>Trạng thái:</strong>
                        <c:if test="${notification.isRead}">
                            <span class="badge bg-success">Đã đọc</span>
                        </c:if>
                        <c:if test="${not notification.isRead}">
                            <span class="badge bg-warning text-dark">Chưa đọc</span>
                        </c:if>
                    </p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger">
                Không tìm thấy thông báo!
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
