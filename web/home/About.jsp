<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Về Chúng Tôi - The Golden Spoon</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--light-gray), #e9ecef);
            padding-top: 80px;
            margin: 0;
            color: var(--text-dark);
        }

        .about.section {
            background-color: var(--warm-white);
            padding: 80px 0;
            border-bottom: 1px solid var(--medium-gray);
        }

        .about-img {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .about-img:hover {
            transform: scale(1.02);
        }

        .content h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 20px;
            position: relative;
        }

        .content h3::after {
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

        .content .fst-italic {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 20px;
        }

        .content ul {
            padding-left: 20px;
        }

        .content ul li {
            font-size: 1rem;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .content ul li i {
            color: var(--primary-gold);
        }

        .content p {
            font-size: 1rem;
            color: var(--text-light);
            line-height: 1.8;
        }

        .why-us.section {
            background-color: var(--light-gray);
            padding: 80px 0;
            text-align: center;
        }

        .section-title h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--charcoal);
            margin-bottom: 15px;
            position: relative;
        }

        .section-title h2::after {
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

        .section-title p {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 40px;
        }

        .card-item {
            background: var(--warm-white);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            height: 100%;
        }

        .card-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .card-item span {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-gold);
            margin-bottom: 20px;
        }

        .card-item h4 a {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card-item h4 a:hover {
            color: var(--dark-gold);
        }

        .card-item p {
            font-size: 1rem;
            color: var(--text-light);
            line-height: 1.8;
        }
    </style>
</head>
<body>

    <!-- INCLUDE NAVBAR (fix path depending on real location) -->
    <%@ include file="../includes/Nappar.jsp" %>

    <!-- About Section -->
    <section id="about" class="about section">
        <div class="container" data-aos="fade-up" data-aos-delay="100">
            <div class="row gy-4 align-items-center">
                <div class="col-lg-6">
                    <img src="assets/img/about.jpg" class="img-fluid about-img" alt="Về Chúng Tôi">
                </div>
                <div class="col-lg-6 content">
                    <h3>Về Nhà Hàng The Golden Spoon</h3>
                    <p class="fst-italic">
                        Chào mừng bạn đến với The Golden Spoon, nơi mang đến trải nghiệm ẩm thực đẳng cấp và sang trọng. Chúng tôi tự hào phục vụ những món ăn tinh tế, được chế biến từ nguyên liệu tươi ngon nhất.
                    </p>
                    <ul class="list-unstyled">
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Đội ngũ đầu bếp chuyên nghiệp với nhiều năm kinh nghiệm.</li>
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Không gian ấm cúng, phù hợp cho mọi dịp đặc biệt.</li>
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Dịch vụ tận tâm, mang lại sự hài lòng tối đa cho khách hàng.</li>
                    </ul>
                    <p>
                        Chúng tôi cam kết mang đến cho bạn những bữa ăn đáng nhớ, nơi hương vị và dịch vụ hòa quyện hoàn hảo. Hãy đến và trải nghiệm sự khác biệt tại The Golden Spoon!
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Us Section -->
    <section id="why-us" class="why-us section bg-light py-5">
        <div class="container text-center">
            <div class="section-title mb-5" data-aos="fade-up">
                <h2>TẠI SAO CHỌN CHÚNG TÔI</h2>
                <p class="text-muted">Lý Do Chọn Nhà Hàng The Golden Spoon</p>
            </div>

            <div class="row gy-4">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card-item h-100">
                        <span>01</span>
                        <h4><a href="#" class="stretched-link text-dark">Chất Lượng Hàng Đầu</a></h4>
                        <p>Nguyên liệu tươi ngon được chọn lọc kỹ càng, đảm bảo hương vị tuyệt vời cho từng món ăn.</p>
                    </div>
                </div>

                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card-item h-100">
                        <span>02</span>
                        <h4><a href="#" class="stretched-link text-dark">Dịch Vụ Hoàn Hảo</a></h4>
                        <p>Đội ngũ nhân viên chuyên nghiệp, phục vụ tận tình để mang lại trải nghiệm tuyệt vời nhất.</p>
                    </div>
                </div>

                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card-item h-100">
                        <span>03</span>
                        <h4><a href="#" class="stretched-link text-dark">Không Gian Sang Trọng</a></h4>
                        <p>Thiết kế tinh tế và không gian ấm cúng, lý tưởng cho các buổi tiệc và sự kiện đặc biệt.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>
</html>