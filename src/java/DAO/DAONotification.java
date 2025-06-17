/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Notification;
import java.util.ArrayList;
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
public class DAONotification implements IDAONotification  {
private static final String GET_ALL = "SELECT * FROM Notifications WHERE AccountID = ?";
private static final String notificationDatail = "SELECT * FROM Notifications WHERE Id = ?";
private static final String isRead = "Update Notifications set IsRead=1 WHERE Id = ?";
    @Override
    public ArrayList<Notification> getAll(String id) {
         ArrayList<Notification> notifications = new ArrayList<>();

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(GET_ALL)) {

        ps.setString(1, id);  // Truyền tham số vào câu lệnh SQL
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Notification n = new Notification( 
                    rs.getInt("Id"),// Notification ID
                rs.getInt("AccountID"),
                rs.getString("Title"),
                rs.getString("Message"),
                rs.getString("CreatedAt"),
                rs.getBoolean("IsRead")
            );
            notifications.add(n);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return notifications;
    }

    @Override
    public Notification notificationDetail(String id) {
        try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(notificationDatail)) {

        ps.setString(1, id);  
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
           return  new Notification( 
                    rs.getInt("Id"),
                rs.getInt("AccountID"),
                rs.getString("Title"),
                rs.getString("Message"),
                rs.getString("CreatedAt"),
                rs.getBoolean("IsRead")
            );
          
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
    }

    @Override
    public boolean isRead(String id) {
         try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(isRead)) {

        ps.setString(1, id);  
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return rs.getBoolean("IsRead"); 
        }
        

    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
    }
}
    


    
    


