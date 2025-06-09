/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author ACER
 */
import java.beans.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DAOOrder implements IDAOOrder {
   private static final String addOrder = "INSERT INTO Orders (AccountID, ShipperID, TotalAmount, Status, CreatedAt)\n" +
"VALUES (?, ?, ?, ?, GETDATE())";
     private static final String addOrderOff = "INSERT INTO Orders (AccountID, TotalAmount, Status, CreatedAt)\n" +
"VALUES (?, ?, ?, GETDATE())";
    @Override
    public boolean addOrder(String accountId, String shipperId, String totalAmount, String status) {
          try (Connection conn = DBConnection.getConnection(); 
                  PreparedStatement ps = conn.prepareStatement(addOrder)) {
            ps.setString(1, accountId);
            ps.setString(2, shipperId);
            ps.setString(3, totalAmount);
            ps.setString(4, status);
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addOrderOff(String accountId, String totalAmount, String status) {
           try (Connection conn = DBConnection.getConnection(); 
                  PreparedStatement ps = conn.prepareStatement(addOrder)) {
            ps.setString(1, accountId);
            ps.setString(2, totalAmount);
            ps.setString(3, status);
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
}
