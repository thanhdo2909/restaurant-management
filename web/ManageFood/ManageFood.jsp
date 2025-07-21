<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý món ăn và danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            padding-top: 40px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .table img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }
        .card {
            margin-bottom: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
<div class="container">

    <!-- Món ăn -->
    <div class="card">
        <div class="card-body">
            <div class="section-header">
                <h4>Món ăn</h4>
                <a href="${pageContext.request.contextPath}/ManageFoodServlet?purpose=addfood" class="btn btn-success">+ Thêm món ăn</a>
            </div>
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên món</th>
                    <th>Nguyên liệu</th>
                    <th>Giá</th>
                    <th>Mô tả</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="food" items="${foodList}">
                    <tr>
                        <td><img src="${food.image}" alt="Food Image"></td>
                        <td>${food.defaultFoodName}</td>
                        <td>${food.defaultIngredients}</td>
                        <td>${food.price}</td>
                        <td>${food.description}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/ManageFoodServlet?purpose=edit&id=${food.foodID}" class="btn btn-sm btn-primary">Sửa</a>
                            <a href="${pageContext.request.contextPath}/ManageFoodServlet?purpose=delete&foodID=${food.foodID}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xoá món ăn này?');">Xoá</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Danh mục món ăn -->
    <div class="card">
        <div class="card-body">
            <div class="section-header">
                <h4>Danh mục món ăn</h4>
                <a href="AddCategoryServlet" class="btn btn-success">+ Thêm danh mục</a>
            </div>
            <table class="table table-bordered align-middle">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cat" items="${categoryList}">
                    <tr>
                        <td>${cat.categoryID}</td>
                        <td>${cat.name}</td>
                        <td>
                            <a href="EditCategoryServlet?categoryID=${cat.categoryID}" class="btn btn-sm btn-primary">Sửa</a>
                            <a href="DeleteCategoryServlet?categoryID=${cat.categoryID}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xoá danh mục này?');">Xoá</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
