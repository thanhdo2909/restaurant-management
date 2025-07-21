<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý tài khoản người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h2 class="mb-4">👤 Quản lý tài khoản người dùng</h2>

    <!-- Form Xem thông tin -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            🔍 Xem thông tin tài khoản
        </div>
        <div class="card-body">
            <form action="ViewUserServlet" method="get">
                <div class="mb-3">
                    <label for="userIdView" class="form-label">ID người dùng:</label>
                    <input type="text" class="form-control" id="userIdView" name="userId" required>
                </div>
                <button type="submit" class="btn btn-primary">Xem thông tin</button>
            </form>
        </div>
    </div>

    <!-- Nếu chỉ tìm 1 người dùng -->
    <c:if test="${not empty user}">
        <div class="alert alert-info">
            <h5>🔎 Thông tin người dùng:</h5>
            <ul>
                <li><strong>ID:</strong> ${user.accountID}</li>
                <li><strong>Họ tên:</strong> ${user.fullName}</li>
                <li><strong>Email:</strong> ${user.email}</li>
                <li><strong>Trạng thái:</strong>
                    <c:choose>
                        <c:when test="${user.status eq 'locked'}">
                            <span class="badge bg-danger">Đã khóa</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-success">Hoạt động</span>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </c:if>

    <!-- Danh sách tất cả người dùng -->
    <c:if test="${not empty userList}">
        <div class="card mt-4">
            <div class="card-header bg-info text-white">
                📋 Danh sách tài khoản người dùng
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover table-striped">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.accountID}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status eq 'locked'}">
                                            <span class="badge bg-danger">Đã khóa</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status eq 'locked'}">
                                            <form action="${pageContext.request.contextPath}/ManagerAccountServlet" method="get" style="display:inline;">
                                                <input type="hidden" name="userId" value="${user.accountID}" />
                                                <input type="hidden" name="purpose" value="unlock" />
                                                <button type="submit" class="btn btn-success btn-sm">Mở khóa</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/ManagerAccountServlet" method="get" style="display:inline;">
                                                <input type="hidden" name="userId" value="${user.accountID}" />
                                                <input type="hidden" name="purpose" value="lock" />
                                                <button type="submit" class="btn btn-danger btn-sm">Khóa</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</body>
</html>
