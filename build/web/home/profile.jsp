<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.Account" %>
<%
    Account user = (Account) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<% if ("true".equals(session.getAttribute("justUploaded"))) { %>
<script>
    setTimeout(() => {
        sessionStorage.setItem('imgRetry', 0);
        window.location.reload();
    }, 50);
</script>
<%
    session.removeAttribute("justUploaded");
} %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .profile-image {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #0d6efd;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .profile-image:hover {
            transform: scale(1.05);
        }

        #uploadForm {
            display: none;
        }

        @media (max-width: 768px) {
            .text-md-start {
                text-align: center !important;
            }
        }
    </style>

    <script>
        function toggleUpload() {
            const form = document.getElementById('uploadForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body class="bg-light">
 <%@ include file="../includes/Nappar.jsp" %>
<div class="container my-5">
    <div class="card shadow p-4">
        <div class="row g-4 align-items-center">
            <!-- Left: Avatar + upload -->
            <div class="col-md-4 text-center">
                <img src="<%= request.getContextPath() + "/" + user.getProfileImage().replace(" ", "%20") + "?v=" + System.currentTimeMillis() %>"
                     alt="Ảnh đại diện"
                     class="profile-image mb-3"
                     onclick="toggleUpload()" />

                <form id="uploadForm" action="${pageContext.request.contextPath}/ProfileServlet" method="post" enctype="multipart/form-data">
                    <input type="file" name="profileImage" accept="image/*" class="form-control mb-2" required>
                    <button type="submit" class="btn btn-primary btn-sm">Cập nhật ảnh</button>
                </form>
            </div>

            <!-- Right: Info -->
            <div class="col-md-8">
                <h3 class="mb-3">Thông tin cá nhân</h3>
                <div class="mb-2"><strong>Họ và tên:</strong> <%= user.getFullName() %></div>
                <div class="mb-2"><strong>Email:</strong> <%= user.getEmail() %></div>
                <div class="mb-2"><strong>Tài khoản:</strong> <%= user.getUsername() %></div>
                <div class="mb-2"><strong>Trạng thái:</strong> <%= user.getStatus() %></div>
                <div class="mb-2"><strong>Vai trò:</strong> <%= user.getRole() %></div>
                <div class="mb-4"><strong>Cấp độ:</strong> <%= user.getTierID() %></div>

                <div class="d-flex gap-3 flex-wrap">
                    <a href="${pageContext.request.contextPath}/home/Pass.jsp" class="btn btn-outline-primary btn-sm">Đổi mật khẩu</a>
                    <a href="${pageContext.request.contextPath}/home/Account.jsp" class="btn btn-outline-secondary btn-sm">Đổi tài khoản</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
