<%-- 
    Document   : OrderChart
    Created on : Jul 14, 2025, 8:25:48 AM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Biểu đồ số lượng đơn hàng</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            width: 70%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="text-center mb-4">Biểu đồ số lượng đơn hàng</h2>

        <form method="get" action="${pageContext.request.contextPath}/OrderChartServlet" class="text-center mb-4">
            <label for="filter" class="form-label fw-bold">Chọn loại thời gian:</label>
            <select name="filter" id="filter" onchange="this.form.submit()" class="form-select w-auto d-inline-block">
                <option value="day" ${filterType == 'day' ? 'selected' : ''}>Ngày</option>
                <option value="week" ${filterType == 'week' ? 'selected' : ''}>Tuần</option>
                <option value="month" ${filterType == 'month' ? 'selected' : ''}>Tháng</option>
            </select>
        </form>

        <div class="chart-container">
            <canvas id="orderChart" height="300"></canvas>
        </div>
    </div>

    <script>
        const labels = [<c:forEach var="r" items="${orderChartStats}">"${r.timeUnit}",</c:forEach>];
        const data = {
            labels: labels,
            datasets: [{
                label: 'Số lượng đơn hàng',
                data: [<c:forEach var="r" items="${orderChartStats}">${r.orderCount},</c:forEach>],
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                borderRadius: 8,
            }]
        };

        new Chart(document.getElementById('orderChart'), {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: { display: true },
                    title: {
                        display: true,
                        text: 'Số lượng đơn hàng theo thời gian',
                        font: { size: 18 }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
