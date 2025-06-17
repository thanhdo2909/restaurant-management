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
 */
public class DAOOrderDetail implements IDAOOrderDetail {

    private static final String orderQuery
            = "SELECT OD.OrderDetailID, O.OrderID, F.FoodID, F.DefaultFoodName AS FoodName, "
            + "F.Image, OD.Quantity, OD.Price, (OD.Quantity * OD.Price) AS TotalPrice, O.OrderDate "
            + "FROM OrderDetails OD "
            + "JOIN [Order] O ON OD.OrderID = O.OrderID "
            + "JOIN Food F ON OD.FoodID = F.FoodID "
            + "WHERE O.AccountID = ? "
            + "ORDER BY O.OrderDate DESC";
    private static final String addOrder = "INSERT INTO OrderDetails (OrderID, FoodID, Quantity, Price) VALUES (?, ?, ?, ?)";

    @Override
    public List<OrderDetail> getCartByUserId(int userId) {
        List<OrderDetail> orderDetails = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(orderQuery)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail(
                            rs.getInt(1), 
                            rs.getInt(2), 
                            rs.getInt(3), 
                            rs.getString(4), 
                            rs.getString(5),
                            rs.getInt(6), 
                            rs.getDouble(7)
                    );
                    orderDetails.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderDetails;
    }

    @Override
    public boolean order(String orderId, String foodId, String Quantity, String price) {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(addOrder)) {
            ps.setString(1, orderId);
            ps.setString(2, foodId);
            ps.setString(3, Quantity);
            ps.setString(4, price);
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }
}
