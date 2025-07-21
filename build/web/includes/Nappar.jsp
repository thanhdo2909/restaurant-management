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
            }
            .topbar .contact-info i,
            .topbar .contact-info a,
            .topbar .contact-info span {
                color: #333;
                margin-right: 15px;
            }
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

            .btn-book-a-table {
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                font-weight: bold;
                text-decoration: none;
                transition: 0.3s;
            }

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
