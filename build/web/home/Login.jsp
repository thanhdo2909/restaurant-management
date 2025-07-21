<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login & Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --dark-gold: #B8941F;
            --light-gold: #F4E7B8;
            --charcoal: #2C2C2C;
            --warm-white: #FEFEFE;
            --light-gray: #F8F8F8;
            --medium-gray: #E0E0E0;
            --text-dark: #333333;
            --text-light: #666666;
            --accent-red: #8B0000;
            --success-green: #2E7D32;
        }

        body {
            background: linear-gradient(135deg, var(--light-gray), #e9ecef);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .container {
            max-width: 450px;
            background: var(--warm-white);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            border: 1px solid var(--medium-gray);
            position: relative;
            overflow: hidden;
        }

        h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 600;
            color: var(--charcoal);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        h3::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 2px;
        }

        .form-switch {
            text-align: center;
            margin-top: 20px;
            font-size: 0.95rem;
            color: var(--text-light);
        }

        .form-switch a {
            color: var(--primary-gold);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .form-switch a:hover {
            color: var(--dark-gold);
            text-decoration: underline;
        }

        .alert {
            margin-top: 15px;
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            border: 1px solid var(--medium-gray);
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-gold);
            box-shadow: 0 0 8px rgba(212, 175, 55, 0.3);
            outline: none;
        }

        .form-check-input {
            border: 1px solid var(--medium-gray);
            border-radius: 4px;
        }

        .form-check-input:checked {
            background-color: var(--primary-gold);
            border-color: var(--primary-gold);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.4s ease;
            width: 100%;
            color: var(--charcoal);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(212, 175, 55, 0.4);
            color: var(--warm-white);
        }

        .btn-success {
            background: var(--success-green);
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.4s ease;
            width: 100%;
            color: var(--warm-white);
        }

        .btn-success:hover {
            background: #1B5E20;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        }

        .google-login-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #db4437;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            text-decoration: none;
            margin-top: 15px;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .google-login-btn:hover {
            background-color: #c1351d;
            text-decoration: none;
            color: white;
        }

        .google-login-btn img {
            width: 20px;
            margin-right: 10px;
        }
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
                <input type="text" name="username" class="form-control" value="${cookie.name != null ? cookie.name.value : ''}" placeholder="Enter your username" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" value="${cookie.pass != null ? cookie.pass.value : ''}" placeholder="Enter your password" required>
            </div>
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember Me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <a class="google-login-btn" href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:9999/quan_ly_nha_hang/home/Home.jsp&response_type=code&client_id=699392886816-j6212kjvnv15d5njg55emslgb50ta4ub.apps.googleusercontent.com&approval_prompt=force">
            <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google logo">
            Login with Google
        </a>
        <p class="form-switch"><a href="${pageContext.request.contextPath}/home/ForgetPass.jsp" onclick="toggleForm()">Quên mật khẩu</a></p>
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