<%-- 
    Document   : AddFood
    Created on : Jul 9, 2025, 3:50:13 PM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm món ăn</title>
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
    <h3 class="text-center mb-4">Thêm món ăn mới</h3>

    <form action="${pageContext.request.contextPath}/ManageFoodServlet" method="post" enctype="multipart/form-data">
        <!-- Tên món ăn -->
        <input type="hidden" name="purpose"value="addfood">
        <div class="mb-3">
            <label class="form-label">Tên món ăn</label>
            <input type="text" name="defaultFoodName" class="form-control" required>
        </div>

        <!-- Nguyên liệu -->
        <div class="mb-3">
            <label class="form-label">Nguyên liệu</label>
            <textarea name="defaultIngredients" class="form-control" rows="3" required></textarea>
        </div>

        <!-- Giá -->
        <div class="mb-3">
            <label class="form-label">Giá (VNĐ)</label>
            <input type="number" name="price" class="form-control" min="0" step="1000" required>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label class="form-label">Mô tả món ăn</label>
            <textarea name="description" class="form-control" rows="3"></textarea>
        </div>

        <!-- Danh mục -->
        <div class="mb-3">
            <label class="form-label">Danh mục món ăn</label>
            <select name="categoryID" class="form-select" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryID}">${cat.categoryName}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Ảnh món ăn -->
        <div class="mb-3">
            <label class="form-label">Ảnh món ăn</label>
            <input type="file" name="image" class="form-control" accept="image/*" required>
        </div>

        <!-- Nút -->
        <button type="submit" class="btn btn-primary w-100">Thêm món ăn</button>
    </form>
</div>

</body>
</html>
