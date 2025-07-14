<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Thống kê doanh thu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">

    <h2>Thống kê doanh thu theo thời gian</h2>

    <!-- Form lọc thời gian -->
    <form method="get" action="${pageContext.request.contextPath}/RevenueServlet" class="mb-4 d-flex gap-3 align-items-center">
        <label class="form-label">Chọn loại thống kê:</label>
        <select name="filter" onchange="this.form.submit()" class="form-select w-auto">
            <option value="day" ${filterType == 'day' ? 'selected' : ''}>Ngày</option>
            <option value="month" ${filterType == 'month' ? 'selected' : ''}>Tháng</option>
            <option value="quarter" ${filterType == 'quarter' ? 'selected' : ''}>Quý</option>
            <option value="year" ${filterType == 'year' ? 'selected' : ''}>Năm</option>
        </select>
    </form>

    <!-- Bảng thống kê -->
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Thời gian</th>
                <th>Tổng doanh thu (VNĐ)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="r" items="${revenueStats}">
                <tr>
                    <td>${r.timeUnit}</td>
                    <td><fmt:formatNumber value="${r.totalRevenue}" type="currency" currencySymbol="₫"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Nút xuất báo cáo -->
    <form method="get" action="${pageContext.request.contextPath}/ExportReportServlet" class="mt-4 row g-3">
        <input type="hidden" name="filter" value="${filterType}" />
        <div class="col-auto">
            <label class="form-label">Định dạng:</label>
            <select name="format" class="form-select">
                <option value="pdf">PDF</option>
                <option value="excel">Excel</option>
            </select>
        </div>
        <div class="col-auto align-self-end">
            <button type="submit" class="btn btn-success">📄 Xuất Báo Cáo</button>
        </div>
    </form>

</body>
</html>
