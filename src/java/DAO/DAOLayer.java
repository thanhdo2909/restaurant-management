package DAO;

import Model.BestSellingFood;
import Model.OrderChartStats;
import Model.RevenueStats;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOLayer {

    public static final String day = "SELECT CAST(CreatedAt AS DATE) AS TimeUnit, SUM(TotalAmount) AS TotalRevenue "
            + "FROM Orders WHERE Status = 'Completed' "
            + "GROUP BY CAST(CreatedAt AS DATE) ORDER BY TimeUnit";
    public static final String month = "SELECT FORMAT(CreatedAt, 'yyyy-MM') AS TimeUnit, SUM(TotalAmount) AS TotalRevenue "
            + "FROM Orders WHERE Status = 'Completed' "
            + "GROUP BY FORMAT(CreatedAt, 'yyyy-MM') ORDER BY TimeUnit";
    public static final String year = "SELECT CAST(YEAR(CreatedAt) AS VARCHAR) AS TimeUnit, SUM(TotalAmount) AS TotalRevenue "
            + "FROM Orders WHERE Status = 'Completed' "
            + "GROUP BY YEAR(CreatedAt) ORDER BY TimeUnit";
    public static final String quarter = "SELECT CONCAT('Q', DATEPART(QUARTER, CreatedAt), '-', YEAR(CreatedAt)) AS TimeUnit, "
            + "SUM(TotalAmount) AS TotalRevenue "
            + "FROM Orders WHERE Status = 'Completed' "
            + "GROUP BY DATEPART(QUARTER, CreatedAt), YEAR(CreatedAt) "
            + "ORDER BY YEAR(CreatedAt), DATEPART(QUARTER, CreatedAt)";
    public static final String bestSellingFood =    "SELECT f.FoodID, f.FoodName, SUM(od.Quantity) AS TotalSold " +
    "FROM OrderDetails od " +
    "JOIN Orders o ON od.OrderID = o.OrderID " +
    "JOIN Food f ON od.FoodID = f.FoodID " +
    "WHERE o.Status = 'Completed' " +
    "GROUP BY f.FoodID, f.FoodName " +
    "ORDER BY TotalSold DESC";

    public List<RevenueStats> getRevenueByTime(String filterType) {
        List<RevenueStats> list = new ArrayList<>();
        String sql = "";

        switch (filterType) {
            case "day":
                sql = day;
                break;
            case "month":
                sql = month;
                break;
            case "year":
                sql = year;
                break;
            case "quarter":
                sql = quarter;
                break;
            default:
                return list;
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RevenueStats(rs.getString("TimeUnit"), rs.getBigDecimal("TotalRevenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BestSellingFood> getBestSellingFoods() {
        List<BestSellingFood> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(bestSellingFood); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new BestSellingFood(
                        rs.getInt("FoodID"),
                        rs.getString("FoodName"),
                        rs.getInt("TotalSold")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<OrderChartStats> getOrderCountByTime(String filterType) {
    List<OrderChartStats> list = new ArrayList<>();
    String sql = "";

    switch (filterType) {
        case "day":
            sql = "SELECT CAST(CreatedAt AS DATE) AS TimeUnit, COUNT(*) AS OrderCount FROM Orders GROUP BY CAST(CreatedAt AS DATE) ORDER BY TimeUnit";
            break;
        case "week":
            sql = "SELECT CONCAT('Week ', DATEPART(WEEK, CreatedAt), '-', YEAR(CreatedAt)) AS TimeUnit, COUNT(*) AS OrderCount FROM Orders GROUP BY DATEPART(WEEK, CreatedAt), YEAR(CreatedAt) ORDER BY YEAR(CreatedAt), DATEPART(WEEK, CreatedAt)";
            break;
        case "month":
            sql = "SELECT FORMAT(CreatedAt, 'yyyy-MM') AS TimeUnit, COUNT(*) AS OrderCount FROM Orders GROUP BY FORMAT(CreatedAt, 'yyyy-MM') ORDER BY TimeUnit";
            break;
        default:
            return list;
    }

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(new OrderChartStats(rs.getString("TimeUnit"), rs.getInt("OrderCount")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
    public List<BestSellingFood> getCancelledFoods(String filterType) {
    List<BestSellingFood> list = new ArrayList<>();
    String sql = "";

    switch (filterType) {
        case "day":
            sql = "SELECT f.FoodName, SUM(od.Quantity) AS TotalCancelled " +
                  "FROM Orders o " +
                  "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                  "JOIN Food f ON od.FoodID = f.FoodID " +
                  "WHERE o.Status = 'Cancelled' AND CAST(o.CreatedAt AS DATE) = CAST(GETDATE() AS DATE) " +
                  "GROUP BY f.FoodName ORDER BY TotalCancelled DESC";
            break;
        case "month":
            sql = "SELECT f.FoodName, SUM(od.Quantity) AS TotalCancelled " +
                  "FROM Orders o " +
                  "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                  "JOIN Food f ON od.FoodID = f.FoodID " +
                  "WHERE o.Status = 'Cancelled' AND MONTH(o.CreatedAt) = MONTH(GETDATE()) AND YEAR(o.CreatedAt) = YEAR(GETDATE()) " +
                  "GROUP BY f.FoodName ORDER BY TotalCancelled DESC";
            break;
        case "quarter":
            sql = "SELECT f.FoodName, SUM(od.Quantity) AS TotalCancelled " +
                  "FROM Orders o " +
                  "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                  "JOIN Food f ON od.FoodID = f.FoodID " +
                  "WHERE o.Status = 'Cancelled' AND DATEPART(QUARTER, o.CreatedAt) = DATEPART(QUARTER, GETDATE()) AND YEAR(o.CreatedAt) = YEAR(GETDATE()) " +
                  "GROUP BY f.FoodName ORDER BY TotalCancelled DESC";
            break;
        case "year":
            sql = "SELECT f.FoodName, SUM(od.Quantity) AS TotalCancelled " +
                  "FROM Orders o " +
                  "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                  "JOIN Food f ON od.FoodID = f.FoodID " +
                  "WHERE o.Status = 'Cancelled' AND YEAR(o.CreatedAt) = YEAR(GETDATE()) " +
                  "GROUP BY f.FoodName ORDER BY TotalCancelled DESC";
            break;
        default:
            return list;
    }

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            list.add(new BestSellingFood(
                0, // foodID không cần thiết cho báo cáo huỷ
                rs.getString("FoodName"),
                rs.getInt("TotalCancelled") // dùng lại totalSold để đại diện số lượng huỷ
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}

    public static void main(String[] args) {
         DAOLayer dao = new DAOLayer();
    String filter = "month";

    List<BestSellingFood> cancelledFoods = dao.getCancelledFoods(filter);
    System.out.println("\n=== ❌ MÓN ĂN BỊ HUỶ (" + filter.toUpperCase() + ") ===");
    if (cancelledFoods.isEmpty()) {
        System.out.println("⚠️ Không có món ăn nào bị huỷ trong khoảng thời gian này.");
    } else {
        for (BestSellingFood item : cancelledFoods) {
            System.out.println("🍽️ " + item.getFoodName() + " - Số lượng bị huỷ: " + item.getTotalSold());
        }
    }

}
}
