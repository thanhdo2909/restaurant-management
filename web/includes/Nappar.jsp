<<<<<<< HEAD
<%@ page import="Model.Account" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .topbar {
                background-color: #f8f9fa;
                font-size: 14px;
                padding: 10px 0;
=======
<%-- 
    Document   : Nappar
    Created on : Jul 21, 2025, 12:38:16 PM
    Author     : Your Name
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Golden Spoon - Navigation</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
        }

        /* Topbar */
        .topbar {
            background: var(--charcoal);
            color: var(--warm-white);
            font-size: 14px;
            padding: 12px 0;
            position: relative;
            z-index: 1000;
        }

        .topbar .contact-info i,
        .topbar .contact-info a,
        .topbar .contact-info span {
            color: var(--light-gold);
            margin-right: 20px;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .topbar .contact-info a:hover {
            color: var(--primary-gold);
        }

        .topbar .languages ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .topbar .languages li {
            margin-left: 15px;
            color: var(--light-gold);
            font-size: 0.9rem;
        }

        .topbar .languages li a {
            text-decoration: none;
            color: var(--primary-gold);
            transition: color 0.3s ease;
        }

        .topbar .languages li a:hover {
            color: var(--dark-gold);
        }

        /* Branding */
        .branding {
            background: var(--warm-white);
            border-bottom: 1px solid var(--medium-gray);
            padding: 20px 0;
            position: relative;
            z-index: 999;
        }

        .logo h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            color: var(--primary-gold);
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .logo h1:hover {
            transform: scale(1.05);
        }

        /* Nav Menu */
        #navmenu {
            margin-left: 50px;
        }

        #navmenu ul {
            list-style: none;
            display: flex;
            align-items: center;
            margin: 0;
            padding: 0;
        }

        #navmenu ul li {
            position: relative;
            margin-right: 25px;
        }

        #navmenu ul li a {
            text-decoration: none;
            color: var(--charcoal);
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            font-size: 1.1rem;
            padding: 10px 12px;
            transition: all 0.3s ease;
            position: relative;
        }

        #navmenu ul li a:hover,
        #navmenu ul li a.active {
            color: var(--primary-gold);
        }

        #navmenu ul li a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-gold);
            transition: width 0.3s ease;
        }

        #navmenu ul li a:hover::after,
        #navmenu ul li a.active::after {
            width: 100%;
        }

        /* Buttons */
        .btn-book-a-table {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            padding: 12px 25px;
            border-radius: 25px;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
        }

        .btn-book-a-table:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            color: var(--warm-white);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(212, 175, 55, 0.5);
        }

        .btn-cart {
            background: var(--success-green);
            color: var(--warm-white);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-cart:hover {
            background: #1B5E20;
            transform: translateY(-2px);
        }

        .nav-link.login-logout {
            color: var(--charcoal);
            font-weight: 500;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }

        .nav-link.login-logout:hover {
            color: var(--primary-gold);
        }

        /* Mobile Navigation Toggle */
        .mobile-nav-toggle {
            color: var(--charcoal);
            font-size: 1.5rem;
            cursor: pointer;
            display: none;
        }

        /* Responsive */
        @media (max-width: 992px) {
            #navmenu {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: var(--warm-white);
                padding: 20px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                z-index: 999;
            }

            #navmenu.active {
                display: block;
            }

            #navmenu ul {
                flex-direction: column;
                align-items: flex-start;
            }

            #navmenu ul li {
                margin: 10px 0;
            }

            .mobile-nav-toggle {
                display: block;
            }

            .btn-book-a-table {
                margin-top: 20px;
                display: block;
                text-align: center;
            }
        }

        @media (max-width: 576px) {
            .logo h1 {
                font-size: 2rem;
>>>>>>> f1aa0fb4a19fd9742b08b9e877f4e910992c2e7b
            }
            .topbar .contact-info i,
            .topbar .contact-info a,
            .topbar .contact-info span {
                margin-right: 10px;
                font-size: 0.85rem;
            }
<<<<<<< HEAD
            .branding {
                background-color: #fff;
                border-bottom: 1px solid #dee2e6;
                padding: 15px 0;
            }
            .logo h1 {
                font-size: 28px;
                font-weight: bold;
                margin: 0;
                color: #212529;
            }
            #navmenu {
                margin-left: 40px;
            }
            #navmenu ul {
                list-style: none;
                display: flex;
                margin: 0;
                padding: 0;
            }
            #navmenu ul li {
                position: relative;
                margin-right: 20px;
            }
            #navmenu ul li a {
                text-decoration: none;
                color: #212529;
                font-weight: 500;
                padding: 8px 10px;
                transition: 0.3s;
            }
            #navmenu ul li a:hover {
                color: #007bff;
            }
