<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new java.util.ArrayList<>();
    session.setAttribute("cart", cart);
%>

<!DOCTYPE html>
<html>
<head>
  <title>Giỏ hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Thêm jQuery để gọi AJAX -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">🛒 Giỏ hàng của bạn</h2>

  <c:choose>
    <c:when test="${empty cart}">
      <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
    </c:when>
    <c:otherwise>
      <table class="table table-bordered table-hover">
        <thead class="table-light">
          <tr>
            <th>Ảnh</th><th>Tên món</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${cart}">
            <tr>
              <td><img src="${pageContext.request.contextPath}/${item.image}"
                       width="80" height="60" style="object-fit: cover;"/></td>
              <td>${item.foodName}</td>
              <td>${item.quantity}</td>
              <td>${item.price} đ</td>
              <td>${item.totalPrice} đ</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <!-- Tính tổng -->
      <div class="text-end fw-bold fs-5">
        Tổng cộng:
        <c:set var="total" value="0" />
        <c:forEach var="item" items="${cart}">
          <c:set var="total" value="${total + item.totalPrice}" />
        </c:forEach>
        <span id="totalAmount">${total}</span> đ
      </div>
    </c:otherwise>
  </c:choose>

  <div class="mt-4">
    <a href="${pageContext.request.contextPath}/MenuServlet"
       class="btn btn-secondary">⬅️ Tiếp tục đặt món</a>

    <!-- Nút Thanh toán mới -->
    <button id="btnPay" class="btn btn-success">✅ Thanh toán</button>
  </div>
</div>

<script>
$(function(){
  $('#btnPay').click(function(e){
    e.preventDefault();

    // Lấy tổng tiền từ span (kiểu string), parse sang số
    var total = parseInt($('#totalAmount').text(), 10);

    // Gọi AJAX lên ajaxServlet (mapping /vnpayajax)
    $.ajax({
      url: '${pageContext.request.contextPath}/vnpayajax',
      type: 'POST',
      data: {
        amount: total
      },
      dataType: 'json',
      success: function(resp) {
        if (resp.code === '00') {
          // resp.data = paymentUrl do ajaxServlet trả về
          window.location.href = resp.data;
        } else {
          alert('Lỗi khi tạo đường dẫn thanh toán: ' + resp.message);
        }
      },
      error: function(xhr, status, error) {
        alert('AJAX error: ' + error);
      }
    });

  });
});
</script>
</body>
</html>
