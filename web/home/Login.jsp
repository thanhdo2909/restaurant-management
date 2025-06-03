<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login & Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .container { max-width: 450px; margin-top: 60px; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); }
        h3 { margin-bottom: 25px; font-weight: 600; }
        .form-switch { text-align: center; margin-top: 20px; }
        .alert { margin-top: 10px; }
        .google-login-btn { display: flex; align-items: center; justify-content: center; background-color: #db4437; color: white; padding: 12px; border: none; border-radius: 6px; font-weight: 500; font-size: 16px; text-decoration: none; margin-top: 15px; transition: background-color 0.3s ease; }
        .google-login-btn:hover { background-color: #c1351d; text-decoration: none; color: white; }
        .google-login-btn img { width: 20px; margin-right: 10px; }
    </style>
</head>
<body>

<%
    String loginError = (String) request.getAttribute("loginError");
    String signupError = (String) request.getAttribute("signupError");
    boolean showSignup = request.getAttribute("showSignup") != null && (boolean) request.getAttribute("showSignup");
%>

<div class="container">
    <!-- Login Form -->
    <div id="login-form" style="<%= showSignup ? "display:none;" : "" %>">
        <h3 class="text-center">Login</h3>
        <% if (loginError != null) { %>
            <div class="alert alert-danger text-center"><%= loginError %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <input type="text" name="name" class="form-control" value="${cookie.name != null ? cookie.name.value : ''}" placeholder="Enter your username" required>
            </div>
            <div class="mb-3">
                <input type="password" name="pass" class="form-control" value="${cookie.pass != null ? cookie.pass.value : ''}" placeholder="Enter your password" required>
            </div>
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember Me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
           <a class="google-login-btn"
           href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:9999/quan_ly_nha_hang/home/Home.jsp&response_type=code&client_id=699392886816-j6212kjvnv15d5njg55emslgb50ta4ub.apps.googleusercontent.com&approval_prompt=force">
            <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google logo">
            Login with Google
        </a>
             <p class="form-switch"> <a href="${pageContext.request.contextPath}/home/ForgetPass.jsp" onclick="toggleForm()">quên mật khẩu </a></p>
        <p class="form-switch">Don't have an account? <a href="#" onclick="toggleForm()">Sign Up</a></p>
    </div>

    <!-- Signup Form -->
    <div id="signup-form" style="<%= showSignup ? "" : "display:none;" %>">
        <h3 class="text-center">Sign Up</h3>
        <% if (signupError != null) { %>
            <div class="alert alert-danger text-center"><%= signupError %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="register">
            <div class="mb-3"><input type="text" name="fullName" class="form-control" placeholder="Họ và tên" required></div>
            <div class="mb-3"><input type="email" name="email" class="form-control" placeholder="Email" required></div>
            <div class="mb-3"><input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" required></div>
            <div class="mb-3"><input type="password" name="password" class="form-control" placeholder="Mật khẩu" required></div>
            <div class="mb-3"><input type="password" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required></div>
            <div class="mb-3"><label for="profileImage">Ảnh đại diện:</label><input type="file" name="profileImage" class="form-control" accept="image/*"></div>
            <button type="submit" class="btn btn-success w-100">Sign Up</button>
        </form>
        <p class="form-switch">Already have an account? <a href="#" onclick="toggleForm()">Login</a></p>
    </div>
</div>

<script>
    function toggleForm() {
        const loginForm = document.getElementById("login-form");
        const signupForm = document.getElementById("signup-form");
        loginForm.style.display = loginForm.style.display === "none" ? "block" : "none";
        signupForm.style.display = signupForm.style.display === "none" ? "block" : "none";
    }
</script>
</body>
</html>
