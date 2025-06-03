
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>book room</title>
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
           <style>
/* Section Title */
.section-title {
    text-align: center;
    margin-bottom: 3rem;
}

.section-title h2 {
    font-size: 2.8rem;
    font-weight: bold;
    color: #222;
}

.section-title p {
    color: #6c757d;
    font-size: 1.2rem;
    margin-top: 0.5rem;
}

/* Form Styling */
.php-email-form {
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
}

.php-email-form input,
.php-email-form textarea {
    border-radius: 8px;
    box-shadow: none;
    font-size: 1rem;
    padding: 10px 15px;
    border: 1px solid #ced4da;
    transition: border-color 0.3s;
}

.php-email-form input:focus,
.php-email-form textarea:focus {
    border-color: #007bff;
    outline: none;
}

.php-email-form textarea {
    resize: none;
}

/* Submit Button */
.php-email-form button[type="submit"] {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 12px 30px;
    font-size: 1.1rem;
    border-radius: 50px;
    transition: background-color 0.3s;
    margin-top: 15px;
}

.php-email-form button[type="submit"]:hover {
    background: #0056b3;
}

/* Feedback Messages */
.php-email-form .loading,
.php-email-form .error-message,
.php-email-form .sent-message {
    display: none;
    text-align: center;
    margin-top: 15px;
    font-size: 0.95rem;
}

.php-email-form .sent-message {
    color: #28a745;
    font-weight: 500;
}

.php-email-form .error-message {
    color: #dc3545;
}

/* Responsive Fix */
@media (max-width: 768px) {
    .php-email-form {
        padding: 20px;
    }
}
</style>

    </head>
    <body>
             <%@ include file="../includes/Nappar.jsp" %>
        <section id="book-a-table" class="book-a-table section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>RESERVATION</h2>
        <p>Book a Table</p>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <form action="forms/book-a-table.php" method="post" role="form" class="php-email-form">
          <div class="row gy-4">
            <div class="col-lg-4 col-md-6">
              <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" required="">
            </div>
            <div class="col-lg-4 col-md-6">
              <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required="">
            </div>
            <div class="col-lg-4 col-md-6">
              <input type="text" class="form-control" name="phone" id="phone" placeholder="Your Phone" required="">
            </div>
            <div class="col-lg-4 col-md-6">
              <input type="date" name="date" class="form-control" id="date" placeholder="Date" required="">
            </div>
            <div class="col-lg-4 col-md-6">
              <input type="time" class="form-control" name="time" id="time" placeholder="Time" required="">
            </div>
            <div class="col-lg-4 col-md-6">
              <input type="number" class="form-control" name="people" id="people" placeholder="# of people" required="">
            </div>
          </div>

          <div class="form-group mt-3">
            <textarea class="form-control" name="message" rows="5" placeholder="Message"></textarea>
          </div>

          <div class="text-center mt-3">
            <div class="loading">Loading</div>
            <div class="error-message"></div>
            <div class="sent-message">Your booking request was sent. We will call back or send an Email to confirm your reservation. Thank you!</div>
            <button type="submit">Book a Table</button>
          </div>
        </form><!-- End Reservation Form -->

      </div>

    </section>
    </body>
</html>
