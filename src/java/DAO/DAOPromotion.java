/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Promotion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
/**
 *
 * @author admin
 */
public class DAOPromotion {

    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    public List<Promotion> getAll() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Promotion p = new Promotion(
                    rs.getInt("PromoID"),
                    rs.getString("PromoCode"),
                    rs.getFloat("DiscountPercent"),
                    rs.getDate("ExpirationDate"),
                    rs.getBoolean("IsActive")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Promotion> getAllActive() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Promotion p = new Promotion(
                    rs.getInt("PromoID"),
                    rs.getString("PromoCode"),
                    rs.getFloat("DiscountPercent"),
                    rs.getDate("ExpirationDate"),
                    rs.getBoolean("IsActive")
                );
                if(p.isActive()) list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public Promotion getById(int id) {
        String sql = "SELECT * FROM Promotions WHERE PromoID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Promotion(
                        rs.getInt("PromoID"),
                        rs.getString("PromoCode"),
                        rs.getFloat("DiscountPercent"),
                        rs.getDate("ExpirationDate"),
                        rs.getBoolean("IsActive")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void add(Promotion p) {
        String sql = "INSERT INTO Promotions (PromoCode, DiscountPercent, ExpirationDate, IsActive) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getPromoCode());
            ps.setFloat(2, p.getDiscountPercent());
            ps.setDate(3, p.getExpirationDate());
            ps.setBoolean(4, p.isIsActive());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Promotion p) {
        String sql = "UPDATE Promotions SET PromoCode=?, DiscountPercent=?, ExpirationDate=?, IsActive=? WHERE PromoID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getPromoCode());
            ps.setFloat(2, p.getDiscountPercent());
            ps.setDate(3, p.getExpirationDate());
            ps.setBoolean(4, p.isIsActive());
            ps.setInt(5, p.getPromoID());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Promotions WHERE PromoID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void toggleStatus(int id, boolean active) {
        String sql = "UPDATE Promotions SET IsActive=? WHERE PromoID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}