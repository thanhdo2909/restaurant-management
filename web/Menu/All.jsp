<%-- 
    Document   : All
    Created on : May 13, 2025, 10:25:40 PM
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
 <style>
/* ========== Navbar Styling ========== */
nav {
    background-color: #ffffff;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    padding: 0.8rem 2rem;
}

.navbar-brand {
    font-size: 1.8rem;
    font-weight: bold;
    color: #2c3e50;
}

.nav-link {
    color: #444;
    font-weight: 500;
    margin-right: 1rem;
    transition: all 0.3s ease;
}

.nav-link:hover,
.nav-link.active {
    color: #007bff;
    text-decoration: underline;
}

/* Button in Navbar */
.navbar .btn {
    background-color: #007bff;
    color: #fff;
    padding: 0.4rem 1.2rem;
    border-radius: 20px;
    font-weight: bold;
    transition: background-color 0.3s;
}

.navbar .btn:hover {
    background-color: #0056b3;
}

/* ========== Section Title ========== */
.section-title {
    text-align: center;
    margin-bottom: 3rem;
}

.section-title h2 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #222;
}

.section-title p {
    color: #777;
    font-size: 1.1rem;
}

/* ========== Menu Filters ========== */
.menu-filters {
    list-style: none;
    padding: 0;
    margin: 0 0 2rem 0;
    display: flex;
    justify-content: center;
    gap: 1rem;
}

.menu-filters li {
    cursor: pointer;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 500;
    color: #007bff;
    border: 1px solid #007bff;
    transition: all 0.3s ease;
}

.menu-filters li:hover,
.menu-filters .filter-active {
    background-color: #007bff;
    color: #fff;
}

/* ========== Menu Items ========== */
.menu-item {
    background-color: #f9f9f9;
    padding: 1.2rem;
    margin-bottom: 2rem;
    border-radius: 10px;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s;
}

.menu-item:hover {
    transform: scale(1.02);
}

.menu-img {
    width: 100%;
    border-radius: 8px;
    margin-bottom: 1rem;
}

.menu-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
    font-size: 1.1rem;
    color: #333;
}

.menu-ingredients {
    color: #666;
    font-size: 0.95rem;
    margin-top: 0.5rem;
}

/* ========== Responsive Adjustments ========== */
@media (max-width: 768px) {
    .menu-content {
        flex-direction: column;
        align-items: flex-start;
    }

    .menu-content span {
        margin-top: 0.5rem;
    }
}
.menu-img {
  width: 100%;
  height: 200px;
  object-fit: cover; /* Giúp cắt ảnh đẹp mà không méo */
  border-radius: 10px;
}
</style>

            </style>
    </head>
    <body>
   <%@ include file="../includes/Nappar.jsp" %>

      <section id="menu" class="menu section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Menu</h2>
        <p>Check Our Tasty Menu</p>
      </div><!-- End Section Title -->

      <div class="container isotope-layout" data-default-filter="*" data-layout="masonry" data-sort="original-order">
          <div class="row" data-aos="fade-up" data-aos-delay="100">
  <div class="col-lg-12 d-flex justify-content-center">
    <ul class="menu-filters isotope-filters d-flex flex-wrap list-unstyled gap-2">
      <c:forEach items="${catelori}" var="o">
        <li class="${tag == o.categoryID ? 'active1' : ''}">
          <a class="nav-link category-link" href="MenuServlet?cid=${o.categoryID}">
            ${o.categoryName}
          </a>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>
        <div class="row">
 <div class="row">
  <c:forEach items="${menu}" var="o">
      
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <img src="${o.image}" class="card-img-top img-fluid" style="height: 200px; object-fit: cover;" alt="">
        <div class="card-body d-flex flex-column justify-content-between">
          <div>
            <div class="menu-content d-flex justify-content-between mb-2">
              <a href="#" class="text-primary fw-bold">${o.defaultFoodName}</a>
              <span>${o.price}</span>
            </div>
            <div class="menu-ingredients text-muted mb-3">
              ${o.defaultIngredients}
            </div>
          </div>
          
          <!-- Quantity + Add to cart -->
         <form action="CartServlet" method="post">
<!--    <input type="hidden" name="mess" value="${mess}">-->
    <input type="hidden" name="roomId" value="${roomId}">
  <input type="hidden" name="foodId" value="${o.foodID}">
  <input type="hidden" name="foodName" value="${o.defaultFoodName}">
  <input type="hidden" name="image" value="${o.image}">
  <input type="hidden" name="price" value="${o.price}">
  
  <div class="input-group" style="width: 120px;">
    <input type="number" name="quantity" class="form-control" value="1" min="1">
    <button type="submit" class="btn btn-success">🛒</button>
  </div>
</form>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

</div>

        </div>
      </div>
    </section>
    </body>
</html>
