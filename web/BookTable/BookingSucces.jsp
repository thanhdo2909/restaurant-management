<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Bàn Thành Công - The Golden Spoon Restaurant</title>
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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

        /* Main Container */
        .main-container {
            flex: 1;
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Success/Error Container */
        .result-container {
            width: 100%;
            max-width: 700px;
            background: var(--warm-white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            border: 1px solid var(--medium-gray);
            animation: slideUp 0.8s ease-out;
        }

        .result-header {
            text-align: center;
            padding: 40px 30px;
            position: relative;
        }

        .result-header.success {
            background: linear-gradient(135deg, var(--success-green), #4CAF50);
            color: white;
        }

        .result-header.error {
            background: linear-gradient(135deg, var(--error-red), #E53935);
            color: white;
        }

        .result-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><defs><pattern id="pattern" width="40" height="40" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="200" height="200" fill="url(%23pattern)"/></svg>');
            opacity: 0.3;
        }

        .result-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            position: relative;
            z-index: 2;
        }

        .result-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            position: relative;
            z-index: 2;
        }

        .result-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
            max-width: 500px;
            margin: 0 auto;
        }

        .result-content {
            padding: 40px 30px;
        }

        .booking-details {
            background: var(--light-gray);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }

        .booking-details h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .booking-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .booking-item {
            background: var(--warm-white);
            padding: 20px;
            border-radius: 12px;
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
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .booking-text {
            flex: 1;
        }

        .booking-label {
            font-size: 0.85rem;
            color: var(--text-light);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 3px;
        }

        .booking-value {
            font-size: 1.05rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .error-message {
            background: #fff1f0;
            border: 1px solid #ffccc7;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
        }

        .error-message p {
            color: var(--error-red);
            font-size: 1.1rem;
            font-weight: 500;
            margin: 0;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
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
            color: var(--charcoal);
            text-decoration: none;
        }

        .btn-secondary {
            background: var(--charcoal);
            color: var(--warm-white);
            box-shadow: 0 4px 20px rgba(44, 44, 44, 0.3);
        }

        .btn-secondary:hover {
            background: #1a1a1a;
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(44, 44, 44, 0.4);
            color: var(--warm-white);
            text-decoration: none;
        }

        /* Footer */
        .restaurant-footer {
            background: var(--charcoal);
            color: var(--warm-white);
            text-align: center;
            padding: 40px 20px;
            margin-top: auto;
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
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
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

            .result-title {
                font-size: 2rem;
            }

            .main-container {
                padding: 40px 15px;
            }

            .result-content {
                padding: 30px 20px;
            }

            .booking-info {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                min-width: 200px;
            }
        }

        @media (max-width: 480px) {
            .restaurant-header {
                padding: 40px 15px;
            }

            .result-header {
                padding: 30px 20px;
            }

            .booking-details {
                padding: 20px;
            }

            .result-icon {
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>
    <header class="restaurant-header">
        <div class="header-content">
            <h1 class="restaurant-logo">The Golden Spoon</h1>
            <p class="restaurant-tagline">Fine Dining Experience</p>
        </div>
    </header>

    <main class="main-container">
        <div class="result-container">
            <c:choose>
                <c:when test="${not empty sessionScope.error}">
                    <!-- Error State -->
                    <div class="result-header error">
                        <div class="result-icon">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <h2 class="result-title">Đặt Bàn Thất Bại!</h2>
                        <p class="result-subtitle">Rất tiếc, có lỗi xảy ra trong quá trình đặt bàn của bạn</p>
                    </div>
                    
                    <div class="result-content">
                        <div class="error-message">
                            <p><c:out value="${sessionScope.error}"/></p>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/home/Home.jsp" class="btn btn-secondary">
                                <i class="fas fa-home"></i>
                                Trở về trang chủ
                            </a>
                            <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="btn btn-primary">
                                <i class="fas fa-redo"></i>
                                Thử lại
                            </a>
                        </div>
                    </div>
                </c:when>
                
                <c:when test="${not empty sessionScope.bookingRoomId}">
                    <!-- Success State -->
                    <div class="result-header success">
                        <div class="result-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h2 class="result-title">Đặt Bàn Thành Công!</h2>
                        <p class="result-subtitle">
                            Cảm ơn bạn đã đặt bàn tại <strong>The Golden Spoon</strong>. 
                            Chúng tôi đã nhận được yêu cầu của bạn và sẽ liên hệ xác nhận sớm nhất.
                        </p>
                    </div>
                    
                    <div class="result-content">
                        <div class="booking-details">
                            <h3>
                                <i class="fas fa-receipt"></i>
                                Chi tiết đặt bàn
                            </h3>
                            <div class="booking-info">
                                <div class="booking-item">
                                    <div class="booking-icon"><i class="fas fa-hashtag"></i></div>
                                    <div class="booking-text">
                                        <div class="booking-label">Mã bàn</div>
                                        <div class="booking-value"><c:out value="${sessionScope.bookingRoomId}"/></div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-icon"><i class="fas fa-calendar-alt"></i></div>
                                    <div class="booking-text">
                                        <div class="booking-label">Ngày</div>
                                        <div class="booking-value"><c:out value="${sessionScope.bookingDate}"/></div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-icon"><i class="fas fa-clock"></i></div>
                                    <div class="booking-text">
                                        <div class="booking-label">Giờ bắt đầu</div>
                                        <div class="booking-value"><c:out value="${sessionScope.bookingStartTime}"/></div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-icon"><i class="fas fa-clock"></i></div>
                                    <div class="booking-text">
                                        <div class="booking-label">Giờ kết thúc</div>
                                        <div class="booking-value"><c:out value="${sessionScope.bookingEndTime}"/></div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-icon"><i class="fas fa-users"></i></div>
                                    <div class="booking-text">
                                        <div class="booking-label">Số người</div>
                                        <div class="booking-value"><c:out value="${sessionScope.bookingPeople}"/> khách</div>
                                    </div>
                                </div>
                                
                                <c:if test="${not empty sessionScope.bookingFullName}">
                                    <div class="booking-item">
                                        <div class="booking-icon"><i class="fas fa-user"></i></div>
                                        <div class="booking-text">
                                            <div class="booking-label">Họ tên khách</div>
                                            <div class="booking-value"><c:out value="${sessionScope.bookingFullName}"/></div>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty sessionScope.bookingPhone}">
                                    <div class="booking-item">
                                        <div class="booking-icon"><i class="fas fa-phone"></i></div>
                                        <div class="booking-text">
                                            <div class="booking-label">Số điện thoại</div>
                                            <div class="booking-value"><c:out value="${sessionScope.bookingPhone}"/></div>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty sessionScope.bookingMessage}">
                                    <div class="booking-item">
                                        <div class="booking-icon"><i class="fas fa-comment"></i></div>
                                        <div class="booking-text">
                                            <div class="booking-label">Ghi chú</div>
                                            <div class="booking-value"><c:out value="${sessionScope.bookingMessage}"/></div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/home/Home.jsp" class="btn btn-primary">
                                <i class="fas fa-home"></i>
                                Quay về trang chủ
                            </a>
                        </div>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <!-- No Data State -->
                    <div class="result-header error">
                        <div class="result-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <h2 class="result-title">Có Lỗi Xảy Ra</h2>
                        <p class="result-subtitle">Không tìm thấy thông tin đặt bàn. Vui lòng thử lại.</p>
                    </div>
                    
                    <div class="result-content">
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/home/Home.jsp" class="btn btn-secondary">
                                <i class="fas fa-home"></i>
                                Trở về trang chủ
                            </a>
                            <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="btn btn-primary">
                                <i class="fas fa-calendar-plus"></i>
                                Đặt bàn mới
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="restaurant-footer">
        <div class="footer-content">
            <h4 class="footer-logo">The Golden Spoon</h4>
            <p class="footer-text">
                Cảm ơn bạn đã chọn nhà hàng chúng tôi. Chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất.
            </p>
        </div>
    </footer>

    <!-- Clean up session attributes -->
    <c:remove var="error" scope="session"/>
    <c:remove var="bookingRoomId" scope="session"/>
    <c:remove var="bookingPeople" scope="session"/>
    <c:remove var="bookingDate" scope="session"/>
    <c:remove var="bookingStartTime" scope="session"/>
    <c:remove var="bookingEndTime" scope="session"/>
    <c:remove var="bookingMessage" scope="session"/>
    <c:remove var="bookingFullName" scope="session"/>
    <c:remove var="bookingPhone" scope="session"/>
</body>
</html>