
package DAO;

import Model.RoomBooking;
import java.beans.Statement;
import java.sql.Timestamp;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ACER
 */
public class DAORoomBooking implements IDAORoomBooking {

    private static final String Querry_all = "select * from RoomBookings";
    private static final String checkroom = "SELECT TOP 1 RoomID FROM Rooms\n"
            + "            WHERE RoomID NOT IN (\n"
            + "                SELECT RoomID FROM RoomBookings\n"
            + "                WHERE StartTime < ? AND EndTime > ?\n"
            + "            )";
private static final String bookRoom ="INSERT INTO RoomBookings (AccountID, RoomID, StartTime, EndTime)\n" +
"VALUES (?, ?, ?, ?)";
private static final String RoomId ="SELECT TOP 1 BookingID\n" +
"FROM RoomBookings\n" +
"WHERE AccountID = ?\n" +
"ORDER BY StartTime DESC";
    @Override
    public ArrayList<RoomBooking> getAll() {
        List<RoomBooking> AccountList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RoomBooking account = new RoomBooking(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getDate(4),
                        rs.getDate(5)
                );

                AccountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<RoomBooking>) AccountList;
    }

    @Override
    public int checkAvailableRoom(String startTime, String endTime) {
         int roomId = -1;
      
    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(checkroom)
    ) {
        ps.setString(1, endTime);  
        ps.setString(2, startTime);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            roomId = rs.getInt("RoomID");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return roomId;
        }

    @Override
    public boolean BookRoom(String accountId, String roomId, String startTime, String endTime) {
         try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(bookRoom)
    ) {
        ps.setInt(1, Integer.parseInt(accountId));
        ps.setInt(2, Integer.parseInt(roomId));
        ps.setTimestamp(3, Timestamp.valueOf(startTime));
        ps.setTimestamp(4, Timestamp.valueOf(endTime));

        int rows = ps.executeUpdate();
        return rows > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
    }

    @Override
    public int RoomId(String id) {
         int bookingId = -1; 
    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(RoomId)
    ) {
        ps.setString(1, id);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            bookingId = rs.getInt("BookingID");  
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return bookingId;

    }
}
