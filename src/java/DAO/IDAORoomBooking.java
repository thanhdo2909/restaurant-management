package DAO;

import Model.RoomBooking;
import java.sql.Timestamp;
import java.util.List;

public interface IDAORoomBooking {
    List<RoomBooking> getAllBookings();
    boolean isRoomBooked(int roomId, Timestamp startTime, Timestamp endTime) ;
    boolean addRoomBooking(RoomBooking booking) ;
    List<RoomBooking> getBookingsByRoom(int roomId) ;
    List<RoomBooking> getBookingsByAccount(int accountId) ;
    boolean cancelBooking(int bookingId) ;
}