<%-- 
    Document   : favoriteFoods
    Created on : Jul 16, 2025, 2:06:11 PM
    Author     : ACER
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Món ăn yêu thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
     <%@ include file="../includes/Nappar.jsp" %>
<div class="container my-5">
    <h2 class="mb-4">🍽️ Món ăn yêu thích</h2>

    <div class="row g-4">
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

                        <!-- Add to Cart Form -->
                        <form action="CartServlet" method="post" class="d-flex mb-2">
                            <input type="hidden" name="foodId" value="${o.foodID}" />
                            <input type="hidden" name="foodName" value="${o.defaultFoodName}" />
                            <input type="hidden" name="image" value="${o.image}" />
                            <input type="hidden" name="price" value="${o.price}" />
                            <input type="number" name="quantity" class="form-control me-2" style="width: 80px;" value="1" min="1" />
                            <button type="submit" class="btn btn-success">🛒</button>
                        </form>

                        <!-- Remove Favorite Button -->
                        <form action="FavoriteServlet" method="post" class="text-end">
                            <input type="hidden" name="action" value="remove" />
                            <input type="hidden" name="foodId" value="${o.foodID}" />
                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                ❌ Bỏ yêu thích
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
