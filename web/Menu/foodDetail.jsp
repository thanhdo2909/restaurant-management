<%-- 
    Document   : foodDetail
    Created on : Jun 15, 2025, 8:13:26 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${food.defaultFoodName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
          .card-img-top {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: .5rem;
            border-top-right-radius: .5rem;
        }
        .food-img {
            max-height: 450px;
            object-fit: cover;
            border-radius: 10px;
        }
        .price-tag {
            font-size: 24px;
            color: #dc3545;
            font-weight: bold;
            white-space: nowrap;
        }
        .btn-order {
            font-size: 18px;
            padding: 10px 25px;
        }
               body {
    padding-top: 120px;
}

    </style>
</head>
<body>

<%@ include file="../includes/Nappar.jsp" %>

<div class="container py-5">
    <div class="row align-items-center">
        <!-- Hình ảnh món ăn -->
        <div class="col-md-6 mb-4 mb-md-0">
            <img src="${food.image}" alt="${food.defaultFoodName}" class="img-fluid food-img shadow" />
        </div>

        <!-- Thông tin món ăn -->
        <div class="col-md-6">
            <h2 class="mb-3">${food.defaultFoodName}</h2>
            <p class="text-muted mb-3">${food.defaultIngredients}</p>
            <div class="price-tag mb-4">
                <fmt:formatNumber value="${food.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> ₫
            </div>

            <form action="${pageContext.request.contextPath}/CartServlet" method="post" class="d-flex align-items-center">
                <input type="hidden" name="foodId" value="${food.foodID}" />
                <input type="number" name="quantity" value="1" min="1" class="form-control me-3" style="width: 100px;" />
                <button type="submit" class="btn btn-success btn-order">🛒 Thêm vào giỏ</button>
            </form>
        </div>
    </div>
                <hr class="my-5" />
<!-- Danh sách bình luận -->
<div class="mt-4">
    <h4 class="mb-4">💬 Bình luận</h4>
    
    <c:choose>
        <c:when test="${not empty review}">
            <c:forEach var="r" items="${review}">   
                <div class="mb-3 p-3 border rounded bg-light">
                    <strong>${account.fullName}</strong> - 
                    <span class="text-warning">★ ${r.rating}/5</span>
                    <div class="text-muted" style="font-size: 0.9rem;">
                        <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    </div>
                    <p class="mb-0 mt-2">${r.comment}</p>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>Chưa có bình luận nào cho món ăn này.</p>
        </c:otherwise>
    </c:choose>
</div>

<!-- Form thêm bình luận -->
<c:if test="${not empty sessionScope.account}">
    <div class="mt-4">
        <h5>Viết bình luận của bạn</h5>
        <form action="${pageContext.request.contextPath}/ReviewServlet" method="post">
            <input type="hidden" name="foodId" value="${food.foodID}" />
            <div class="mb-3">
                <label for="rating" class="form-label">Đánh giá (1 - 5 sao):</label>
                <select name="rating" id="rating" class="form-select" style="width: 100px;">
                    <c:forEach var="i" begin="1" end="5">
                        <option value="${i}">${i}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="comment" class="form-label">Bình luận:</label>
                <textarea name="comment" id="comment" rows="3" class="form-control" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Gửi bình luận</button>
        </form>
    </div>
</c:if>
<c:if test="${empty sessionScope.account}">
    <p class="mt-4">🔒 <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a> để viết bình luận.</p>
</c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

