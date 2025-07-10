<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>Action Form</title></head>
<body>
  <h2>Update Order Status</h2>
  <form method="get" action="${pageContext.request.contextPath}/${param.role}/orders">
    <input type="hidden" name="action" value="updateStatus" />
    <input type="hidden" name="orderID" value="${param.orderID}" />
    <label>
      <input type="radio" name="success" value="true" /> Delivered
    </label>
    <label>
      <input type="radio" name="success" value="false" /> Failed
    </label>
    <button type="submit">Submit</button>
  </form>
</body>
</html>
