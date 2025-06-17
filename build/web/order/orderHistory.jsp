<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch sử đơn hàng</title>
        <!-- ✅ Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <h2 class="mb-4 text-primary">Lịch sử đơn hàng</h2>

            <c:choose>
                <c:when test="${  empty orderList}">
                    <div class="alert alert-warning">Không có đơn hàng nào.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orderList}">
                        <div class="card mb-4 shadow-sm">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0">Đơn hàng </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-2">
                                        <img src="${order.img}" class="img-fluid rounded" alt="Ảnh món đại diện">
                                    </div>
                                    <div class="col-md-10">
                                        <p><strong>Ngày đặt:</strong> ${order.createAt}</p>
                                        <p><strong>Trạng thái:</strong> ${order.status}</p>
                                        <p><strong>Tổng tiền:</strong> 
                                            <span class="text-danger">
                                                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> đ
                                            </span>
                                        </p>
                                    </div>
                                </div>
                                <hr>
                                <h6>Chi tiết món ăn:</h6>
                                <ul class="list-group">
                                    <c:forEach var="detail" items="${order.orderDetail}">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/${detail.img}" width="50" class="me-2 rounded">
                                                <span><strong>${detail.foodName}</strong> – SL: ${detail.quantity}</span>
                                            </div>
                                            <span>
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

        <!-- Bootstrap JS (optional, for dropdowns, modals, etc.) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
