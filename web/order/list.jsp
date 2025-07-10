<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Order List - ${param.role}</title>
</head>
<body>
  <h2>Order List (${param.role})</h2>
  <table border="1">
    <tr>
      <th>Order ID</th>
      <th>User ID</th>
      <th>Shipper ID</th>
      <th>Total</th>
      <th>Status</th>
      <th>Created At</th>
      <th>Actions</th>
    </tr>
    <c:forEach var="o" items="${orders}">
      <tr>
        <td>${o.orderID}</td>
        <td>${o.userID}</td>
        <td>${o.shipperID}</td>
        <td>${o.totalAmount}</td>
        <td>${o.status}</td>
        <td>${o.createdAt}</td>
        <td>
          <c:choose>
            <c:when test="${param.role=='shipper'}">
              <a href="${pageContext.request.contextPath}/shipper/orders?action=receive&orderID=${o.orderID}">Accept</a> |
              <a href="${pageContext.request.contextPath}/shipper/orders?action=updateStatus&orderID=${o.orderID}&success=true">Delivered</a> |
              <a href="${pageContext.request.contextPath}/shipper/orders?action=updateStatus&orderID=${o.orderID}&success=false">Failed</a>
            </c:when>
            <c:when test="${param.role=='shipper' && param.action=='listMy'}">
              <a href="${pageContext.request.contextPath}/shipper/orders?action=detail&orderID=${o.orderID}">Detail</a>
            </c:when>
            <c:when test="${param.role=='kitchen'}">
              <a href="${pageContext.request.contextPath}/kitchen/orders?action=complete&orderID=${o.orderID}">Mark Prepared</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/${param.role}/orders?action=detail&orderID=${o.orderID}">Detail</a>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </table>
</body>
</html>