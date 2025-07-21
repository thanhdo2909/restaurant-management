<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Quản Trị - Hệ Thống Nhà Hàng</title>
    <style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --light-color: #ecf0f1;
        --danger-color: #e74c3c;
        --success-color: #2ecc71;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9; /* Màu nền nhạt hơn */
        padding-top: 70px; /* Tăng thêm 10px nữa (từ 60px lên 70px) */
    }
    
    .header {
        background-color: var(--primary-color);
        color: white;
        padding: 0.8rem 1.5rem; /* Tăng padding ngang */
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.15); /* Đổ bóng đậm hơn */
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        height: 70px; /* Tăng từ 60px lên 70px */
    }
    
    .header h2 {
        margin: 0;
        font-size: 1.5rem;
        font-weight: 600;
    }
    
    .sidebar {
        width: 250px;
        background-color: white;
        position: fixed;
        top: 70px; /* Điều chỉnh theo header mới */
        bottom: 0;
        left: 0;
        overflow-y: auto;
        box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        z-index: 100;
        display: flex;
        flex-direction: column;
    }
    
    .sidebar-menu {
        display: flex;
        flex-direction: column;
        padding: 10px 0; /* Thêm padding cho menu */
    }
    
    .sidebar-menu a {
        padding: 14px 25px; /* Điều chỉnh padding */
        text-decoration: none;
        color: #444; /* Màu chữ đậm hơn */
        border-bottom: 1px solid #f0f0f0;
        transition: all 0.2s ease;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
    }
    
    .sidebar-menu a:hover {
        background-color: #f5f9ff; /* Màu hover nhẹ nhàng */
        color: var(--secondary-color);
    }
    
    .sidebar-menu a.active {
        background-color: var(--secondary-color);
        color: white;
        font-weight: 500;
    }
    
    .sidebar-menu a i {
        margin-right: 10px; /* Khoảng cách icon (nếu có) */
    }
    
    .main-content {
        margin-left: 250px;
        padding: 25px;
        background-color: #fff; /* Nền trắng cho phần nội dung */
        min-height: calc(100vh - 70px); /* Đảm bảo chiều cao tối thiểu */
        box-shadow: 0 0 15px rgba(0,0,0,0.05); /* Đổ bóng nhẹ */
        border-radius: 5px 0 0 0;
    }
    
    /* Cải thiện card */
    .card {
        background-color: white;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: 1px solid #eee;
    }
    
    .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .card-header {
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 20px;
        color: var(--primary-color);
        border-bottom: 1px solid #eee;
        padding-bottom: 12px;
    }
    
    /* Nút đẹp hơn */
    .btn {
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.2s;
        font-size: 0.9rem;
    }
    
    .btn-primary {
        background-color: var(--secondary-color);
        color: white;
    }
    
    .btn-primary:hover {
        background-color: #2980b9;
    }
    
    /* Bảng đẹp hơn */
    .recent-orders table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }
    
    .recent-orders th {
        background-color: #f8f9fa;
        position: sticky;
        top: 0;
    }
    
    .recent-orders th, .recent-orders td {
        padding: 14px 16px;
        text-align: left;
        border-bottom: 1px solid #e9ecef;
    }
    
    .recent-orders tr:hover {
        background-color: #f8f9fa;
    }
    </style>
    <!-- Thêm Font Awesome nếu muốn dùng icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h2><i class="fas fa-utensils"></i> Hệ Thống Quản Trị Nhà Hàng</h2>
        <div>
            <span style="margin-right: 15px;"><i class="fas fa-user-circle"></i> Xin chào, Admin</span>
            <a href="logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>
    
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/bestSellingFood" class="active">
                <i class="fas fa-home"></i> Trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/CancelledOrdersServlet">
                <i class="fas fa-chair"></i> Quản lý bàn ăn
            </a>
<!--            <a href="${pageContext.request.contextPath}/ExportReportServlet">
                <i class="fas fa-book-open"></i> Quản lý thực đơn
            </a>-->
            <a href="${pageContext.request.contextPath}/GenerateQRServlet">
                <i class="fas fa-clipboard-list"></i> Quản lý đơn hàng
            </a>
            <a href="${pageContext.request.contextPath}/OrderChartServlet">
                <i class="fas fa-users"></i> Quản lý nhân viên
            </a>
            <a href="${pageContext.request.contextPath}/RevenueServlet">
                <i class="fas fa-chart-bar"></i> Báo cáo & Thống kê
            </a>
            <a href="${pageContext.request.contextPath}">
                <i class="fas fa-cog"></i> Cài đặt hệ thống
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- ... (giữ nguyên nội dung) ... -->
    </div>
    
    <script>
        // Thêm hiệu ứng active cho menu
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.addEventListener('click', function() {
                document.querySelectorAll('.sidebar-menu a').forEach(a => a.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html> 