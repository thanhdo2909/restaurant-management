/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.User;
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
public class DAOUser implements IDAOUser {

    private static final String Querry_all = "select * from Users";
    private static final String insertUser="INSERT INTO Users (FullName, Email, TierID) VALUES (?, ?, ?)";

    @Override

    public ArrayList<User> getAll() {
        List<User> UserList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDate(4), 
                        rs.getTimestamp(5) 
                );

                UserList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<User>) UserList;
    }

    @Override
    public boolean InserUser(String name , String email) {
          try (Connection conn =  DBConnection.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(insertUser)) {

        ps.setString(1, name);
        ps.setString(2, email);
      ps.setString(3, "1");

        int rowsInserted = ps.executeUpdate();

        

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
        return false;
     
         
    
}
}
