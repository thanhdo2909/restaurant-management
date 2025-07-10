<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Bàn - The Golden Spoon Restaurant</title>
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
            --error-red: #C62828;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
            background-color: var(--warm-white);
            overflow-x: hidden;
        }

        /* Header Section */
        .restaurant-header {
            background: linear-gradient(rgba(44, 44, 44, 0.8), rgba(44, 44, 44, 0.8)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23000" width="1200" height="800"/><rect fill="%23111" width="600" height="400" x="300" y="200" rx="20"/></svg>');
            background-size: cover;
            background-position: center;
            color: var(--warm-white);
            text-align: center;
            padding: 60px 20px;
            position: relative;
        }

        .restaurant-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(ellipse at center, transparent 0%, rgba(0,0,0,0.3) 100%);
        }

        .header-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            margin: 0 auto;
        }

        .restaurant-logo {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--primary-gold);
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .restaurant-tagline {
            font-size: 1.2rem;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.8;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Main Container */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Booking Section */
        .booking-section {
            padding: 80px 0;
        }

        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 15px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 2px;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
        }

        /* Booking Form Container */
        .booking-form-container {
            background: var(--warm-white);
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            border: 1px solid var(--medium-gray);
            max-width: 900px;
            margin: 0 auto;
            position: relative;
        }

        .booking-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
        }

        .form-header {
            background: linear-gradient(135deg, var(--light-gray), #f0f0f0);
            padding: 40px;
            text-align: center;
            border-bottom: 1px solid var(--medium-gray);
        }

        .form-header-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--charcoal);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .form-header-subtitle {
            color: var(--text-light);
            font-size: 1rem;
        }

        .booking-form {
            padding: 50px 40px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .form-label i {
            color: var(--primary-gold);
            font-size: 1.1rem;
        }

        .form-control {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid var(--medium-gray);
            border-radius: 15px;
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: var(--warm-white);
            color: var(--text-dark);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
            transform: translateY(-2px);
        }

        .form-control::placeholder {
            color: var(--text-light);
        }

        .error-message {
            color: var(--error-red);
            font-size: 0.9rem;
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 500;
        }

        .error-message i {
            font-size: 0.8rem;
        }

        .form-control.error {
            border-color: var(--error-red);
            background: rgba(198, 40, 40, 0.05);
        }

        /* Submit Button */
        .form-actions {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid var(--medium-gray);
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            color: var(--charcoal);
            border: none;
            padding: 18px 50px;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 6px 25px rgba(212, 175, 55, 0.3);
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            min-width: 200px;
            justify-content: center;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, var(--dark-gold), #A67C00);
            transform: translateY(-3px);
            box-shadow: 0 10px 35px rgba(212, 175, 55, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        .btn-submit i {
            font-size: 1rem;
        }

        /* Restaurant Features */
        .features-section {
            background: var(--light-gray);
            padding: 80px 0;
            margin-top: 80px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            margin-top: 50px;
        }

        .feature-card {
            background: var(--warm-white);
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
            border: 1px solid var(--medium-gray);
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-gold), var(--dark-gold));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            color: var(--warm-white);
            font-size: 2rem;
        }

        .feature-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 15px;
        }

        .feature-description {
            color: var(--text-light);
            line-height: 1.8;
        }

        /* Footer */
        .restaurant-footer {
            background: var(--charcoal);
            color: var(--warm-white);
            text-align: center;
            padding: 40px 20px;
        }

        .footer-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--primary-gold);
            margin-bottom: 15px;
        }

        .footer-text {
            opacity: 0.8;
            line-height: 1.8;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .booking-form-container {
            animation: fadeInUp 0.8s ease-out;
        }

        /* Loading State */
        .btn-submit.loading {
            background: var(--medium-gray);
            cursor: not-allowed;
        }

        .btn-submit.loading::after {
            content: '';
            width: 20px;
            height: 20px;
            border: 2px solid var(--text-light);
            border-top: 2px solid var(--primary-gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .restaurant-logo {
                font-size: 2.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .form-group.full-width {
                grid-column: span 1;
            }

            .booking-form {
                padding: 30px 25px;
            }

            .form-header {
                padding: 30px 25px;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .btn-submit {
                padding: 16px 40px;
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .main-container {
                padding: 0 15px;
            }

            .restaurant-header {
                padding: 40px 15px;
            }

            .booking-section {
                padding: 60px 0;
            }

            .features-section {
                padding: 60px 0;
            }

            .form-header-title {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger text-center" style="margin:20px;">
            <c:out value="${sessionScope.error}"/>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <header class="restaurant-header">
        <div class="header-content">
            <h1 class="restaurant-logo">The Golden Spoon</h1>
            <p class="restaurant-tagline">Fine Dining Experience</p>
            <h2 class="page-title">Đặt Bàn</h2>
            <p class="page-subtitle">Khởi đầu hành trình ẩm thực tuyệt vời với việc đặt bàn dễ dàng</p>
        </div>
    </header>

    <main class="main-container">
        <section class="booking-section">
            <div class="section-header">
                <h2 class="section-title">Thông Tin Đặt Bàn</h2>
                <p class="section-subtitle">
                    Vui lòng điền đầy đủ thông tin để chúng tôi có thể phục vụ bạn một cách tốt nhất
                </p>
            </div>

            <div class="booking-form-container">
                <div class="form-header">
                    <h3 class="form-header-title">
                        <i class="fas fa-utensils"></i>
                        Thông Tin Đặt Bàn
                    </h3>
                    <p class="form-header-subtitle">Điền thông tin chi tiết của bạn</p>
                </div>

                <form id="bookingForm" class="booking-form" action="${pageContext.request.contextPath}/RoomBookingServlet" method="post" autocomplete="off" novalidate>
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="roomId" class="form-label">
                                <i class="fas fa-chair"></i>
                                Mã bàn
                            </label>
                            <input type="text" class="form-control" id="roomId" name="roomId" value="${param.roomId}" readonly required>
                            <div id="roomId-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="fullName" class="form-label">
                                <i class="fas fa-user"></i>
                                Họ và tên
                            </label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.fullName}" readonly required>
                            <div id="fullName-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone"></i>
                                Số điện thoại
                            </label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${param.phone}" required>
                            <div id="phone-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="date" class="form-label">
                                <i class="fas fa-calendar-alt"></i>
                                Ngày đặt bàn
                            </label>
                            <input type="date" class="form-control" id="date" name="date" value="${param.date}" required>
                            <div id="date-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="startTime" class="form-label">
                                <i class="fas fa-clock"></i>
                                Giờ bắt đầu
                            </label>
                            <input type="time" class="form-control" id="startTime" name="startTime" value="${param.startTime}" required>
                            <div id="start-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="endTime" class="form-label">
                                <i class="fas fa-clock"></i>
                                Giờ kết thúc
                            </label>
                            <input type="time" class="form-control" id="endTime" name="endTime" value="${param.endTime}" required>
                            <div id="end-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="people" class="form-label">
                                <i class="fas fa-users"></i>
                                Số lượng khách
                            </label>
                            <input type="number" class="form-control" id="people" name="people" min="1" max="20" value="${param.people}" required>
                            <div id="people-error" class="error-message"></div>
                        </div>

                        <div class="form-group full-width">
                            <label for="message" class="form-label">
                                <i class="fas fa-comment"></i>
                                Ghi chú đặc biệt
                            </label>
                            <textarea class="form-control" id="message" name="message" rows="4" maxlength="255">${param.message}</textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-submit" id="submitBtn">
                            Đặt bàn
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <section class="features-section">
            <div class="section-header">
                <h2 class="section-title">Tại Sao Chọn Chúng Tôi</h2>
                <p class="section-subtitle">
                    Trải nghiệm đặc biệt đang chờ đón bạn tại The Golden Spoon
                </p>
            </div>
            <div class="features-grid">
                <!-- Keep existing feature cards -->
            </div>
        </section>
    </main>

    <footer class="restaurant-footer">
        <div class="footer-content">
            <h4 class="footer-logo">The Golden Spoon</h4>
            <p class="footer-text">
                Cảm ơn bạn đã chọn nhà hàng chúng tôi. Chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất.
            </p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split("T")[0];
            document.getElementById('date').setAttribute('min', today);

            document.getElementById('bookingForm').addEventListener('submit', function(e) {
                let valid = true;
                const fields = [
                    { id: 'roomId', errorId: 'roomId-error', message: 'Vui lòng chọn bàn!' },
                    { id: 'fullName', errorId: 'fullName-error', message: 'Vui lòng nhập họ tên!' },
                    { id: 'phone', errorId: 'phone-error', message: 'Vui lòng nhập số điện thoại!' },
                    { id: 'date', errorId: 'date-error', message: 'Vui lòng chọn ngày!' },
                    { id: 'startTime', errorId: 'start-error', message: 'Vui lòng chọn giờ bắt đầu!' },
                    { id: 'endTime', errorId: 'end-error', message: 'Vui lòng chọn giờ kết thúc!' },
                    { id: 'people', errorId: 'people-error', message: 'Vui lòng nhập số lượng khách!' }
                ];

                fields.forEach(field => {
                    const input = document.getElementById(field.id);
                    const error = document.getElementById(field.errorId);
                    input.classList.remove('error');
                    error.textContent = '';
                    if (!input.value.trim()) {
                        error.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${field.message}`;
                        input.classList.add('error');
                        valid = false;
                    }
                });

                const phone = document.getElementById('phone');
                if (phone.value && !/^\d{9,12}$/.test(phone.value.trim())) {
                    document.getElementById('phone-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Số điện thoại không hợp lệ (9-12 số)!';
                    phone.classList.add('error');
                    valid = false;
                }

                const date = document.getElementById('date').value;
                const startTime = document.getElementById('startTime').value;
                const endTime = document.getElementById('endTime').value;
                const people = document.getElementById('people').value;
                if (date && startTime && endTime) {
                    const now = new Date();
                    const startDateTime = new Date(`${date}T${startTime}`);
                    const endDateTime = new Date(`${date}T${endTime}`);
                    if (startDateTime <= now) {
                        document.getElementById('start-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Thời gian bắt đầu phải sau hiện tại!';
                        document.getElementById('startTime').classList.add('error');
                        valid = false;
                    }
                    if (startDateTime >= endDateTime) {
                        document.getElementById('end-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Giờ kết thúc phải sau giờ bắt đầu!';
                        document.getElementById('endTime').classList.add('error');
                        valid = false;
                    }
                }
                if (people && (people < 1 || people > 20)) {
                    document.getElementById('people-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Số lượng khách phải từ 1 đến 20!';
                    document.getElementById('people').classList.add('error');
                    valid = false;
                }

                if (!valid) {
                    e.preventDefault();
                    const firstError = document.querySelector('.form-control.error');
                    if (firstError) {
                        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                } else {
                    document.getElementById('submitBtn').classList.add('loading');
                    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                    document.getElementById('submitBtn').disabled = true;
                }
            });

            // Real-time validation
            ['roomId', 'fullName', 'phone', 'date', 'startTime', 'endTime', 'people'].forEach(id => {
                document.getElementById(id).addEventListener('input', function() {
                    const error = document.getElementById(`${id}-error`);
                    if (this.value.trim()) {
                        this.classList.remove('error');
                        error.textContent = '';
                    }
                });
            });

            document.getElementById('phone').addEventListener('input', function() {
                const error = document.getElementById('phone-error');
                if (/^\d{9,12}$/.test(this.value.trim())) {
                    this.classList.remove('error');
                    error.textContent = '';
                }
            });

            document.getElementById('people').addEventListener('input', function() {
                const error = document.getElementById('people-error');
                if (this.value >= 1 && this.value <= 20) {
                    this.classList.remove('error');
                    error.textContent = '';
                }
            });
        });
    </script>
</body>
</html>