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
    // Reload lại sau 500ms để đảm bảo ảnh đã ghi xong
    setTimeout(() => {
        sessionStorage.setItem('imgRetry', 0); // reset để tránh lặp
        window.location.reload();
    }, 50);
</script>
<%
    session.removeAttribute("justUploaded"); // Xóa flag sau khi reload
} %>
<html>
<head>
    <title>Trang cá nhân</title>
<!--    <script>
    const imgUrl = '../<%= user.getProfileImage() %>?v=' + Date.now();

    function checkImage(url) {
        const img = new Image();
        img.onload = function() {
            console.log("Ảnh tồn tại.");
        };
        img.onerror = function() {
            console.log("Ảnh chưa tồn tại, reload...");
            window.location.reload();
        };
        img.src = url;
    }

    checkImage(imgUrl);
</script>-->
    <style>
        
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            width: 400px;
            background-color: #fff;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            text-align: center;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #4CAF50;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .profile-image:hover {
            transform: scale(1.05);
        }

        .profile-info {
            text-align: left;
            margin-top: 20px;
        }

        .profile-info div {
            margin-bottom: 10px;
        }

        #uploadForm {
            display: none;
            margin-top: 20px;
            text-align: left;
        }

        #uploadForm input[type="file"] {
            margin-bottom: 10px;
        }

        #uploadForm button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        #uploadForm button:hover {
            background-color: #45a049;
        }
    </style>

    <script>
        function toggleUpload() {
            const form = document.getElementById('uploadForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>

<div class="profile-container">
    <h2>Thông tin cá nhân</h2>

    <!-- Ảnh đại diện -->
<img src="<%= request.getContextPath() + "/" + user.getProfileImage().replace(" ", "%20") + "?v=" + System.currentTimeMillis() %>"
     alt="Ảnh đại diện"
     class="profile-image"
     onclick="toggleUpload()" />


    <!-- Form upload ảnh -->
    <form id="uploadForm" action="${pageContext.request.contextPath}/ProfileServlet" method="post" enctype="multipart/form-data">
        <label for="profileImage">Chọn ảnh mới:</label><br/>
        <input type="file" name="profileImage" id="profileImage" accept="image/*" required /><br/>
        <button type="submit">Cập nhật ảnh đại diện</button>
    </form>

    <div class="profile-info">
        <div><b>Họ và tên:</b> <%= user.getFullName() %></div>
        <div><b>Email:</b> <%= user.getEmail() %></div>
        <div><b>Tên đăng nhập:</b> <%= user.getUsername() %></div>
        <div><b>Trạng thái:</b> <%= user.getStatus() %></div>
        <div><b>Vai trò:</b> <%= user.getRole() %></div>
        <div><b>Cấp độ:</b> <%= user.getTierID() %></div>
    </div>
    <a href="${pageContext.request.contextPath}/home/Pass.jsp"> đổi mật khẩu  </a>
     <a href="${pageContext.request.contextPath}/home/Account.jsp"> đổi tài khoản  </a>
   
</div>

</body>
</html>
