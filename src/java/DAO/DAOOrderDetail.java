/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Account;
import Model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */public class DAOOrderDetail extends IDAOOrderDetail {

    private static final String orderQuery = 
        "SELECT OD.OrderDetailID, O.OrderID, F.DefaultFoodName AS FoodName, " +
        "OD.Quantity, OD.Price, (OD.Quantity * OD.Price) AS TotalPrice, O.OrderDate " +
        "FROM OrderDetails OD " +
        "JOIN [Order] O ON OD.OrderID = O.OrderID " +
        "JOIN Food F ON OD.FoodID = F.FoodID " +
        "WHERE O.AccountID = ? " +
        "ORDER BY O.OrderDate DESC";

 
    public List<OrderDetail> getCartByUserId(int userId) throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(orderQuery)) {
             
            ps.setInt(1, userId); 
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(4),
                        rs.getInt(3),
                        rs.getInt(5),
                        rs.getDouble(6)
                    );
                    orderDetails.add(detail); 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderDetails;
    }
}
