package DAO;

import Model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level; // Đảm bảo import này

public class DAORoom {
    private static final Logger LOGGER = Logger.getLogger(DAORoom.class.getName());

    // Lấy tất cả các bàn với trạng thái từ RoomBookings
    public List<Room> getAllRooms() throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, COALESCE(rb.Status, 'Available') AS Status " +
                     "FROM Rooms r LEFT JOIN RoomBookings rb ON r.RoomID = rb.RoomID " +
                     "ORDER BY r.RoomID ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomType(rs.getString("RoomType"));
                room.setMaxCapacity(rs.getInt("MaxCapacity"));
                room.setStatus(rs.getString("Status"));
                room.setQrCodePath(rs.getString("QRCodePath"));
                list.add(room);
                LOGGER.info("Loaded RoomID: " + room.getRoomID() + ", Status: " + room.getStatus());
            }
            LOGGER.info("Total rooms loaded: " + list.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách Rooms: " + e.getMessage(), e); // Đảm bảo cú pháp
            throw e;
        }
        return list;
    }

    // Lấy các bàn còn trống và đủ sức chứa trong thời gian cụ thể
    public List<Room> getAvailableRooms(int people, Timestamp startTime, Timestamp endTime) throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM Rooms WHERE MaxCapacity >= ? AND Status = 'Available' ORDER BY MaxCapacity, RoomID";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, people);
            try (ResultSet rs = ps.executeQuery()) {
                DAORoomBooking daoBooking = new DAORoomBooking();
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomID(rs.getInt("RoomID"));
                    room.setRoomType(rs.getString("RoomType"));
                    room.setMaxCapacity(rs.getInt("MaxCapacity"));
                    room.setStatus(rs.getString("Status"));
                    room.setQrCodePath(rs.getString("QRCodePath"));
                    if (!daoBooking.isRoomBooked(room.getRoomID(), startTime, endTime)) {
                        list.add(room);
                    }
                }
            }
        }
        return list;
    }

    // Lấy thông tin một bàn theo RoomID
    public Room getRoomById(int roomId) throws SQLException {
        String sql = "SELECT r.*, COALESCE(rb.Status, 'Available') AS Status " +
                     "FROM Rooms r LEFT JOIN RoomBookings rb ON r.RoomID = rb.RoomID " +
                     "WHERE r.RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Room room = new Room();
                    room.setRoomID(rs.getInt("RoomID"));
                    room.setRoomType(rs.getString("RoomType"));
                    room.setMaxCapacity(rs.getInt("MaxCapacity"));
                    room.setStatus(rs.getString("Status"));
                    room.setQrCodePath(rs.getString("QRCodePath"));
                    return room;
                }
            }
        }
        return null;
    }

    // Cập nhật trạng thái bàn trong Rooms
    public void updateRoomStatus(int roomId, String status) throws SQLException {
        String sql = "UPDATE Rooms SET Status = ? WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, roomId);
            ps.executeUpdate();
        }
    }

    // Cập nhật trạng thái booking trong RoomBookings
    public boolean updateBookingStatus(int roomId, String status) throws SQLException {
        String sql = "UPDATE RoomBookings SET Status = ? WHERE RoomID = ? AND Status IN ('Booked')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, roomId);
            int affected = ps.executeUpdate();
            if (affected == 0) {
                LOGGER.warning("Không có bản ghi nào được cập nhật cho RoomID: " + roomId + " với trạng thái mới: " + status);
            }
            return affected > 0;
        }
    }
    
    public boolean isValidRoomId(int roomId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Rooms WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        }
    }

    // Cập nhật đường dẫn mã QR
    public void updateQRCodePath(int roomId, String qrPath) throws SQLException {
        String sql = "UPDATE Rooms SET QRCodePath = ? WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, qrPath);
            ps.setInt(2, roomId);
            int affected = ps.executeUpdate();
            if (affected == 0) {
                LOGGER.warning("Không cập nhật được QRCodePath cho RoomID: " + roomId);
            }
        }
    }
}