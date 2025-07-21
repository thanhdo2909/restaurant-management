<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Golden Spoon Restaurant - Trải Nghiệm Ẩm Thực Đẳng Cấp</title>
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

        /* Hero Section */
        .hero-section {
            position: relative;
            height: 100vh;
            background: linear-gradient(rgba(44, 44, 44, 0.7), rgba(44, 44, 44, 0.7)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23000" width="1200" height="800"/><rect fill="%23111" width="600" height="400" x="300" y="200" rx="20"/></svg>');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--warm-white);
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(ellipse at center, transparent 0%, rgba(0,0,0,0.4) 100%);
        }

        .hero-content {
            margin-top: 200px;
            position: relative;
            z-index: 2;
            max-width: 1000px;
            padding: 0 20px;
            animation: fadeInUp 1.2s ease-out;
        }

        .hero-logo {
            font-family: 'Playfair Display', serif;
            font-size: 4.5rem;
            font-weight: 700;
            color: var(--primary-gold);
            margin-bottom: 15px;
            text-shadow: 2px 2px 6px rgba(0,0,0,0.6);
            animation: slideDown 1s ease-out 0.3s both;
        }

        .hero-tagline {
            font-size: 1.4rem;
            font-weight: 300;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 40px;
            opacity: 0.9;
            animation: slideDown 1s ease-out 0.6s both;
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.2rem;
            font-weight: 600;
            margin-bottom: 25px;
            animation: slideDown 1s ease-out 0.9s both;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 50px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.8;
            animation: slideDown 1s ease-out 1.2s both;
        }

        .hero-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            animation: slideUp 1s ease-out 1.5s both;
            margin-top: -30px;
        }

        .hero-btn {
            padding: 18px 35px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-size: 1.1rem;
            min-width: 200px;
            font-family: 'Inter', sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .hero-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .hero-btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            box-shadow: 0 6px 25px rgba(212, 175, 55, 0.4);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 12px 40px rgba(212, 175, 55, 0.6);
            color: var(--warm-white);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: var(--warm-white);
            border: 2px solid var(--primary-gold);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: var(--primary-gold);
            color: var(--charcoal);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 12px 40px rgba(212, 175, 55, 0.4);
        }

        /* Features Section */
        .features-section {
            padding: 100px 0;
            background: var(--light-gray);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .section-header {
            text-align: center;
            margin-bottom: 80px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 20px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 4px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 2px;
        }

        .section-subtitle {
            font-size: 1.2rem;
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.8;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }

        .feature-card {
            background: var(--warm-white);
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid var(--medium-gray);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.15);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 25px;
            transition: transform 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .feature-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 15px;
        }

        .feature-description {
            color: var(--text-light);
            line-height: 1.8;
        }

        /* Quick Actions Section */
        .quick-actions {
            padding: 80px 0;
            background: var(--warm-white);
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .action-card {
            background: linear-gradient(135deg, var(--charcoal), #1a1a1a);
            color: var(--warm-white);
            padding: 35px 25px;
            border-radius: 20px;
            text-align: center;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .action-card:hover::before {
            opacity: 0.1;
        }

        .action-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .action-icon {
            font-size: 2.5rem;
            color: var(--primary-gold);
            margin-bottom: 20px;
            position: relative;
            z-index: 2;
        }

        .action-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 15px;
            position: relative;
            z-index: 2;
        }

        .action-description {
            opacity: 0.9;
            margin-bottom: 25px;
            line-height: 1.6;
            position: relative;
            z-index: 2;
        }

        .action-link {
            background: var(--primary-gold);
            color: var(--charcoal);
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            position: relative;
            z-index: 2;
        }

        .action-link:hover {
            background: var(--dark-gold);
            color: var(--warm-white);
            transform: translateY(-2px);
        }

        /* Footer */
        .restaurant-footer {
            background: var(--charcoal);
            color: var(--warm-white);
            text-align: center;
            padding: 60px 20px 30px;
            margin-top: 0;
        }

        .footer-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: var(--primary-gold);
            margin-bottom: 20px;
        }

        .footer-text {
            opacity: 0.8;
            line-height: 1.8;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .footer-social {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .social-link {
            width: 45px;
            height: 45px;
            background: rgba(212, 175, 55, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-gold);
            font-size: 1.2rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .social-link:hover {
            background: var(--primary-gold);
            color: var(--charcoal);
            transform: translateY(-2px);
        }

        .footer-copyright {
            border-top: 1px solid rgba(212, 175, 55, 0.3);
            padding-top: 20px;
            opacity: 0.6;
            font-size: 0.9rem;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

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

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-logo {
                font-size: 3rem;
            }

            .hero-title {
                font-size: 2.2rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }

            .hero-btn {
                min-width: 250px;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .features-grid,
            .actions-grid {
                grid-template-columns: 1fr;
                gap: 25px;
            }

            .feature-card,
            .action-card {
                padding: 30px 20px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 15px;
            }

            .hero-section {
                height: 90vh;
                padding: 0 15px;
            }

            .hero-logo {
                font-size: 2.5rem;
            }

            .hero-title {
                font-size: 1.8rem;
            }

            .hero-btn {
                min-width: 220px;
                padding: 15px 25px;
                font-size: 1rem;
            }
        }

        /* Loading Animation */
        .hero-content > * {
            opacity: 0;
        }

        .loaded .hero-content > * {
            animation-play-state: running;
        }
    </style>
</head>
<body>
    <div>
        <%@ include file="../includes/Nappar.jsp" %>
    </div>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1 class="hero-logo">The Golden Spoon</h1>
            <p class="hero-tagline">Fine Dining Experience</p>
            <h2 class="hero-title">Chào Mừng Đến Với Trải Nghiệm Ẩm Thực Đẳng Cấp</h2>
            <p class="hero-subtitle">
                Hơn 18 năm phục vụ những món ăn tinh tế và không gian sang trọng. 
                Chúng tôi cam kết mang đến cho bạn những khoảnh khắc ẩm thực đáng nhớ nhất.
            </p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/MenuServlet" class="hero-btn btn-primary">
                    <i class="fas fa-utensils"></i>
                    Thực Đơn
                </a>
                <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="hero-btn btn-secondary">
                    <i class="fas fa-calendar-plus"></i>
                    Đặt Bàn
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Tại Sao Chọn Chúng Tôi</h2>
                <p class="section-subtitle">
                    Chúng tôi tự hào mang đến trải nghiệm ẩm thực hoàn hảo với chất lượng dịch vụ xuất sắc
                </p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-award"></i>
                    </div>
                    <h3 class="feature-title">Chất Lượng Hàng Đầu</h3>
                    <p class="feature-description">
                        Nguyên liệu tươi ngon được chọn lọc kỹ càng, chế biến bởi những đầu bếp giàu kinh nghiệm
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="feature-title">Phục Vụ Nhanh Chóng</h3>
                    <p class="feature-description">
                        Đội ngũ nhân viên chuyên nghiệp, phục vụ tận tình và chu đáo trong không gian sang trọng
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-gem"></i>
                    </div>
                    <h3 class="feature-title">Không Gian Sang Trọng</h3>
                    <p class="feature-description">
                        Thiết kế tinh tế, âm nhạc nhẹ nhàng tạo nên không gian ấm cúng cho mọi dịp đặc biệt
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Actions Section -->
    <section class="quick-actions">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Dịch Vụ Của Chúng Tôi</h2>
                <p class="section-subtitle">
                    Khám phá các dịch vụ đa dạng và tiện ích dành riêng cho bạn
                </p>
            </div>
            <div class="actions-grid">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h3 class="action-title">Thực Đơn Đa Dạng</h3>
                    <p class="action-description">
                        Khám phá thực đơn phong phú với các món ăn từ truyền thống đến hiện đại
                    </p>
                    <a href="${pageContext.request.contextPath}/MenuServlet" class="action-link">
                        <i class="fas fa-arrow-right"></i>
                        Xem Thực Đơn
                    </a>
                </div>
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3 class="action-title">Đặt Bàn Online</h3>
                    <p class="action-description">
                        Dễ dàng đặt bàn trực tuyến, chọn thời gian và không gian phù hợp
                    </p>
                    <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="action-link">
                        <i class="fas fa-arrow-right"></i>
                        Đặt Bàn Ngay
                    </a>
                </div>
                <c:if test="${not empty sessionScope.accountId}">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-list-check"></i>
                    </div>
                    <h3 class="action-title">Quản Lý Đặt Bàn</h3>
                    <p class="action-description">
                        Xem lịch sử đặt bàn và quản lý các booking của bạn một cách dễ dàng
                    </p>
                    <a href="${pageContext.request.contextPath}/CustomerViewBookingServlet" class="action-link">
                        <i class="fas fa-arrow-right"></i>
                        Xem Booking
                    </a>
                </div>
                </c:if>
                <c:if test="${sessionScope.role == 'admin'}">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <h3 class="action-title">Quản Trị Hệ Thống</h3>
                    <p class="action-description">
                        Dành cho quản trị viên - Quản lý bàn ăn và booking của khách hàng
                    </p>
                    <a href="${pageContext.request.contextPath}/AdminViewTableServlet" class="action-link">
                        <i class="fas fa-arrow-right"></i>
                        Quản Trị
                    </a>
                </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="restaurant-footer">
        <div class="footer-content">
            <h4 class="footer-logo">The Golden Spoon</h4>
            <p class="footer-text">
                Cảm ơn bạn đã chọn nhà hàng chúng tôi. Chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất 
                với hương vị tinh tế và dịch vụ chuyên nghiệp.
            </p>
            <div class="footer-social">
                <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
            </div>
            <div class="footer-copyright">
                <p>&copy; 2025 The Golden Spoon Restaurant. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Add loading animation
        window.addEventListener('load', function() {
            document.body.classList.add('loaded');
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Parallax effect for hero background
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const parallax = document.querySelector('.hero-section');
            const speed = scrolled * 0.5;
            if (parallax) {
                parallax.style.transform = `translateY(${speed}px)`;
            }
        });
    </script>
</body>
</html>