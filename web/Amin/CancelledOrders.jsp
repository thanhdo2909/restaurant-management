<%-- 
    Document   : CancelledOrders
    Created on : Jul 14, 2025, 8:39:00 AM
    Author     : ACER
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê món ăn bị huỷ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h2 class="text-center mb-4">📉 Món ăn bị hủy theo thời gian</h2>

    <form method="get" action="${pageContext.request.contextPath}/CancelledOrdersServlet" class="text-center mb-4">
        <label class="fw-bold">Chọn thời gian:</label>
        <select name="filter" onchange="this.form.submit()" class="form-select w-auto d-inline-block">
            <option value="day" ${filterType == 'day' ? 'selected' : ''}>Ngày</option>
            <option value="month" ${filterType == 'month' ? 'selected' : ''}>Tháng</option>
            <option value="quarter" ${filterType == 'quarter' ? 'selected' : ''}>Quý</option>
            <option value="year" ${filterType == 'year' ? 'selected' : ''}>Năm</option>
        </select>
    </form>

    <table class="table table-bordered text-center mt-3">
        <thead class="table-dark">
            <tr>
                <th>Tên món ăn</th>
                <th>Số lượng bị huỷ</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cancelledFoods}">
                <tr>
                    <td>${item.foodName}</td>
                    <td>${item.totalSold}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <h4>🛑 Tổng số lượng món ăn bị huỷ: 
            <span class="text-danger fw-bold">${cancelledCount}</span>
        </h4>
    </div>
</body>
</html>
