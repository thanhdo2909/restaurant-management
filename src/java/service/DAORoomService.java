package service;

import DAO.DAORoom;
import Model.Room;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DAORoomService {
    private final DAORoom daoRoom;

    public DAORoomService() {
        this.daoRoom = new DAORoom();
    }

    public List<Room> getAllRooms() throws SQLException {
        try {
            return daoRoom.getAllRooms();
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<Room> getAvailableRooms(int people, Timestamp startTime, Timestamp endTime) throws SQLException {
        try {
            return daoRoom.getAvailableRooms(people, startTime, endTime);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Room getRoomById(int roomId) throws SQLException {
        try {
            return daoRoom.getRoomById(roomId);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}