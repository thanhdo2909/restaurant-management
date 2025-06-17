/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetail;
import Model.OrderHistory;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 *
 * @author ACER
 */
public class DAOOrderHistory implements IDAOOrderHistory {
  private static final String getAll = "SELECT \n" +
"    o.OrderID, o.CreatedAt, o.TotalAmount, o.Status, \n" +
"    od.OrderDetailID, od.FoodID, od.Quantity, od.Price, \n" +
"    f.FoodName, f.Image\n" +
"FROM Orders o\n" +
"LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID\n" +
"LEFT JOIN Food f ON od.FoodID = f.FoodID\n" +
"WHERE o.AccountID = ?\n" +
"ORDER BY o.CreatedAt DESC;";
    @Override
    public ArrayList<OrderHistory> getAll(String id) {
          Map<Integer, OrderHistory> orderMap = new LinkedHashMap<>();

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(getAll)) {

        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int orderId = rs.getInt("OrderID");

            OrderHistory order = orderMap.get(orderId);
            if (order == null) {
                order = new OrderHistory();
                order.setOrderId(orderId);
                order.setCreateAt(rs.getTimestamp("CreatedAt"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setOrderDetail(new ArrayList<>());

                // lấy ảnh món đầu tiên làm đại diện
                order.setImg(rs.getString("Image"));

                orderMap.put(orderId, order);
            }

            OrderDetail detail = new OrderDetail();
            detail.setOrderDetailID(rs.getInt("OrderDetailID"));
            detail.setOrderID(orderId);
            detail.setFoodID(rs.getInt("FoodID"));
             detail.setFoodName(rs.getString("FoodName"));
            detail.setQuantity(rs.getInt("Quantity"));
            detail.setPrice(rs.getDouble("Price"));
          detail.setImg(rs.getString("Image"));
       

            order.getOrderDetail().add(detail);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return new ArrayList<>(orderMap.values());
    }
    
}
