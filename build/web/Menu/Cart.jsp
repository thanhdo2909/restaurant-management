<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new java.util.ArrayList<>();
    session.setAttribute("cart", cart); // đảm bảo cart luôn có trong session
%>

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty cart}">
            <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên món</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cart}">
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/${item.image}" width="80" height="60" style="object-fit: cover;" /></td>
                            <td>${item.foodName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.price} đ</td>
                            <td>${item.totalPrice} đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Tổng giá tiền -->
            <div class="text-end fw-bold fs-5">
                Tổng cộng: 
                <c:set var="total" value="0" />
                <c:forEach var="item" items="${cart}">
                    <c:set var="total" value="${total + item.totalPrice}" />
                </c:forEach>
                ${total} đ
            </div>
        </c:otherwise>
    </c:choose>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/MenuServlet" class="btn btn-secondary">⬅️ Tiếp tục đặt món</a>
        <a href="CheckoutServlet" class="btn btn-success">✅ Thanh toán</a>
    </div>
</div>
</body>
</html>
