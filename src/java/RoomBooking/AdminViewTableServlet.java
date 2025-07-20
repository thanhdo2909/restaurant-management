package RoomBooking;

import DAO.DAORoom;
import DAO.DAORoomBooking;
import DAO.DBConnection;
import Model.Room;
import Model.RoomBooking;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@WebServlet("/AdminViewTableServlet")
public class AdminViewTableServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminViewTableServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        DAORoom daoRoom = new DAORoom();
        DAORoomBooking daoBooking = new DAORoomBooking();
        List<Room> rooms = null;
        List<RoomBooking> bookings = null;

        try {
            rooms = daoRoom.getAllRooms();
            bookings = daoBooking.getAllBookings();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi truy xuất danh sách: " + e.getMessage(), e);
            request.setAttribute("error", "Lỗi khi truy xuất danh sách: " + e.getMessage());
            request.getRequestDispatcher("/BookTable/AdminViewTable.jsp").forward(request, response);
            return;
        }
        request.setAttribute("rooms", rooms);
        request.setAttribute("bookings", bookings);

        Map<Integer, String> fullNameMap = new HashMap<>();
        if (bookings != null) {
            for (RoomBooking booking : bookings) {
                try {
                    String sql = "SELECT FullName FROM Accounts WHERE AccountID = ?";
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setInt(1, booking.getAccountID());
                        try (ResultSet rs = ps.executeQuery()) {
                            String fullName = rs.next() ? rs.getString("FullName") : "N/A";
                            fullNameMap.put(booking.getBookingID(), fullName != null ? fullName : "N/A");
                        }
                    }
                } catch (SQLException e) {
                    fullNameMap.put(booking.getBookingID(), "N/A");
                    LOGGER.warning("Lỗi khi lấy FullName cho AccountID " + booking.getAccountID() + ": " + e.getMessage());
                }
            }
        }
        request.setAttribute("fullNameMap", fullNameMap);

        request.getRequestDispatcher("/BookTable/AdminViewTable.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        DAORoom daoRoom = new DAORoom();
        DAORoomBooking daoBooking = new DAORoomBooking();
        try {
            if ("checkin".equals(action)) {
                // Lấy tham số từ form
                String roomIdStr = request.getParameter("roomId");
                String peopleStr = request.getParameter("people");
                String name = request.getParameter("name");
                Integer accountId = (Integer) session.getAttribute("accountId");

                // Validate inputs
                if (roomIdStr == null || peopleStr == null || name == null ||
                    roomIdStr.isEmpty() || peopleStr.isEmpty() || name.isEmpty()) {
                    throw new IllegalArgumentException("Vui lòng điền đầy đủ thông tin!");
                }

                int roomId, people;
                try {
                    roomId = Integer.parseInt(roomIdStr);
                    people = Integer.parseInt(peopleStr);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Mã bàn hoặc số lượng khách không hợp lệ!");
                }

                // Sử dụng thời gian thực
                Calendar cal = Calendar.getInstance();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                sdf.setTimeZone(java.util.TimeZone.getTimeZone("GMT+07:00"));
                Timestamp startTime = new Timestamp(cal.getTimeInMillis());
                cal.add(Calendar.HOUR_OF_DAY, 2); // Thêm 2 giờ làm endTime
                Timestamp endTime = new Timestamp(cal.getTimeInMillis());

                // Thực hiện check-in
                boolean success = daoBooking.directBookRoom(roomId, accountId, startTime, endTime, people, name, "checkin", 0);
                if (success) {
                    request.setAttribute("success", "Check-in bàn thành công!");
                } else {
                    request.setAttribute("error", "Không thể check-in bàn!");
                }
            } else if ("checkout".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                boolean success = daoBooking.directBookRoom(0, 0, null, null, 0, null, "checkout", bookingId);
                if (success) {
                    request.setAttribute("success", "Check-out bàn thành công!");
                } else {
                    request.setAttribute("error", "Không thể check-out bàn!");
                }
            } else if ("cancel".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                if (daoBooking.cancelBooking(bookingId)) {
                    request.setAttribute("success", "Hủy đặt bàn thành công!");
                } else {
                    request.setAttribute("error", "Không thể hủy đặt bàn! Kiểm tra trạng thái hoặc dữ liệu.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi xử lý hành động: " + e.getMessage(), e);
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        // Tải lại danh sách
        List<Room> rooms = null;
        List<RoomBooking> bookings = null;
        try {
            rooms = daoRoom.getAllRooms();
            bookings = daoBooking.getAllBookings();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tải lại danh sách: " + e.getMessage(), e);
            request.setAttribute("error", "Không thể tải danh sách: " + e.getMessage());
        }
        request.setAttribute("rooms", rooms);
        request.setAttribute("bookings", bookings);

        Map<Integer, String> fullNameMap = new HashMap<>();
        if (bookings != null) {
            for (RoomBooking booking : bookings) {
                try {
                    String sql = "SELECT FullName FROM Accounts WHERE AccountID = ?";
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setInt(1, booking.getAccountID());
                        try (ResultSet rs = ps.executeQuery()) {
                            String fullName = rs.next() ? rs.getString("FullName") : "N/A";
                            fullNameMap.put(booking.getBookingID(), fullName != null ? fullName : "N/A");
                        }
                    }
                } catch (SQLException e) {
                    fullNameMap.put(booking.getBookingID(), "N/A");
                    LOGGER.warning("Lỗi khi lấy FullName cho AccountID " + booking.getAccountID() + ": " + e.getMessage());
                }
            }
        }
        request.setAttribute("fullNameMap", fullNameMap);

        request.getRequestDispatcher("/BookTable/AdminViewTable.jsp").forward(request, response);
    }
}
