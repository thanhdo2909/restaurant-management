<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Nhập mã OTP</title>
    <style>
       
    </style>
</head>
<body>
    <div class="container">
        <h1>Nhập mã OTP</h1>
        <form action="${pageContext.request.contextPath}/VerifyOTPServlet" method="post">
    <label>Nhập mã OTP đã gửi tới email của bạn:</label>
 
   <input type="hidden" name="purpose" value="${sessionScope.purpose}">

    <input type="text" name="otpCode" maxlength="6" required>
    <button type="submit">Xác nhận</button>
</form>

<c:if test="${not empty errorMessage}">
    <div style="color: red;">${errorMessage}</div>
</c:if>
    </div>
</body>
</html>