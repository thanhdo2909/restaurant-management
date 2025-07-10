<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, Model.Room, Model.RoomBooking, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            margin: 20px;
        }
        .btn-cancel {
            padding: 5px 10px;
            font-size: 14px;
        }
        .alert {
            margin: 20px;
        }
        .tab-content {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <% if (session == null || session.getAttribute("accountId") == null) {
           response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
           return;
       }
    %>
    <div class="table-container">
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% }
           String success = (String) request.getAttribute("success");
           if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>
        <h2 class="text-center mb-4">Quản lý - Admin</h2>

        <!-- Tabs -->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="rooms-tab" data-bs-toggle="tab" data-bs-target="#rooms" type="button" role="tab">Quản lý Bàn</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="bookings-tab" data-bs-toggle="tab" data-bs-target="#bookings" type="button" role="tab">Quản lý Đặt Bàn</button>
            </li>
        </ul>

        <div class="tab-content" id="myTabContent">
            <!-- Tab Quản lý Bàn -->
            <div class="tab-pane fade show active" id="rooms" role="tabpanel" aria-labelledby="rooms-tab">
                <table class="table table-striped table-bordered mt-4">
                    <thead class="table-dark">
                        <tr>
                            <th>ID Bàn</th>
                            <th>Loại Bàn</th>
                            <th>Sức Chứa</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                           if (rooms != null) {
                               for (Room room : rooms) { %>
                                <tr>
                                    <td><%= room.getRoomID() %></td>
                                    <td><%= room.getRoomType() != null ? room.getRoomType() : "Chưa đặt loại" %></td>
                                    <td><%= room.getMaxCapacity() %></td>
                                    <td><%= room.getStatus() %></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/AdminViewTableServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="roomId" value="<%= room.getRoomID() %>">
                                            <button type="submit" name="action" value="cancel" class="btn btn-warning btn-sm <%= !room.getStatus().equals("Booked") ? "disabled" : "" %>">Hủy</button>
                                            <button type="submit" name="action" value="complete" class="btn btn-success btn-sm <%= !room.getStatus().equals("Booked") ? "disabled" : "" %>">Hoàn tất</button>
                                        </form>
                                    </td>
                                </tr>
                        <%   }
                           } else { %>
                                <tr><td colspan="5" class="text-center">Không có bàn nào.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Tab Quản lý Đặt Bàn -->
            <div class="tab-pane fade" id="bookings" role="tabpanel" aria-labelledby="bookings-tab">
                <table class="table table-striped table-bordered mt-4">
                    <thead class="table-dark">
                        <tr>
                            <th>ID Booking</th>
                            <th>Tên Người Đặt</th>
                            <th>ID Tài Khoản</th>
                            <th>ID Bàn</th>
                            <th>Thời Gian Bắt Đầu</th>
                            <th>Thời Gian Kết Thúc</th>
                            <th>Số Người</th>
                            <th>Số Điện Thoại</th>
                            <th>Trạng Thái</th>
                            <th>Thông Tin</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<RoomBooking> bookings = (List<RoomBooking>) request.getAttribute("bookings");
                           Map<Integer, String> fullNameMap = (Map<Integer, String>) request.getAttribute("fullNameMap");
                           if (bookings != null) {
                               for (RoomBooking booking : bookings) {
                                   String fullName = fullNameMap != null && fullNameMap.containsKey(booking.getBookingID()) ?
                                                   fullNameMap.get(booking.getBookingID()) : "N/A";
                        %>
                                <tr>
                                    <td><%= booking.getBookingID() %></td>
                                    <td><%= fullName %></td>
                                    <td><%= booking.getAccountID() %></td>
                                    <td><%= booking.getRoomID() %></td>
                                    <td><%= booking.getStartTime() %></td>
                                    <td><%= booking.getEndTime() %></td>
                                    <td><%= booking.getPeople() %></td>
                                    <td><%= booking.getPhone() %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td><%= booking.getMessage() != null ? booking.getMessage() : "Không có" %></td>
                                    <td>
                                        <% if ("Booked".equals(booking.getStatus())) { %>
                                            <form action="${pageContext.request.contextPath}/AdminViewTableServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                                <button type="submit" class="btn btn-danger btn-cancel">Kết thúc đặt bàn</button>
                                            </form>
                                        <% } else { %>
                                            <span class="text-muted">Hoàn Thành</span>
                                        <% } %>
                                    </td>
                                </tr>
                        <%   }
                           } else { %>
                                <tr><td colspan="11" class="text-center">Không có booking nào.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>