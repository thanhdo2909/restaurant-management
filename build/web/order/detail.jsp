<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Order Detail - ${param.role}</title>
</head>
<body>
  <h2>Order Detail (${param.role})</h2>
  <c:if test="${not empty order}">
    <p><strong>Order ID:</strong> ${order.orderID}</p>
    <p><strong>User ID:</strong> ${order.userID}</p>
    <p><strong>Shipper ID:</strong> ${order.shipperID}</p>
    <p><strong>Total Amount:</strong> ${order.totalAmount}</p>
    <p><strong>Status:</strong> ${order.status}</p>
    <p><strong>Created At:</strong> ${order.createdAt}</p>
  </c:if>
  <c:if test="${empty order}">
    <p>No order found.</p>
  </c:if>
  <p><a href="${pageContext.request.contextPath}/${param.role}/orders?action=list">Back to list</a></p>
</body>
</html>