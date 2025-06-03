/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.RoomBooking;
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
public class DAORoomBooking implements IDAORoomBooking  {
 private static final String    Querry_all = "select * from RoomBookings";
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
    
}
