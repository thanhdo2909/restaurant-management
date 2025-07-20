<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Bàn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
    <div class="container mt-5 text-center">
        <h2>Thông Tin Bàn</h2>
        <p>Bạn đang ở Bàn <%= request.getAttribute("roomId") %></p>
        <a href="/quan_ly_nha_hang/home/Home.jsp" class="btn btn-primary mt-3">Quay lại Home</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>s