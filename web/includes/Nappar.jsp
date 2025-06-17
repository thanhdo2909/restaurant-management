<%-- 
    Document   : Home
    Created on : May 13, 2025, 8:38:16 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Topbar */
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

            .topbar .languages ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex;
            }

            .topbar .languages li {
                margin-left: 10px;
                color: #333;
            }

            .topbar .languages li a {
                text-decoration: none;
                color: #007bff;
            }

            /* Branding */
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

            /* Nav Menu */
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

            #navmenu ul li a:hover{
                color: #007bff;
            }

            /* Dropdowns */
            .dropdown ul {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                background: #fff;
                padding: 10px 0;
                border: 1px solid #ddd;
                z-index: 1000;
                min-width: 180px;
            }

            .dropdown:hover ul {
                display: block;
            }

            .dropdown ul li {
                width: 100%;
                margin: 0;
            }

            .dropdown ul li a {
                display: block;
                padding: 8px 15px;
                color: #212529;
            }

            .dropdown ul li a:hover {
                background-color: #f8f9fa;
            }

            /* Button */
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
        </style>


    </head>
    <body>

    <body class="index-page">

        <header id="header" class="header fixed-top">

            <div class="topbar d-flex align-items-center">
                <div class="container d-flex justify-content-center justify-content-md-between">
                    <div class="contact-info d-flex align-items-center">
                        <i class="bi bi-envelope d-flex align-items-center"><a href="mailto:contact@example.com">contact@example.com</a></i>
                        <i class="bi bi-phone d-flex align-items-center ms-4"><span>+1 5589 55488 55</span></i>
                    </div>
                    <div class="languages d-none d-md-flex align-items-center">
                        <!--
                      <ul>
                        <li>En</li>
                        <li><a href="#">De</a></li>
                      </ul>-->
                    </div>
                </div>
            </div><!-- End Top Bar -->

            <div class="branding d-flex align-items-cente">

                <div class="container position-relative d-flex align-items-center justify-content-between">
                    <a href="index.html" class="logo d-flex align-items-center me-auto me-xl-0">
                        <!-- Uncomment the line below if you also wish to use an image logo -->
                        <!-- <img src="assets/img/logo.png" alt=""> -->
                        <h1 class="sitename">Restaurantly</h1>
                    </a>

                    <nav id="navmenu" class="navmenu">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/home/Home.jsp" class="active">Home<br></a></li>
                            <li><a href="${pageContext.request.contextPath}/home/About.jsp">About</a></li>
                            <li><a href="${pageContext.request.contextPath}/MenuServlet">Menu</a></li>
                            <li><a class="nav-link" href="${pageContext.request.contextPath}/Menu/Cart.jsp">🛒 Giỏ hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/orderHistoryServlet">lịch sử mua </a></li>
                            <li><a href="${pageContext.request.contextPath}/NotificationServlet">🔔</a></li>
                            <li><a href="${pageContext.request.contextPath}/home/profile.jsp">Profile</a></li>
                            <li class="dropdown"><a href="#"><span>Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                    <%--  <ul>
                                      <li><a href="#">Dropdown 1</a></li>
                                     
                                      <li class="dropdown"><a href="#"><span>Deep Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                        <ul>
                                          <li><a href="#">Deep Dropdown 1</a></li>
                                          <li><a href="#">Deep Dropdown 2</a></li>
                                          <li><a href="#">Deep Dropdown 3</a></li>
                                          <li><a href="#">Deep Dropdown 4</a></li>
                                          <li><a href="#">Deep Dropdown 5</a></li>
                                        </ul>
                                      </li>
                                      <li><a href="#">Dropdown 2</a></li>
                                      <li><a href="#">Dropdown 3</a></li>
                                      <li><a href="#">Dropdown 4</a></li>
                                    </ul>
                                  </li>
                                    --%>
                            <li><a href="#contact">Contact</a></li>
                        </ul>
                        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                        
                    </nav>
                                    <button class="btn btn-success btn-sm" onclick="addToCart('${o.defaultFoodName}')">🛒</button>

                    <a class="btn-book-a-table d-none d-xl-block" href="${pageContext.request.contextPath}/BookTable/BookTable.jsp">Book a Table</a>
                    <c:if test="${sessionScope.account == null}" >
                        <div> <a class="nav-link" href="${pageContext.request.contextPath}/home/Login.jsp" title="View Product" >Login</a></div>
                    </c:if>
                    <c:if test="${sessionScope.account != null}" >
                        <div> <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet" title="View Product" >Logout</a></div>
                    </c:if>

                </div>

            </div>

        </header>
    </body>
</html>
