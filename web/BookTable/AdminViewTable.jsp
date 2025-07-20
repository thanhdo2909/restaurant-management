<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bàn - The Golden Spoon Restaurant</title>
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
            background-color: var(--warm-white);
            overflow-x: hidden;
        }

        /* Header Section */
        .admin-header {
            background: linear-gradient(135deg, var(--charcoal), #1a1a1a);
            color: var(--warm-white);
            padding: 30px 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .logo-text h1 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-gold);
            margin-bottom: 5px;
        }

        .logo-text p {
            font-size: 0.9rem;
            opacity: 0.8;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 0.95rem;
        }

        .admin-info i {
            color: var(--primary-gold);
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* Alerts */
        .alerts-section {
            margin-bottom: 30px;
        }

        .alert {
            padding: 20px 30px;
            border-radius: 12px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            animation: slideDown 0.6s ease-out;
            margin-bottom: 15px;
        }

        .alert.success {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .alert.error {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .alert i {
            font-size: 1.2rem;
        }

        /* Section Styling */
        .management-section {
            background: var(--warm-white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }

        .section-header {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            padding: 25px 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 600;
            margin: 0;
        }

        .section-header i {
            font-size: 1.3rem;
        }

        /* Table Styling */
        .table-container {
            padding: 0;
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        .data-table thead {
            background: var(--light-gray);
        }

        .data-table th {
            padding: 20px 15px;
            text-align: left;
            font-weight: 600;
            color: var(--text-dark);
            border-bottom: 2px solid var(--medium-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        .data-table td {
            padding: 20px 15px;
            border-bottom: 1px solid var(--medium-gray);
            vertical-align: middle;
        }

        .data-table tbody tr {
            transition: background-color 0.3s ease;
        }

        .data-table tbody tr:hover {
            background-color: var(--light-gold);
        }

        .data-table tbody tr:nth-child(even) {
            background-color: #fafafa;
        }

        .data-table tbody tr:nth-child(even):hover {
            background-color: var(--light-gold);
        }

        /* Status Badges */
        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
            min-width: 80px;
            text-align: center;
        }

        .status-badge.booked {
            background: linear-gradient(135deg, var(--info-blue), #2196F3);
            color: white;
        }

        .status-badge.checkedin {
            background: linear-gradient(135deg, var(--warning-orange), #FF9800);
            color: white;
        }

        .status-badge.completed {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .status-badge.cancelled {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .status-badge.available {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        /* Form Elements */
        .inline-form {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .form-input {
            padding: 10px 12px;
            border: 2px solid var(--medium-gray);
            border-radius: 8px;
            font-size: 0.9rem;
            width: 120px;
            transition: border-color 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
        }

        .form-input.name-input {
            width: 140px;
        }

        /* Buttons */
        .btn {
            padding: 10px 16px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            margin: 2px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            box-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #2E7D32, #388E3C);
            transform: translateY(-1px);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #C62828, #D32F2F);
            transform: translateY(-1px);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-orange), #FF9800);
            color: white;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #F57C00, #FB8C00);
            transform: translateY(-1px);
        }

        .action-buttons {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--warm-white);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border-left: 5px solid var(--primary-gold);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .stat-content h3 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-content p {
            color: var(--text-light);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        /* Room ID Styling */
        .room-id {
            font-weight: 700;
            color: var(--primary-gold);
            font-size: 1.1rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--medium-gray);
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--text-dark);
        }

        /* Animations */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .table-container {
                border-radius: 0;
            }

            .data-table th,
            .data-table td {
                padding: 12px 8px;
                font-size: 0.85rem;
            }

            .inline-form {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }

            .form-input {
                width: 100%;
            }

            .action-buttons {
                justify-content: center;
            }

            .section-header {
                padding: 20px 20px;
            }

            .section-header h2 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .main-container {
                padding: 20px 10px;
            }

            .admin-header {
                padding: 20px 10px;
            }

            .logo-text h1 {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="header-content">
            <div class="admin-logo">
                <div class="logo-icon">
                    <i class="fas fa-crown"></i>
                </div>
                <div class="logo-text">
                    <h1>The Golden Spoon</h1>
                    <p>Admin Dashboard</p>
                </div>
            </div>
            <div class="admin-info">
                <i class="fas fa-user-shield"></i>
                <span>Quản lý hệ thống</span>
            </div>
        </div>
    </header>

    <main class="main-container">
        <!-- Alerts Section -->
        <c:if test="${not empty error}">
            <div class="alerts-section">
                <div class="alert error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span><c:out value="${error}"/></span>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alerts-section">
                <div class="alert success">
                    <i class="fas fa-check-circle"></i>
                    <span><c:out value="${success}"/></span>
                </div>
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chair"></i>
                </div>
                <div class="stat-content">
                    <h3><c:out value="${empty rooms ? 0 : rooms.size()}"/></h3>
                    <p>Tổng số bàn</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-content">
                    <h3><c:out value="${empty bookings ? 0 : bookings.size()}"/></h3>
                    <p>Đặt bàn hôm nay</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-content">
                    <h3>
                        <c:set var="checkedInCount" value="0"/>
                        <c:forEach var="booking" items="${bookings}">
                            <c:if test="${booking.status == 'CheckedIn'}">
                                <c:set var="checkedInCount" value="${checkedInCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        <c:out value="${checkedInCount}"/>
                    </h3>
                    <p>Khách đang dùng bữa</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h3>
                        <c:set var="pendingCount" value="0"/>
                        <c:forEach var="booking" items="${bookings}">
                            <c:if test="${booking.status == 'Booked'}">
                                <c:set var="pendingCount" value="${pendingCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        <c:out value="${pendingCount}"/>
                    </h3>
                    <p>Chờ check-in</p>
                </div>
            </div>
        </div>

        <!-- Rooms Management Section -->
        <section class="management-section">
            <div class="section-header">
                <i class="fas fa-utensils"></i>
                <h2>Quản lý Bàn Ăn</h2>
            </div>
            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty rooms}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> Mã Bàn</th>
                                    <th><i class="fas fa-tag"></i> Loại Bàn</th>
                                    <th><i class="fas fa-users"></i> Sức Chứa</th>
                                    <th><i class="fas fa-sign-in-alt"></i> Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td><span class="room-id">Bàn <c:out value="${room.roomID}"/></span></td>
                                        <td><c:out value="${room.roomType}"/></td>
                                        <td><i class="fas fa-user"></i> <c:out value="${room.maxCapacity}"/> người</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty roomStatus[room.roomID] || roomStatus[room.roomID] != 'CheckedIn'}">
                                                    <form action="AdminViewTableServlet" method="post" class="inline-form">
                                                        <input type="hidden" name="action" value="checkin">
                                                        <input type="hidden" name="roomId" value="${room.roomID}">
                                                        <input type="number" name="people" class="form-input" placeholder="Số người" min="1" max="${room.maxCapacity}" required>
                                                        <input type="text" name="name" class="form-input name-input" placeholder="Tên khách hàng" required>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-sign-in-alt"></i>
                                                            Check-in
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="booking" items="${bookings}">
                                                        <c:if test="${booking.roomID == room.roomID && booking.status == 'CheckedIn'}">
                                                            <form action="AdminViewTableServlet" method="post" class="inline-form">
                                                                <input type="hidden" name="action" value="checkout">
                                                                <input type="hidden" name="bookingId" value="${booking.bookingID}">
                                                                <button type="submit" class="btn btn-success">
                                                                    <i class="fas fa-sign-out-alt"></i>
                                                                    Check-out
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-chair"></i>
                            <h3>Chưa có bàn nào</h3>
                            <p>Hiện tại chưa có bàn ăn nào trong hệ thống</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Bookings Management Section -->
        <section class="management-section">
            <div class="section-header">
                <i class="fas fa-calendar-alt"></i>
                <h2>Quản lý Đặt Bàn</h2>
            </div>
            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty bookings}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> Mã ĐB</th>
                                    <th><i class="fas fa-chair"></i> Bàn</th>
                                    <th><i class="fas fa-user"></i> Tài khoản</th>
                                    <th><i class="fas fa-clock"></i> Thời gian</th>
                                    <th><i class="fas fa-info-circle"></i> Trạng thái</th>
                                    <th><i class="fas fa-users"></i> Khách</th>
                                    <th><i class="fas fa-user-tag"></i> Tên KH</th>
                                    <th><i class="fas fa-comment"></i> Ghi chú</th>
                                    <th><i class="fas fa-cogs"></i> Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="booking" items="${bookings}">
                                    <tr>
                                        <td><strong>#<c:out value="${booking.bookingID}"/></strong></td>
                                        <td><span class="room-id">Bàn <c:out value="${booking.roomID}"/></span></td>
                                        <td><c:out value="${fullNameMap[booking.bookingID]}"/></td>
                                        <td>
                                            <div style="font-size: 0.9rem;">
                                                <div><i class="fas fa-play"></i> <c:out value="${booking.startTime}"/></div>
                                                <div><i class="fas fa-stop"></i> <c:out value="${booking.endTime}"/></div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.status == 'Booked'}">
                                                    <span class="status-badge booked">Đã đặt</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CheckedIn'}">
                                                    <span class="status-badge checkedin">Đang dùng</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'Completed'}">
                                                    <span class="status-badge completed">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'Cancelled'}">
                                                    <span class="status-badge cancelled">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge">${booking.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><i class="fas fa-users"></i> <c:out value="${booking.people}"/></td>
                                        <td><c:out value="${booking.phone}"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty booking.message}">
                                                    <span title="${booking.message}" style="cursor: help;">
                                                        <i class="fas fa-comment-dots"></i>
                                                        <c:choose>
                                                            <c:when test="${booking.message.length() > 20}">
                                                                ${booking.message.substring(0, 20)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${booking.message}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--text-light); font-style: italic;">
                                                        <i class="fas fa-minus"></i> Không có
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <c:if test="${booking.status == 'Booked' || booking.status == 'CheckedIn'}">
                                                    <form action="AdminViewTableServlet" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="checkout">
                                                        <input type="hidden" name="bookingId" value="${booking.bookingID}">
                                                        <button type="submit" class="btn btn-success" title="Check-out">
                                                            <i class="fas fa-sign-out-alt"></i>
                                                            Check-out
                                                        </button>
                                                    </form>
                                                    <form action="AdminViewTableServlet" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <input type="hidden" name="bookingId" value="${booking.bookingID}">
                                                        <button type="submit" class="btn btn-danger" title="Hủy đặt bàn" 
                                                                onclick="return confirm('Bạn có chắc chắn muốn hủy đặt bàn này không?')">
                                                            <i class="fas fa-times"></i>
                                                            Hủy
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${booking.status != 'Booked' && booking.status != 'CheckedIn'}">
                                                    <span class="btn" style="background: var(--medium-gray); color: var(--text-light); cursor: not-allowed;">
                                                        <i class="fas fa-check"></i>
                                                        Đã xử lý
                                                    </span>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-calendar-times"></i>
                            <h3>Chưa có đặt bàn nào</h3>
                            <p>Hiện tại chưa có đơn đặt bàn nào trong hệ thống</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
</body>
</html>