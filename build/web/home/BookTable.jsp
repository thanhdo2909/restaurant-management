<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Book a Table</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f8f9fa;
      margin: 0;
      padding: 0;
    }

    .book-a-table {
      padding: 60px 0;
      background-color: #fff;
    }

    .section-title {
        padding-top: 50px;
      text-align: center;
      margin-bottom: 30px;
    }

    .php-email-form {
      max-width: 800px;
      margin: auto;
      background: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
    }

    .form-control {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 8px;
      border: 1px solid #ced4da;
    }

    .form-control:focus {
      border-color: #007bff;
      outline: none;
    }

    .error {
      color: red;
      font-size: 14px;
      margin-top: -8px;
      margin-bottom: 10px;
    }

    button[type="submit"] {
      background: #007bff;
      color: white;
      padding: 12px 25px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 600;
    }

    button[type="submit"]:hover {
      background: #0056b3;
    }
  </style>
</head>
<body>
     <%@ include file="../includes/Nappar.jsp" %>
  <section class="book-a-table">
    <div class="section-title">
      <h2>RESERVATION</h2>
      <p>Book a Table</p>
    </div>

      <form action="" method="">
      <input type="text" name="name" class="form-control" placeholder="Your Name" required>
      <input type="email" name="email" class="form-control" placeholder="Your Email" required>
      <input type="text" name="phone" class="form-control" placeholder="Your Phone" required>

      <input type="date" name="date" class="form-control" id="date" required>
      <input type="time" name="startTime" class="form-control" id="startTime" required>
      <div id="start-error" class="error"></div>

      <input type="time" name="endTime" class="form-control" id="endTime" required>
      <div id="end-error" class="error"></div>

      <input type="number" name="people" class="form-control" placeholder="# of people" required>
      <textarea name="message" class="form-control" rows="5" placeholder="Message"></textarea>

      <div class="text-center">
        <button type="submit">Book a Table</button>
      </div>
    </form>
  </section>

  <script>
    window.addEventListener('DOMContentLoaded', () => {
      const today = new Date().toISOString().split("T")[0];
      document.getElementById('date').setAttribute('min', today);
    });

    document.getElementById('bookingForm').addEventListener('submit', function (e) {
      const dateVal = document.getElementById('date').value;
      const startTimeVal = document.getElementById('startTime').value;
      const endTimeVal = document.getElementById('endTime').value;

      const startError = document.getElementById('start-error');
      const endError = document.getElementById('end-error');

      // Xóa thông báo lỗi cũ
      startError.textContent = '';
      endError.textContent = '';

      if (!dateVal || !startTimeVal || !endTimeVal) return;

      const startDateTime = new Date(`${dateVal}T${startTimeVal}`);
      const endDateTime = new Date(`${dateVal}T${endTimeVal}`);
      const now = new Date();

      let valid = true;

      if (startDateTime <= now) {
        startError.textContent = "Thời gian bắt đầu phải lớn hơn thời điểm hiện tại.";
        valid = false;
      }

      if (startDateTime >= endDateTime) {
        endError.textContent = "Thời gian kết thúc phải lớn hơn thời gian bắt đầu.";
        valid = false;
      }

      if (!valid) {
        e.preventDefault(); // Ngăn form gửi nếu có lỗi
      }
    });
  </script>
</body>
</html>
