// ===== src/java/DAO/DAOOrder.java =====
package DAO;

import Model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOOrder implements IDAOOrder {
    private static final String ADD_ORDER =
        "INSERT INTO Orders (AccountID, ShipperID, TotalAmount, Status, CreatedAt) VALUES (?, ?, ?, ?, GETDATE())";
    private static final String ADD_ORDER_OFF =
        "INSERT INTO Orders (AccountID, TotalAmount, Status, CreatedAt) VALUES (?, ?, ?, GETDATE())";

    @Override
    public boolean addOrder(String accountId, String shipperId, String totalAmount, String status) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(ADD_ORDER)) {
            ps.setInt(1, Integer.parseInt(accountId));
            ps.setString(2, shipperId);
            ps.setDouble(3, Double.parseDouble(totalAmount));
            ps.setString(4, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addOrderOff(String accountId, String totalAmount, String status) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(ADD_ORDER_OFF)) {
            ps.setInt(1, Integer.parseInt(accountId));
            ps.setDouble(2, Double.parseDouble(totalAmount));
            ps.setString(3, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

  

    @Override
    public List<Order> findByStatuses(List<String> statuses) throws Exception {
        if (statuses.isEmpty()) return new ArrayList<>();
        String placeholders = String.join(",", java.util.Collections.nCopies(statuses.size(), "?"));
        String sql = "SELECT OrderID, AccountID, ShipperID, TotalAmount, Status, CreatedAt FROM Orders WHERE Status IN (" + placeholders + ")";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < statuses.size(); i++) {
                ps.setString(i + 1, statuses.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                List<Order> list = new ArrayList<>();
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setUserID(rs.getInt("AccountID"));
                    o.setShipperID(rs.getInt("ShipperID"));
                    o.setTotalAmount(rs.getDouble("TotalAmount"));
                    o.setStatus(rs.getString("Status"));
                    o.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    list.add(o);
                }
                return list;
            }
        }
    }

    @Override
    public Order findById(int orderID) throws Exception {
        String sql = "SELECT OrderID, AccountID, ShipperID, TotalAmount, Status, CreatedAt FROM Orders WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setUserID(rs.getInt("AccountID"));
                    o.setShipperID(rs.getInt("ShipperID"));
                    o.setTotalAmount(rs.getDouble("TotalAmount"));
                    o.setStatus(rs.getString("Status"));
                    o.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return o;
                }
                return null;
            }
        }
    }

    @Override
    public void assignShipper(int orderID, int shipperID) throws Exception {
        String sql = "UPDATE Orders SET ShipperID = ?, Status = 'InDelivery' WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shipperID);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateStatus(int orderID, String newStatus) throws Exception {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        }
    }

    @Override
    public List<Order> findByStatus(String status) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }


}
