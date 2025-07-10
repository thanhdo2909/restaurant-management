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
        int id;
        try {
            if (request.getParameter("roomId") != null) {
                id = Integer.parseInt(request.getParameter("roomId"));
                DAORoom dao = new DAORoom();
                if ("cancel".equals(action)) {
                    if (dao.updateBookingStatus(id, "Cancelled")) {
                        dao.updateRoomStatus(id, "Available");
                        request.setAttribute("success", "Hủy booking thành công! Bàn đã sẵn sàng.");
                    } else {
                        request.setAttribute("error", "Không thể hủy booking! Kiểm tra trạng thái hoặc dữ liệu.");
                    }
                } else if ("complete".equals(action)) {
                    if (dao.updateBookingStatus(id, "Completed")) {
                        dao.updateRoomStatus(id, "Available");
                        request.setAttribute("success", "Đánh dấu hoàn tất thanh toán thành công! Bàn đã sẵn sàng.");
                    } else {
                        request.setAttribute("error", "Không thể đánh dấu hoàn tất! Kiểm tra trạng thái hoặc dữ liệu.");
                    }
                }
            } else if (request.getParameter("bookingId") != null) {
                id = Integer.parseInt(request.getParameter("bookingId"));
                DAORoomBooking daoBooking = new DAORoomBooking();
                DAORoom daoRoom = new DAORoom();
                if ("cancel".equals(action)) {
                    String sql = "SELECT RoomID FROM RoomBookings WHERE BookingID = ?";
                    int roomId = -1;
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setInt(1, id);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) {
                                roomId = rs.getInt("RoomID");
                            }
                        }
                    }
                    if (roomId != -1) {
                        if (daoBooking.cancelBooking(id)) {
                            daoRoom.updateRoomStatus(roomId, "Available");
                            request.setAttribute("success", "Kết thúc đặt bàn thành công! Bàn đã sẵn sàng.");
                        } else {
                            request.setAttribute("error", "Không thể kết thúc đặt bàn! Kiểm tra trạng thái hoặc dữ liệu.");
                        }
                    } else {
                        request.setAttribute("error", "Không tìm thấy RoomID cho BookingID: " + id);
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi xử lý hành động: " + e.getMessage(), e);
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ!");
        }

        DAORoom daoRoom = new DAORoom();
        DAORoomBooking daoBooking = new DAORoomBooking();
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