=======
>>>>>>> f1aa0fb4a19fd9742b08b9e877f4e910992c2e7b

            .btn-book-a-table {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
<<<<<<< HEAD

            .btn-book-a-table:hover {
                background-color: #0056b3;
            }

            .profile-wrapper {
                position: relative;
                margin-left: 20px;
            }

            .profile-wrapper img.avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #dee2e6;
                cursor: pointer;
            }

            .profile-dropdown {
                display: none;
                position: absolute;
                top: 50px;
                right: 0;
                background-color: white;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 10px 0;
                min-width: 200px;
                z-index: 1000;
            }

           

            .profile-dropdown a {
                display: block;
                padding: 10px 20px;
                font-size: 14px;
                color: #212529;
                text-decoration: none;
            }

            .profile-dropdown a:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body class="index-page">
        <header id="header" class="header fixed-top">
            <div class="topbar d-flex align-items-center">
                <div class="container d-flex justify-content-center justify-content-md-between">
                    <div class="contact-info d-flex align-items-center">
                        <i class="bi bi-envelope d-flex align-items-center"><a href="mailto:contact@example.com">contact@example.com</a></i>
                        <i class="bi bi-phone d-flex align-items-center ms-4"><span>+1 5589 55488 55</span></i>
                    </div>
                </div>
            </div>

            <div class="branding d-flex align-items-center">
                <div class="container position-relative d-flex align-items-center justify-content-between">
                    <a href="index.html" class="logo d-flex align-items-center me-auto me-xl-0">
                        <h1 class="sitename">Restaurantly</h1>
                    </a>

                    <nav id="navmenu" class="navmenu">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/home/Home.jsp" class="active">Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/home/About.jsp">About</a></li>
                            <li><a href="${pageContext.request.contextPath}/MenuServlet">Menu</a></li>
                            <li><a class="nav-link" href="${pageContext.request.contextPath}/Menu/Cart.jsp">🛒 Giỏ hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/NotificationServlet">🔔</a></li>
                            <li><a href="#contact">Contact</a></li>
                        </ul>
                    </nav>

                    <div class="d-flex align-items-center">
                        <a class="btn-book-a-table d-none d-xl-block me-3" href="${pageContext.request.contextPath}/BookTable/BookTable.jsp">Book a Table</a>

                        <c:choose>
                            <c:when test="${sessionScope.account == null}">
                                <a class="btn btn-outline-primary me-2" href="${pageContext.request.contextPath}/home/Login.jsp">Login</a>
                            </c:when>
                            <c:otherwise>
                                <div class="profile-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/${sessionScope.account.profileImage != null ? sessionScope.account.profileImage : 'default-avatar.png'}" alt="Avatar" class="avatar">
                                    <div class="profile-dropdown">
                                        <a href="${pageContext.request.contextPath}/home/profile.jsp"> Profile</a>
                                        <a href="${pageContext.request.contextPath}/favoriteFoodServlet">️ Món ăn yêu thích</a>
                                        <a href="${pageContext.request.contextPath}/orderHistoryServlet"> Lịch sử mua</a>
                                        <a href="${pageContext.request.contextPath}/LogoutServlet"> Đăng xuất</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

             
        </div>
    </div>
