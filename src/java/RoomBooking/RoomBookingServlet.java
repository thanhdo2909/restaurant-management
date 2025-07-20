package RoomBooking;

import DAO.DAORoom;
import DAO.DAORoomBooking;
import DAO.DBConnection;
import Model.Room;
import Model.RoomBooking;
import email.BookingEmailUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.regex.Pattern;

@WebServlet("/RoomBookingServlet")
public class RoomBookingServlet extends HttpServlet {
    private String escapeHtml(String input) {
        if (input == null) return null;
        return input.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("error");
        response.sendRedirect(request.getContextPath() + "/ViewRoomsServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Lấy thông tin từ form
            String roomIdStr = request.getParameter("roomId");
            String peopleStr = request.getParameter("people");
            String date = request.getParameter("date");
            String start = request.getParameter("startTime");
            String end = request.getParameter("endTime");
            String message = request.getParameter("message");
            String phone = request.getParameter("phone");

            // Lấy thông tin từ session
            Integer accountIdObj = (Integer) session.getAttribute("accountId");
            String fullName = (String) session.getAttribute("fullName");

            if (accountIdObj == null || fullName == null) {
                response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
                return;
            }
            int accountId = accountIdObj;

            // Validate inputs
            if (roomIdStr == null || peopleStr == null || date == null || start == null || end == null || phone == null ||
                roomIdStr.isEmpty() || peopleStr.isEmpty() || date.isEmpty() || start.isEmpty() || end.isEmpty() || phone.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng điền đầy đủ thông tin!");
            }

            if (!Pattern.matches("\\d{9,12}", phone)) {
                throw new IllegalArgumentException("Số điện thoại không hợp lệ! Vui lòng nhập 9-12 số.");
            }

            int roomId, people;
            try {
                roomId = Integer.parseInt(roomIdStr);
                people = Integer.parseInt(peopleStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Mã bàn hoặc số lượng khách không hợp lệ!");
            }

            if (!Pattern.matches("\\d{4}-\\d{2}-\\d{2}", date)) {
                throw new IllegalArgumentException("Định dạng ngày không hợp lệ! Vui lòng sử dụng YYYY-MM-DD.");
            }
            if (!Pattern.matches("\\d{2}:\\d{2}", start) || !Pattern.matches("\\d{2}:\\d{2}", end)) {
                throw new IllegalArgumentException("Định dạng giờ không hợp lệ! Vui lòng sử dụng HH:MM.");
            }

            // Chuyển đổi thời gian
            Timestamp startTime = Timestamp.valueOf(date + " " + start + ":00");
            Timestamp endTime = Timestamp.valueOf(date + " " + end + ":00");
            if (startTime.after(endTime)) {
                throw new IllegalArgumentException("Thời gian bắt đầu phải trước thời gian kết thúc!");
            }
            if (startTime.before(new Timestamp(System.currentTimeMillis()))) {
                throw new IllegalArgumentException("Thời gian bắt đầu phải ở tương lai!");
            }

            DAORoom daoRoom = new DAORoom();
            DAORoomBooking daoBooking = new DAORoomBooking();

            // Kiểm tra bàn tồn tại
            Room room = daoRoom.getRoomById(roomId);
            if (room == null) {
                throw new IllegalArgumentException("Bàn không tồn tại!");
            }

            // Kiểm tra trùng thời gian
            if (daoBooking.isRoomBooked(roomId, startTime, endTime)) {
                throw new IllegalArgumentException("Bàn đã được đặt trong thời gian này bởi một khách hàng khác!");
            }

            // Kiểm tra khoảng cách thời gian 1 giờ
            if (!daoBooking.isTimeSlotValid(roomId, startTime, endTime)) {
                throw new IllegalArgumentException("Thời gian đặt bàn phải cách các đặt bàn khác ít nhất 1 giờ!");
            }

            // Kiểm tra sức chứa
            if (people > room.getMaxCapacity()) {
                throw new IllegalArgumentException("Số người vượt quá sức chứa tối đa (" + room.getMaxCapacity() + ")!");
            }

            // Kiểm tra số lượng booking của user (chỉ cho phép 1 booking)
            List<RoomBooking> userBookings = daoBooking.getBookingsByAccount(accountId);
            long activeBookings = userBookings.stream()
                .filter(b -> "Booked".equals(b.getStatus()) || "CheckedIn".equals(b.getStatus()))
                .count();
            if (activeBookings > 0) {
                throw new IllegalArgumentException("Bạn chỉ được đặt 1 bàn tại một thời điểm! Vui lòng hủy bàn hiện tại trước khi đặt mới.");
            }

            // Tạo booking mới
            RoomBooking booking = new RoomBooking();
            booking.setAccountID(accountId);
            booking.setRoomID(roomId);
            booking.setStartTime(startTime);
            booking.setEndTime(endTime);
            booking.setPeople(people);
            booking.setMessage(escapeHtml(message));
            booking.setStatus("Booked");
            booking.setPhone(phone);

            // Transaction
            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false);
                boolean success = daoBooking.addRoomBooking(booking);
                if (success) {
                    conn.commit();
                } else {
                    conn.rollback();
                    throw new SQLException("Không thể thêm booking vào cơ sở dữ liệu!");
                }
            }

            // Lưu thông tin để hiển thị
            session.setAttribute("bookingRoomId", roomId);
            session.setAttribute("bookingPeople", people);
            session.setAttribute("bookingDate", date);
            session.setAttribute("bookingStartTime", start);
            session.setAttribute("bookingEndTime", end);
            session.setAttribute("bookingMessage", message);
            session.setAttribute("bookingFullName", fullName);
            session.setAttribute("bookingPhone", phone);

            // Gửi email xác nhận
            String recipientEmail = request.getParameter("email"); // Thay bằng email thực tế
            BookingEmailUtil bookingEmailUtil = new BookingEmailUtil();
            bookingEmailUtil.sendBookingConfirmationEmail(recipientEmail, fullName, roomId, date, start, end, people);

            response.sendRedirect(request.getContextPath() + "/BookTable/BookingSucces.jsp");
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/BookTable/ErrorPopup.jsp");
        } catch (SQLException e) {
            session.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/BookTable/ErrorPopup.jsp");
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/BookTable/ErrorPopup.jsp");
        }
    }
}