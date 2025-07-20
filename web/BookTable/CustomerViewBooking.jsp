<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem và Hủy Đặt Bàn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #dee2e6; padding: 8px; text-align: left; }
        .error { color: red; }
        .success { color: green; }
        .btn-custom { background-color: #ffc107; color: #000; border: none; padding: 5px 10px; }
        .btn-custom:hover { background-color: #e0a800; color: #fff; }
        .pending { color: orange; font-style: italic; }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Xem và Hủy Đặt Bàn</h2>
        
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty success}">
            <p class="success">${success}</p>
        </c:if>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Room ID</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Status</th>
                    <th>People</th>
                    <th>Name</th>
                    <th>Message</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td>${booking.bookingID}</td>
                        <td>${booking.roomID}</td>
                        <td>${booking.startTime}</td>
                        <td>${booking.endTime}</td>
                        <td><c:if test="${booking.status == 'PendingCancellation'}"><span class="pending">Yêu cầu hủy đang chờ</span></c:if><c:if test="${booking.status != 'PendingCancellation'}">${booking.status}</c:if></td>
                        <td>${booking.people}</td>
                        <td>${booking.phone}</td>
                        <td>${booking.message}</td>
                        <td>
                            <c:if test="${booking.status == 'Booked'}">
                                <form action="CancelBookingServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="bookingId" value="${booking.bookingID}">
                                    <button type="submit" class="btn btn-custom">Gửi yêu cầu hủy</button>
                                </form>
                            </c:if>
                            <c:if test="${booking.status == 'PendingCancellation'}">
                                <span class="pending">Đang chờ phê duyệt</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary mt-3">Quay lại</a>
    </div>
</body>
</html>