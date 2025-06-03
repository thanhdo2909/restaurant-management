/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Room;
import java.beans.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ACER
 */
public class DAORoom implements IDAORoom {

    private static final String Querry_all = " select * from Rooms";

    @Override
    public ArrayList<Room> getAll() {

        List<Room> RoomList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room room = new Room(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                );

                RoomList.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<Room>) RoomList;

    }

}
