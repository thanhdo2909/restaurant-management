<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Room" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Bàn - The Golden Spoon Restaurant</title>
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
        .restaurant-header {
            background: linear-gradient(rgba(44, 44, 44, 0.8), rgba(44, 44, 44, 0.8)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23000" width="1200" height="800"/><rect fill="%23111" width="600" height="400" x="300" y="200" rx="20"/></svg>');
            background-size: cover;
            background-position: center;
            color: var(--warm-white);
            text-align: center;
            padding: 60px 20px;
            position: relative;
        }

        .restaurant-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(ellipse at center, transparent 0%, rgba(0,0,0,0.3) 100%);
        }

        .header-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            margin: 0 auto;
        }

        .restaurant-logo {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--primary-gold);
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .restaurant-tagline {
            font-size: 1.2rem;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.8;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Alerts */
        .alerts-section {
            padding: 30px 0;
        }

        .alert {
            max-width: 800px;
            margin: 0 auto 20px;
            padding: 20px 30px;
            border-radius: 12px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            animation: slideDown 0.6s ease-out;
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

        /* Booking Information */
        .booking-summary {
            background: var(--light-gray);
            margin: 40px 0;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
        }

        .booking-header {
            background: linear-gradient(135deg, var(--charcoal), #1a1a1a);
            color: var(--warm-white);
            padding: 25px 30px;
            text-align: center;
        }

        .booking-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .booking-details {
            padding: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .booking-item {
            background: var(--warm-white);
            padding: 20px;
            border-radius: 15px;
            border-left: 4px solid var(--primary-gold);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.3s ease;
        }

        .booking-item:hover {
            transform: translateY(-2px);
        }

        .booking-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.1rem;
        }

        .booking-text {
            flex: 1;
        }

        .booking-label {
            font-size: 0.9rem;
            color: var(--text-light);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .booking-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        /* Tables Section */
        .tables-section {
            padding: 60px 0;
        }

        .section-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 15px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 2px;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
        }

        /* Table Grid */
        .tables-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .table-card {
            background: var(--warm-white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid var(--medium-gray);
            position: relative;
        }

        .table-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .table-card.available::before {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
        }

        .table-card.booked::before {
            background: linear-gradient(135deg, var(--error-red), #E53935);
        }

        .table-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        }

        .table-card:hover::before {
            transform: scaleX(1);
        }

        .table-card.booked {
            opacity: 0.7;
            background: #f5f5f5;
        }

        .table-image {
            height: 200px;
            background: linear-gradient(135deg, var(--light-gold), var(--primary-gold));
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .table-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><defs><pattern id="table-pattern" width="40" height="40" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="200" height="200" fill="url(%23table-pattern)"/></svg>');
        }

        .table-icon {
            font-size: 4rem;
            color: var(--warm-white);
            position: relative;
            z-index: 2;
        }

        .table-content {
            padding: 25px;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--charcoal);
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-badge.available {
            background: var(--success-green);
            color: white;
        }

        .status-badge.booked {
            background: var(--error-red);
            color: white;
        }

        .table-info {
            margin-bottom: 25px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid var(--medium-gray);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--text-light);
            font-weight: 500;
        }

        .info-value {
            font-weight: 600;
            color: var(--text-dark);
        }

        .table-action {
            text-align: center;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 1rem;
            min-width: 180px;
            font-family: 'Inter', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            box-shadow: 0 4px 20px rgba(212, 175, 55, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(212, 175, 55, 0.4);
        }

        .btn-disabled {
            background: var(--medium-gray);
            color: var(--text-light);
            cursor: not-allowed;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 5rem;
            color: var(--medium-gray);
            margin-bottom: 30px;
        }

        .empty-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .empty-state p {
            font-size: 1.1rem;
            max-width: 500px;
            margin: 0 auto;
            line-height: 1.8;
        }

        /* Footer */
        .restaurant-footer {
            background: var(--charcoal);
            color: var(--warm-white);
            text-align: center;
            padding: 40px 20px;
            margin-top: 60px;
        }

        .footer-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--primary-gold);
            margin-bottom: 15px;
        }

        .footer-text {
            opacity: 0.8;
            line-height: 1.8;
        }

        /* Animations */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .restaurant-logo {
                font-size: 2.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .tables-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .booking-details {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .table-header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }

            .btn {
                min-width: 150px;
                padding: 12px 24px;
            }
        }

        @media (max-width: 480px) {
            .main-container {
                padding: 0 15px;
            }

            .restaurant-header {
                padding: 40px 15px;
            }

            .table-content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <header class="restaurant-header">
        <div class="header-content">
            <h1 class="restaurant-logo">The Golden Spoon</h1>
            <p class="restaurant-tagline">Fine Dining Experience</p>
            <h2 class="page-title">Đặt Bàn</h2>
            <p class="page-subtitle">Chọn bàn hoàn hảo cho trải nghiệm ẩm thực đáng nhớ của bạn</p>
        </div>
    </header>

    <main class="main-container">
        <c:if test="${not empty requestScope.success}">
            <section class="alerts-section">
                <div class="alert success">
                    <i class="fas fa-check-circle"></i>
                    <span><c:out value="${requestScope.success}"/></span>
                </div>
            </section>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <section class="alerts-section">
                <div class="alert error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span><c:out value="${requestScope.error}"/></span>
                </div>
            </section>
        </c:if>

        <c:if test="${not empty sessionScope.date || not empty sessionScope.startTime || not empty sessionScope.endTime || not empty sessionScope.people || not empty sessionScope.fullName || not empty sessionScope.message}">
            <section class="booking-summary">
                <div class="booking-header">
                    <h3><i class="fas fa-calendar-check"></i> Thông tin đặt bàn của bạn</h3>
                </div>
                <div class="booking-details">
                    <c:if test="${not empty sessionScope.date}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-calendar-alt"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Ngày</div>
                                <div class="booking-value"><c:out value="${sessionScope.date}"/></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.startTime}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-clock"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Giờ bắt đầu</div>
                                <div class="booking-value"><c:out value="${sessionScope.startTime}"/></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.endTime}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-clock"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Giờ kết thúc</div>
                                <div class="booking-value"><c:out value="${sessionScope.endTime}"/></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.people}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-users"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Số người</div>
                                <div class="booking-value"><c:out value="${sessionScope.people}"/> khách</div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.fullName}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-user"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Họ và tên</div>
                                <div class="booking-value"><c:out value="${sessionScope.fullName}"/></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.message}">
                        <div class="booking-item">
                            <div class="booking-icon"><i class="fas fa-comment"></i></div>
                            <div class="booking-text">
                                <div class="booking-label">Ghi chú đặc biệt</div>
                                <div class="booking-value"><c:out value="${sessionScope.message}"/></div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </section>
        </c:if>

        <section class="tables-section">
            <div class="section-header">
                <h2 class="section-title">Chọn Bàn Của Bạn</h2>
                <p class="section-subtitle">Mỗi bàn được thiết kế tỉ mỉ để mang đến không gian ăn uống thoải mái và sang trọng nhất</p>
            </div>

            <c:choose>
                <c:when test="${not empty rooms}">
                    <div class="tables-grid">
                        <c:forEach var="room" items="${rooms}">
                            <c:set var="isAvailable" value="${room.status == null || room.status == 'Ready' || room.status == 'Available'}"/>
                            <div class="table-card ${isAvailable ? 'available' : 'booked'}">
                                <div class="table-image">
                                    <i class="fas fa-utensils table-icon"></i>
                                </div>
                                <div class="table-content">
                                    <div class="table-header">
                                        <h3 class="table-name">Bàn <c:out value="${room.roomID}"/></h3>
                                        <span class="status-badge ${isAvailable ? 'available' : 'booked'}">
                                            <c:out value="${isAvailable ? 'Còn trống' : 'Đã đặt'}"/>
                                        </span>
                                    </div>
                                    <div class="table-info">
                                        <div class="info-row">
                                            <div class="info-label"><i class="fas fa-tag"></i> Loại bàn</div>
                                            <div class="info-value"><c:out value="${room.roomType}"/></div>
                                        </div>
                                        <div class="info-row">
                                            <div class="info-label"><i class="fas fa-users"></i> Sức chứa</div>
                                            <div class="info-value">Tối đa <c:out value="${room.maxCapacity}"/> người</div>
                                        </div>
                                    </div>
                                    <div class="table-action">
                                        <c:choose>
                                            <c:when test="${isAvailable}">
                                                <form action="${pageContext.request.contextPath}/BookTable/BookTable.jsp" method="get">
                                                    <input type="hidden" name="roomId" value="${room.roomID}"/>
                                                    <input type="hidden" name="people" value="${sessionScope.people}"/>
                                                    <input type="hidden" name="date" value="${sessionScope.date}"/>
                                                    <input type="hidden" name="startTime" value="${sessionScope.startTime}"/>
                                                    <input type="hidden" name="endTime" value="${sessionScope.endTime}"/>
                                                    <input type="hidden" name="message" value="${sessionScope.message}"/>
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fas fa-check"></i>
                                                        Chọn bàn này
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="btn btn-disabled">
                                                    <i class="fas fa-times"></i>
                                                    Không có sẵn
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <h3>Không tìm thấy bàn phù hợp</h3>
                        <p>Rất tiếc, hiện tại không có bàn nào phù hợp với yêu cầu của bạn. Vui lòng thử lại với thời gian khác hoặc liên hệ trực tiếp với nhà hàng để được hỗ trợ tốt nhất.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>

    <footer class="restaurant-footer">
        <div class="footer-content">
            <h4 class="footer-logo">The Golden Spoon</h4>
            <p class="footer-text">
                Cảm ơn bạn đã chọn nhà hàng chúng tôi. Chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất.
            </p>
        </div>
    </footer>
</body>
</html>