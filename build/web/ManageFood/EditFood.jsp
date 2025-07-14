<%-- 
    Document   : EditFood
    Created on : Jul 10, 2025, 9:41:53 AM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa món ăn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            padding-top: 50px;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="container">
    <h3 class="text-center mb-4">Sửa món ăn</h3>

    <form action="${pageContext.request.contextPath}/ManageFoodServlet" method="post" enctype="multipart/form-data">
        <!-- Hidden fields -->
        <input type="hidden" name="purpose" value="editfood">
        <input type="hidden" name="foodID" value="${food.foodID}">
        <input type="hidden" name="oldImage" value="${food.image}">

        <!-- Tên món ăn -->
        <div class="mb-3">
            <label class="form-label">Tên món ăn</label>
            <input type="text" name="defaultFoodName" class="form-control" required value="${food.defaultFoodName}">
        </div>

        <!-- Nguyên liệu -->
        <div class="mb-3">
            <label class="form-label">Nguyên liệu</label>
            <textarea name="defaultIngredients" class="form-control" rows="3" required>${food.defaultIngredients}</textarea>
        </div>

        <!-- Giá -->
        <div class="mb-3">
            <label class="form-label">Giá (VNĐ)</label>
            <input type="number" name="price" class="form-control" min="0" step="1000" required value="${food.price}">
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label class="form-label">Mô tả món ăn</label>
            <textarea name="description" class="form-control" rows="3">${food.description}</textarea>
        </div>

        <!-- Danh mục -->
        <div class="mb-3">
            <label class="form-label">Danh mục món ăn</label>
            <select name="categoryID" class="form-select" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryID}" 
                            <c:if test="${cat.categoryID == food.categoryID}">selected</c:if>>
                        ${cat.categoryName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Ảnh món ăn -->
        <div class="mb-3">
            <label class="form-label">Ảnh món ăn hiện tại</label><br>
            <img src="${pageContext.request.contextPath}/${food.image}" alt="Ảnh món ăn" width="120" class="mb-2">
            <input type="file" name="image" class="form-control" accept="image/*">
            <small class="text-muted">Để trống nếu không muốn thay ảnh.</small>
        </div>

        <!-- Nút -->
        <button type="submit" class="btn btn-warning w-100">Lưu thay đổi</button>
    </form>
</div>

</body>
</html>
