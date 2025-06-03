<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi Tài Khoản</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            form {
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                width: 300px;
            }

            input[type="text"] {
                margin-bottom: 15px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            input[type="text"]:focus {
                border-color: #4CAF50;
                outline: none;
            }

            button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #45a049;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/ProfileServlet" method="get">
            <h2>Đổi Tài Khoản</h2>
            <input type="hidden" name="action" value="ForgetPass">
            <input type="text" placeholder="Nhập tài của bạn" name="taikhoan" required>
            <button type="submit">Xác nhận</button>
        </form>
    </body>
</html>
