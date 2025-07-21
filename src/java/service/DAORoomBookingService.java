package service;

import DAO.DAORoom;
import DAO.DAORoomBooking;
import Model.Room;
import Model.RoomBooking;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.regex.Pattern;

public class DAORoomBookingService {
    private final DAORoomBooking daoRoomBooking;
    private final DAORoom daoRoom;

    public DAORoomBookingService() {
        this.daoRoomBooking = new DAORoomBooking();
        this.daoRoom = new DAORoom();
    }

    public boolean isRoomAvailable(int roomId, Timestamp startTime, Timestamp endTime, int people, String phone) throws SQLException {
        if (people <= 0) {
            throw new IllegalArgumentException("Số người phải lớn hơn 0!");
        }
        if (startTime == null || endTime == null || startTime.after(endTime)) {
            throw new IllegalArgumentException("Thời gian đặt không hợp lệ!");
        }
        if (phone == null || !Pattern.matches("\\d{9,12}", phone)) {
            throw new IllegalArgumentException("Số điện thoại không hợp lệ! Vui lòng nhập 9-12 số.");
        }

        Room room = daoRoom.getRoomById(roomId);
        if (room == null) {
            throw new IllegalArgumentException("Không tồn tại bàn này!");
        }
        if (people > room.getMaxCapacity()) {
            throw new IllegalArgumentException("Số người vượt quá sức chứa bàn!");
        }
        boolean isBooked = daoRoomBooking.isRoomBooked(roomId, startTime, endTime);
        if (isBooked) {
            throw new IllegalArgumentException("Bàn đã có người đặt trong thời gian này!");
        }
        return true;
    }

    public boolean bookRoom(RoomBooking booking) throws SQLException {
        return daoRoomBooking.addRoomBooking(booking);
    }

    public Room getRoomById(int roomId) throws SQLException {
        return daoRoom.getRoomById(roomId);
    }

    public List<RoomBooking> getBookingsByRoom(int roomId) throws SQLException {
        return daoRoomBooking.getBookingsByRoom(roomId);
    }

    public List<RoomBooking> getBookingsByAccount(int accountId) throws SQLException {
        return daoRoomBooking.getBookingsByAccount(accountId);
    }

    public boolean cancelBooking(int bookingId) throws SQLException {
        return daoRoomBooking.cancelBooking(bookingId);
    }
}