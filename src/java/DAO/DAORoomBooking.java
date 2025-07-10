package DAO;

import Model.RoomBooking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAORoomBooking {
    public boolean isRoomBooked(int roomId, Timestamp startTime, Timestamp endTime) throws SQLException {
        String sql = "SELECT COUNT(*) FROM RoomBookings WHERE RoomID = ? AND Status = 'Booked' " +
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