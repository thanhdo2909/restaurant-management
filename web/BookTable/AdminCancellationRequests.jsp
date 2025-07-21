<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Yêu cầu Hủy - The Golden Spoon</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --dark-gold: #B8941F;
            --light-gold: #F4E7B8;
            --charcoal: #2C2C2C;
            --warm-white: #FEFEFE;
            --light-gray: #F8F8F8;
            --medium-gray: #E0E0E0;
            --text-dark: #333333;
            --text-light: #666666;
            --accent-red: #8B0000;
            --success-green: #2E7D32;
            --error-red: #C62828;
            --warning-orange: #F57C00;
            --info-blue: #1976D2;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
            background-color: var(--warm-white);
            margin: 0;
            padding: 0;
        }

        .header {
            background: linear-gradient(135deg, var(--charcoal), #1a1a1a);
            color: var(--warm-white);
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.error {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .alert.success {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--warm-white);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--medium-gray);
        }

        th {
            background: var(--light-gray);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        td {
            font-size: 0.95rem;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        tr:hover {
            background-color: var(--light-gold);
        }

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            font-size: 0.85rem;
        }

        .btn-approve {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .btn-approve:hover {
            background: linear-gradient(135deg, #2E7D32, #388E3C);
            transform: translateY(-1px);
        }

        .btn-reject {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .btn-reject:hover {
            background: linear-gradient(135deg, #C62828, #D32F2F);
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--medium-gray);
            margin-bottom: 15px;
        }

        .empty-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>Yêu cầu Hủy Đặt Bàn</h1>
    </header>

    <div class="container">
        <c:if test="${not empty error}">
            <div class="alert error">
                <i class="fas fa-exclamation-triangle"></i>
                <span><c:out value="${error}"/></span>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert success">
                <i class="fas fa-check-circle"></i>
                <span><c:out value="${success}"/></span>
            </div>
        </c:if>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty cancellationRequests and not empty cancellationRequests}">
                    <table>
                        <thead>
                            <tr>
                                <th>Mã Đặt Bàn</th>
                                <th>Mã Bàn</th>
                                <th>Mã Tài khoản</th>
                                <th>Thời gian bắt đầu</th>
                                <th>Thời gian kết thúc</th>
                                <th>Số khách</th>
                                <th>Tên khách</th>
                                <th>Ghi chú</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="request" items="${cancellationRequests}">
                                <tr>
                                    <td><strong>#<c:out value="${request.bookingID}"/></strong></td>
                                    <td>Bàn <c:out value="${request.roomID}"/></td>
                                    <td><c:out value="${request.accountID}"/></td>
                                    <td><c:out value="${request.startTime}"/></td>
                                    <td><c:out value="${request.endTime}"/></td>
                                    <td><c:out value="${request.people}"/></td>
                                    <td><c:out value="${request.phone}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty request.message}">
                                                <span title="${request.message}" style="cursor: help;">
                                                    <c:choose>
                                                        <c:when test="${request.message.length() > 20}">
                                                            ${request.message.substring(0, 20)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${request.message}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--text-light);">Không có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="action-buttons">
                                        <form action="${pageContext.request.contextPath}/AdminViewCancellationRequestsServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="bookingId" value="${request.bookingID}">
                                            <input type="hidden" name="action" value="approve">
                                            <button type="submit" class="btn btn-approve" onclick="return confirm('Phê duyệt yêu cầu hủy này?')">Phê duyệt</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/AdminViewCancellationRequestsServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="bookingId" value="${request.bookingID}">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit" class="btn btn-reject" onclick="return confirm('Từ chối yêu cầu hủy này?')">Từ chối</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <h3>Không có yêu cầu hủy nào</h3>
                        <p>Hiện tại không có yêu cầu hủy đặt bàn nào.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>