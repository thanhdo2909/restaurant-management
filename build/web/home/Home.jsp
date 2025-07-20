<%-- 
    Document   : home
    Created on : May 13, 2025, 9:27:57 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    /* HERO SECTION */
    #hero {
        position: relative;
        height: 100vh; /* Chiều cao bằng 100% chiều cao màn hình */
        padding-top: 120px; /* Dịch xuống dưới header */
        background-color: #000;
        color: #fff;
        overflow: hidden;
    }

    #hero img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover; /* Ảnh tự co để phủ hết khung */
        z-index: 1;
        opacity: 0.6;
    }

    #hero .container {
        position: relative;
        z-index: 2;
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 100%;
    }

    #hero h2 {
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    #hero h2 span {
        color: #ffc107;
    }

    #hero p {
        font-size: 18px;
        margin-bottom: 30px;
    }

    #hero .cta-btn {
        background-color: #ffc107;
        color: #000;
        padding: 10px 25px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        margin-right: 15px;
        transition: background-color 0.3s ease;
    }

    #hero .cta-btn:hover {
        background-color: #e0a800;
        color: #fff;
    }
</style>
    </head>
    <body>
        <div>
            <%@ include file="../includes/Nappar.jsp" %> <%-- Sửa lỗi chính tả từ Nappar.jsp thành Navbar.jsp --%>
        </div>

        <section id="hero" class="hero section dark-background">
            <img src="assets/img/hero-bg.jpg" alt="" data-aos="fade-in">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 d-flex flex-column align-items-center align-items-lg-start">
                        <h2 data-aos="fade-up" data-aos-delay="100">Welcome to <span>Restaurantly</span></h2>
                        <p data-aos="fade-up" data-aos-delay="200">Delivering great food for more than 18 years!</p>
                        <div class="d-flex mt-4" data-aos="fade-up" data-aos-delay="300">
                            <a href="${pageContext.request.contextPath}/MenuServlet" class="cta-btn">Our Menu</a>
                            <a href="${pageContext.request.contextPath}/ViewRoomsServlet" class="cta-btn">TABLE</a>
                            <a href="${pageContext.request.contextPath}/AdminViewTableServlet" class="cta-btn">View Table for Admin</a>
                                <c:if test="${not empty sessionScope.accountId}">
                            <a href="${pageContext.request.contextPath}/CustomerViewBookingServlet" class="cta-btn">Xem và Hủy Booking</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>