<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
          <c:set var="total" value="0" />
          <c:forEach var="item" items="${cart}">
            <tr>
              <td><img src="${pageContext.request.contextPath}/${item.image}" width="80" height="60" style="object-fit: cover;"/></td>
              <td>${item.foodName}</td>
              <td>${item.quantity}</td>
              <td><fmt:formatNumber value="${item.price}" type="number"/> đ</td>
              <td><fmt:formatNumber value="${item.totalPrice}" type="number"/> đ</td>
            </tr>
            <c:set var="total" value="${total + item.totalPrice}" />
          </c:forEach>
        </tbody>
      </table>

      <!-- Chọn mã khuyến mãi -->
      <form action="CartServlet" method="post" class="mb-4">
        <label for="promotion">Chọn mã giảm giá:</label>
        <select name="promotionId" id="promotion" class="form-select w-auto d-inline">
          <option value="">-- Không áp dụng --</option>
          <c:forEach var="p" items="${promoList}">
            <option value="${p.promoID}"
              <c:if test="${selectedPromo != null && selectedPromo.promoID == p.promoID}">selected</c:if>>
              ${p.promoCode} - Giảm ${p.discountPercent}%
            </option>
          </c:forEach>
        </select>
        <button type="submit" class="btn btn-primary">Áp dụng</button>
      </form>

      <!-- Tổng cộng + Giảm giá -->
      <div class="text-end fw-bold fs-5">
        Tổng cộng: <span><fmt:formatNumber value="${total}" type="number"/></span> đ
      </div>
      <c:if test="${not empty selectedPromo}">
        <div class="text-end text-success fw-semibold">
          Giảm giá: -${selectedPromo.discountPercent}% (${selectedPromo.promoCode})
        </div>
        <div class="text-end fw-bold fs-5 text-danger">
          Tổng sau giảm: 
          <c:set var="discounted" value="${total - (total * selectedPromo.discountPercent / 100)}"/>
          <span id="totalAmount"><fmt:formatNumber value="${discounted}" type="number"/></span> đ
        </div>
      </c:if>
    </c:otherwise>
  </c:choose>

  <div class="mt-4">
    <a href="${pageContext.request.contextPath}/MenuServlet" class="btn btn-secondary">⬅️ Tiếp tục đặt món</a>
    <button id="btnPay" class="btn btn-success">✅ Thanh toán</button>
  </div>
</div>

<script>
$(function(){
  $('#btnPay').click(function(e){
    e.preventDefault();
    var total = parseInt($('#totalAmount').text().replace(/\D/g, ''), 10);
    $.ajax({
      url: '${pageContext.request.contextPath}/vnpayajax',
      type: 'POST',
      data: { amount: total },
      dataType: 'json',
      success: function(resp) {
        if (resp.code === '00') {
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