</div>
</header>
<script>
    const profileWrapper = document.querySelector('.profile-wrapper');
    const dropdown = document.querySelector('.profile-dropdown');

    let timeout;

    profileWrapper.addEventListener('mouseenter', () => {
        clearTimeout(timeout);
        dropdown.style.display = 'block';
    });

    profileWrapper.addEventListener('mouseleave', () => {
        timeout = setTimeout(() => {
            dropdown.style.display = 'none';
        }, 200); // thêm độ trễ để người dùng kịp bấm
    });

    dropdown.addEventListener('mouseenter', () => {
        clearTimeout(timeout);
    });

    dropdown.addEventListener('mouseleave', () => {
        timeout = setTimeout(() => {
            dropdown.style.display = 'none';
        }, 200);
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
        }
    </style>
</head>
<body>
    <header id="header" class="header fixed-top">
        <!-- Topbar -->
        <div class="topbar d-flex align-items-center">
            <div class="container d-flex justify-content-center justify-content-md-between">
                <div class="contact-info d-flex align-items-center">
                    <i class="fas fa-envelope d-flex align-items-center"><a href="mailto:contact@goldenspoon.com">contact@goldenspoon.com</a></i>
                    <i class="fas fa-phone d-flex align-items-center ms-4"><span>+84 123 456 789</span></i>
                </div>
                <div class="languages d-none d-md-flex align-items-center">
                    <ul>
                        <li>VN</li>
                        <li><a href="#">EN</a></li>
                    </ul>
                </div>
            </div>
        </div><!-- End Topbar -->

        <!-- Branding and Navigation -->
        <div class="branding d-flex align-items-center">
            <div class="container position-relative d-flex align-items-center justify-content-between">
                <a href="${pageContext.request.contextPath}/home/Home.jsp" class="logo d-flex align-items-center me-auto me-xl-0">
                    <h1 class="sitename">The Golden Spoon</h1>
                </a>

                <nav id="navmenu" class="navmenu">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home/Home.jsp" class="${pageContext.request.requestURI.contains('Home.jsp') ? 'active' : ''}">Trang Chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/home/About.jsp">Giới Thiệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/MenuServlet">Thực Đơn</a></li>
                        <li><a class="nav-link" href="${pageContext.request.contextPath}/Menu/Cart.jsp"><i class="fas fa-shopping-cart"></i> Giỏ Hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/orderHistoryServlet">Lịch Sử Mua</a></li>
                        <li><a href="${pageContext.request.contextPath}/NotificationServlet"><i class="fas fa-bell"></i> Thông Báo</a></li>
                        <li><a href="${pageContext.request.contextPath}/home/profile.jsp">Hồ Sơ</a></li>
                        <li><a href="#contact">Liên Hệ</a></li>
                    </ul>
                    <i class="mobile-nav-toggle d-xl-none fas fa-bars"></i>
                </nav>

                <a class="btn-book-a-table d-none d-xl-block" href="${pageContext.request.contextPath}/BookTable/roomMap.jsp">
                    <i class="fas fa-calendar-plus"></i> Đặt Bàn
                </a>

                <c:if test="${sessionScope.account == null}">
                    <a class="nav-link login-logout" href="${pageContext.request.contextPath}/home/Login.jsp">Đăng Nhập</a>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <a class="nav-link login-logout" href="${pageContext.request.contextPath}/LogoutServlet">Đăng Xuất</a>
                </c:if>
            </div>
        </div>
    </header>

    <script>
        // Mobile Navigation Toggle
        document.querySelector('.mobile-nav-toggle').addEventListener('click', function () {
            const nav = document.querySelector('#navmenu');
            nav.classList.toggle('active');
            this.classList.toggle('fa-bars');
            this.classList.toggle('fa-times');
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
    </script>
</body>
</html>
>>>>>>> f1aa0fb4a19fd9742b08b9e877f4e910992c2e7b
