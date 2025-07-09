
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Menu</title>
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet"/>
  <style>
         .menu-filters {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .menu-filters li {
            cursor: pointer;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            color: #007bff;
            border: 1px solid #007bff;
            transition: 0.3s;
        }

        .menu-filters li.active,
        .menu-filters li:hover {
            background-color: #007bff;
            color: #fff;
        }

        .card {
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
 
        .card-img-top {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: .5rem;
            border-top-right-radius: .5rem;
        }
    /* ========== Menu Filters ========== */
    .menu-filters {
      list-style: none;
      padding: 0;
      margin: 0 0 2rem;
      display: flex;
      justify-content: center;
      gap: 1rem;
    }
    .menu-filters li {
      cursor: pointer;
      padding: .5rem 1rem;
      border-radius: 20px;
      font-weight: 500;
      color: #007bff;
      border: 1px solid #007bff;
      transition: .3s;
    }
    /* CHỈNH đây cho khớp class 'active' */
    .menu-filters li.active,
    .menu-filters li:hover {
      background-color: #007bff;
      color: #fff;
    }

    /* ========== Cards ========== */
    .card {
      box-shadow: 0 3px 8px rgba(0,0,0,0.05);
    }
    .card-img-top {
      height: 200px;
      object-fit: cover;
    }
  </style>
</head>
<body>

  <%@ include file="../includes/Nappar.jsp" %>

  <section id="menu" class="py-5">
    <div class="container text-center mb-4">
      <h2>Menu</h2>
      <p>Check Our Tasty Menu</p>
    </div>
       <form action="MenuServlet" method="get" class="search-box d-flex">
           
            <input type="text" name="search" class="form-control me-2" placeholder="Tìm món ăn...">
            <button type="submit" class="btn btn-outline-primary">🔍</button>
        </form>
    <ul class="menu-filters">
      <c:forEach items="${catelori}" var="o">
        <!-- xài 'active' để CSS khớp -->
        <li class="${tag == o.categoryID ? 'active' : ''}">
          <a class="text-decoration-none text-dark"
             href="MenuServlet?cid=${o.categoryID}">
            ${o.categoryName}
          </a>
        </li>
      </c:forEach>
    </ul>

    <div class="container">
      <div class="row gy-4">
     <c:forEach items="${menu}" var="o">
  <div class="col-lg-3 col-md-4 col-sm-6">
    <div class="card h-100 shadow-sm">
      <a href="${pageContext.request.contextPath}/MenuServlet?id=${o.foodID}">
        <img src="${o.image}" class="card-img-top" alt="${o.defaultFoodName}" />
      </a>

      <div class="card-body d-flex flex-column">
        <div class="d-flex justify-content-between align-items-center mb-2">
          <h5 class="card-title mb-0">${o.defaultFoodName}</h5>
          <span class="fw-bold text-danger" style="white-space: nowrap;">
            <fmt:formatNumber value="${o.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> ₫
          </span>
        </div>

        <p class="text-muted mb-3">${o.defaultIngredients}</p>

       <form action="CartServlet" method="post" class="mt-auto d-flex">
  <input type="hidden" name="foodId" value="${o.foodID}" />
  <input type="hidden" name="foodName" value="${o.defaultFoodName}" />
  <input type="hidden" name="image" value="${o.image}" />
  <input type="hidden" name="price" value="${o.price}" />
  <input type="number" name="quantity" class="form-control me-2" style="width: 80px;" value="1" min="1" />
  <button type="submit" class="btn btn-success">🛒</button>
</form>
      </div>
    </div>
  </div>
</c:forEach>
      </div>
    </div>
  </section>

  <script 
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
  </script>
</body>
</html>
