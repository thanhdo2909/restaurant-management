
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .order-card { border-left: 5px solid #0d6efd; }
        .order-total { font-size: 1.2rem; font-weight: bold; color: #dc3545; }
        .food-img { width: 50px; height: 50px; object-fit: cover; }
    </style>
</head>
<body class="bg-light">
 <%@ include file="../includes/Nappar.jsp" %>
<div class="container mt-5">
    <h2 class="mb-4 text-primary">🧾 Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${empty orderList}">
            <div class="alert alert-warning text-center">🚫 Bạn chưa có đơn hàng nào.</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orderList}">
                <div class="card mb-4 shadow-sm order-card">
                    <div class="card-header bg-primary text-white d-flex justify-content-between">
                        <div>
                            
                            <strong>📅 Ngày đặt:</strong> ${order.createAt}
                        </div>
                        <div class="text-end">
                            <span class="badge bg-warning text-dark">${order.status}</span><br>
                            <span class="order-total">
                                💰 <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> đ
                            </span>
                        </div>
                    </div>

                    <div class="card-body">
                        <h6 class="mb-3 text-secondary">🍽 Chi tiết món ăn</h6>
                        <ul class="list-group">
                            <c:forEach var="detail" items="${order.orderDetail}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/${detail.img}" class="me-3 rounded food-img" alt="Ảnh món">
                                        <div>
                                            <strong>${detail.foodName}</strong><br>
                                            <small>SL: ${detail.quantity}</small>
                                        </div>
                                    </div>
                                    <span class="text-success">
                                        <fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true"/> đ
                                    </span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
