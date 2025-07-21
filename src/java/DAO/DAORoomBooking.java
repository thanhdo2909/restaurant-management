package DAO;

import Model.RoomBooking;
import java.lang.System.Logger.Level;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAORoomBooking {
    public boolean isRoomBooked(int roomId, Timestamp startTime, Timestamp endTime) throws SQLException {
        String sql = "SELECT COUNT(*) FROM RoomBookings WHERE RoomID = ? AND Status IN ('Booked', 'CheckedIn') " +
                "AND ((StartTime < ? AND EndTime > ?) OR (StartTime < ? AND EndTime > ?) OR (StartTime >= ? AND EndTime <= ?))";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setTimestamp(2, endTime);
            ps.setTimestamp(3, startTime);
            ps.setTimestamp(4, endTime);
            ps.setTimestamp(5, startTime);
            ps.setTimestamp(6, startTime);
            ps.setTimestamp(7, endTime);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean isTimeSlotValid(int roomId, Timestamp startTime, Timestamp endTime) throws SQLException {
        String sql = "SELECT StartTime, EndTime FROM RoomBookings WHERE RoomID = ? AND Status IN ('Booked', 'CheckedIn')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Timestamp existingStart = rs.getTimestamp("StartTime");
                    Timestamp existingEnd = rs.getTimestamp("EndTime");
                    long oneHourInMillis = 60 * 60 * 1000;
                    if (startTime.getTime() < existingEnd.getTime() + oneHourInMillis &&
                        endTime.getTime() > existingStart.getTime() - oneHourInMillis) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    public boolean addRoomBooking(RoomBooking booking) throws SQLException {
        String sql = "INSERT INTO RoomBookings (AccountID, RoomID, StartTime, EndTime, Status, People, Message, Phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getAccountID());
            ps.setInt(2, booking.getRoomID());
            ps.setTimestamp(3, booking.getStartTime());
            ps.setTimestamp(4, booking.getEndTime());
            ps.setString(5, booking.getStatus());
            ps.setInt(6, booking.getPeople());
            ps.setString(7, booking.getMessage());
            ps.setString(8, booking.getPhone());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean directBookRoom(int roomId, int accountId, Timestamp startTime, Timestamp endTime, int people, String name, String action, int bookingId) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                if ("checkin".equalsIgnoreCase(action)) {
                    if (isRoomBooked(roomId, startTime, endTime)) {
                        throw new SQLException("Phòng đã được đặt hoặc check-in trong khoảng thời gian này!");
                    }
                    if (!isTimeSlotValid(roomId, startTime, endTime)) {
                        throw new SQLException("Thời gian đặt phòng phải cách các đặt phòng khác ít nhất 1 giờ!");
                    }

                    String capacitySql = "SELECT MaxCapacity FROM Rooms WHERE RoomID = ?";
                    try (PreparedStatement ps = conn.prepareStatement(capacitySql)) {
                        ps.setInt(1, roomId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) {
                                int maxCapacity = rs.getInt("MaxCapacity");
                                if (people > maxCapacity) {
                                    throw new SQLException("Số người vượt quá sức chứa tối đa (" + maxCapacity + ")!");
                                }
                            } else {
                                throw new SQLException("Phòng không tồn tại!");
                            }
                        }
                    }

                    RoomBooking booking = new RoomBooking();
                    booking.setAccountID(accountId);
                    booking.setRoomID(roomId);
                    booking.setStartTime(startTime);
                    booking.setEndTime(endTime);
                    booking.setStatus("CheckedIn");
                    booking.setPeople(people);
                    booking.setPhone(name);
                    booking.setMessage("Direct check-in by admin");

                    boolean success = addRoomBooking(booking);
                    if (!success) {
                        throw new SQLException("Không thể tạo booking trực tiếp!");
                    }
                } else if ("checkout".equalsIgnoreCase(action)) {
                    String sql = "UPDATE RoomBookings SET Status = 'Completed' WHERE BookingID = ? AND Status IN ('Booked', 'CheckedIn')";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setInt(1, bookingId);
                        int affected = ps.executeUpdate();
                        if (affected == 0) {
                            throw new SQLException("Không thể check-out: Booking không tồn tại hoặc đã hoàn tất!");
                        }
                    }
                } else {
                    throw new SQLException("Hành động không hợp lệ: " + action);
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public boolean submitCancellationRequest(int bookingId, int accountId) throws SQLException {
        String sql = "UPDATE RoomBookings SET Status = 'PendingCancellation' WHERE BookingID = ? AND AccountID = ? AND Status = 'Booked'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, accountId);
            int affected = ps.executeUpdate();
            System.out.println("Submit cancellation request for booking " + bookingId + ": " + (affected > 0 ? "Success" : "Failed"));
            return affected > 0;
        }
    }

    public boolean approveCancellation(int bookingId) throws SQLException {
        String sql = "UPDATE RoomBookings SET Status = 'Cancelled' WHERE BookingID = ? AND Status = 'PendingCancellation'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            int affected = ps.executeUpdate();
            return affected > 0;
        }
    }

    public boolean rejectCancellation(int bookingId) throws SQLException {
        String sql = "UPDATE RoomBookings SET Status = 'Booked' WHERE BookingID = ? AND Status = 'PendingCancellation'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            int affected = ps.executeUpdate();
            return affected > 0;
        }
    }

    public List<RoomBooking> getPendingCancellations() throws SQLException {
        List<RoomBooking> list = new ArrayList<>();
        String sql = "SELECT rb.*, a.FullName FROM RoomBookings rb LEFT JOIN Accounts a ON rb.AccountID = a.AccountID WHERE rb.Status = 'PendingCancellation'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RoomBooking booking = new RoomBooking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setAccountID(rs.getInt("AccountID"));
                booking.setRoomID(rs.getInt("RoomID"));
                booking.setStartTime(rs.getTimestamp("StartTime"));
                booking.setEndTime(rs.getTimestamp("EndTime"));
                booking.setStatus(rs.getString("Status"));
                booking.setPeople(rs.getInt("People"));
                booking.setMessage(rs.getString("Message"));
                booking.setPhone(rs.getString("Phone"));
                list.add(booking);
            }
        }
        return list;
    }

    public List<RoomBooking> getBookingsByRoom(int roomId) throws SQLException {
        List<RoomBooking> list = new ArrayList<>();
        String sql = "SELECT rb.*, a.FullName FROM RoomBookings rb LEFT JOIN Accounts a ON rb.AccountID = a.AccountID WHERE rb.RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoomBooking booking = new RoomBooking();
                    booking.setBookingID(rs.getInt("BookingID"));
                    booking.setAccountID(rs.getInt("AccountID"));
                    booking.setRoomID(rs.getInt("RoomID"));
                    booking.setStartTime(rs.getTimestamp("StartTime"));
                    booking.setEndTime(rs.getTimestamp("EndTime"));
                    booking.setStatus(rs.getString("Status"));
                    booking.setPeople(rs.getInt("People"));
                    booking.setMessage(rs.getString("Message"));
                    booking.setPhone(rs.getString("Phone"));
                    list.add(booking);
                }
            }
        }
        return list;
    }

    public List<RoomBooking> getBookingsByAccount(int accountId) throws SQLException {
        List<RoomBooking> list = new ArrayList<>();
        String sql = "SELECT rb.*, a.FullName FROM RoomBookings rb LEFT JOIN Accounts a ON rb.AccountID = a.AccountID WHERE rb.AccountID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoomBooking booking = new RoomBooking();
                    booking.setBookingID(rs.getInt("BookingID"));
                    booking.setAccountID(rs.getInt("AccountID"));
                    booking.setRoomID(rs.getInt("RoomID"));
                    booking.setStartTime(rs.getTimestamp("StartTime"));
                    booking.setEndTime(rs.getTimestamp("EndTime"));
                    booking.setStatus(rs.getString("Status"));
                    booking.setPeople(rs.getInt("People"));
                    booking.setMessage(rs.getString("Message"));
                    booking.setPhone(rs.getString("Phone"));
                    list.add(booking);
                }
            }
        }
        return list;
    }

    public boolean cancelBooking(int bookingId) throws SQLException {
        String sql = "UPDATE RoomBookings SET Status = 'Cancelled' WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            int affected = ps.executeUpdate();
            System.out.println("Cancel booking " + bookingId + ": " + (affected > 0 ? "Success" : "Failed"));
            return affected > 0;
        }
    }

    public boolean cancelBookingForUser(int bookingId, int accountId) throws SQLException {
        return submitCancellationRequest(bookingId, accountId); // Gửi yêu cầu hủy
    }

    public List<RoomBooking> getAllBookings() throws SQLException {
        List<RoomBooking> list = new ArrayList<>();
        String sql = "SELECT rb.*, a.FullName FROM RoomBookings rb LEFT JOIN Accounts a ON rb.AccountID = a.AccountID";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RoomBooking booking = new RoomBooking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setAccountID(rs.getInt("AccountID"));
                booking.setRoomID(rs.getInt("RoomID"));
                booking.setStartTime(rs.getTimestamp("StartTime"));
                booking.setEndTime(rs.getTimestamp("EndTime"));
                booking.setStatus(rs.getString("Status"));
                booking.setPeople(rs.getInt("People"));
                booking.setMessage(rs.getString("Message"));
                booking.setPhone(rs.getString("Phone"));
                list.add(booking);
            }
        }
        return list;
    }
}   