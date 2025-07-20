package DAO;

import Model.Room;
import java.sql.Timestamp;
import java.util.List;

public interface IDAORoom {
    List<Room> getAllRooms() ;
    Room getRoomById(int roomId) ;
    List<Room> getAvailableRooms(int people, Timestamp startTime, Timestamp endTime);
    void updateRoomStatus(int roomId, String status) ;
}