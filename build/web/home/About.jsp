<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About - Restaurantly</title>
    
 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  
    <style>
        .about.section {
            background-color: #f8f9fa;
            padding: 60px 0;
        }
        .about-img {
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .card-item {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card-item span {
            font-size: 30px;
            font-weight: bold;
            color: #ffc107;
            display: block;
            margin-bottom: 15px;
        }
        .section-title h2 {
            font-weight: 700;
        }
 

nav .navbar-brand {
    font-size: 1.8rem;
    font-weight: 600;
    color: #333;
}

nav .nav-link {
    font-size: 1rem;
 
    color: #555;  
}

nav .nav-link:hover {
    color: #007bff;  
}

nav .btn {
    font-weight: bold;
    background-color: #007bff;  
    color: #fff;
     
    padding: 0.5rem 1.5rem; 
}

nav .btn:hover {
    background-color: #0056b3; 
}

body {
    padding-top: 80px; }
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
                    <img src="assets/img/about.jpg" class="img-fluid about-img" alt="About Us">
                </div>
                <div class="col-lg-6 content">
                    <h3>Voluptatem dignissimos provident</h3>
                    <p class="fst-italic">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    </p>
                    <ul class="list-unstyled">
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat.</li>
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Duis aute irure dolor in reprehenderit in voluptate velit.</li>
                        <li><i class="bi bi-check2-all text-warning me-2"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate.</li>
                    </ul>
                    <p>
                        Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
                        velit esse cillum dolore eu fugiat nulla pariatur.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Us Section -->
    <section id="why-us" class="why-us section bg-light py-5">
        <div class="container text-center">
            <div class="section-title mb-5" data-aos="fade-up">
                <h2>WHY US</h2>
                <p class="text-muted">Why Choose Our Restaurant</p>
            </div>

            <div class="row gy-4">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card-item h-100">
                        <span>01</span>
                        <h4><a href="#" class="stretched-link text-dark">Lorem Ipsum</a></h4>
                        <p>Ulamco laboris nisi ut aliquip ex ea commodo consequat. Et consectetur ducimus vero placeat.</p>
                    </div>
                </div>

                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card-item h-100">
                        <span>02</span>
                        <h4><a href="#" class="stretched-link text-dark">Repellat Nihil</a></h4>
                        <p>Dolorem est fugiat occaecati voluptate velit esse. Dicta veritatis dolor quod et vel.</p>
                    </div>
                </div>

                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card-item h-100">
                        <span>03</span>
                        <h4><a href="#" class="stretched-link text-dark">Ad ad velit qui</a></h4>
                        <p>Molestiae officiis omnis illo asperiores. Aut doloribus vitae sunt debitis quo vel nam quis.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>
</html>
