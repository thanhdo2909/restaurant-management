<%-- 
    Document   : createAccount
    Created on : Jul 9, 2025, 11:43:05 AM
    Author     : ACER
--%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 480px;
            margin-top: 60px;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        h3 {
            margin-bottom: 25px;
            font-weight: 600;
        }
        .alert {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%
    String signupError = (String) request.getAttribute("signupError");
%>

<div class="container">
    <h3 class="text-center">Đăng ký tài khoản</h3>

    <% if (signupError != null) { %>
        <div class="alert alert-danger text-center"><%= signupError %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/ManagerAccountServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="purpose" value="register">
          
        <div class="mb-3">
            <input type="text" name="fullName" class="form-control" placeholder="Họ và tên" required>
        </div>

        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
        </div>

        <div class="mb-3">
            <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
        </div>

        <div class="mb-3">
            <input type="password" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required>
        </div>

        <div class="mb-3">
            <label for="profileImage" class="form-label">Ảnh đại diện:</label>
            <input type="file" name="profileImage" class="form-control" accept="image/*">
        </div>

        <!--  Chọn vai trò người dùng -->
        <div class="mb-3">
            <label class="form-label">Chọn loại tài khoản:</label>
            <select class="form-select" name="role" required>
                <option value="">-- Chọn vai trò --</option>
                <option value="shipper">Shipper</option>
                <option value="kitchen">Kitchen Manager</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success w-100">Đăng ký</button>
    </form>
</div>

</body>
</html>

