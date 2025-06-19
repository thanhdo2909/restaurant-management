/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Review;
import java.beans.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ACER
 */
public class DAOReview implements IDAOReview {

    private static final String review = " select * from Reviews where FoodID= ?";
    private static final String INSERT_REVIEW = "INSERT INTO Reviews "
            + "(FoodID, AccountID, Comment, Rating, CreatedAt) "
            + "VALUES (?, ?, ?, ?, ?)";

    @Override
    public ArrayList<Review> getAll(String id) {

        ArrayList<Review> reviewList = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(review)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review Review = new Review(
                            rs.getInt(1),
                            rs.getInt(2),
                            rs.getInt(3),
                            rs.getString(4),
                            rs.getInt(5),
                            rs.getDate(6)
                    );
                    reviewList.add(Review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviewList;

    }

    @Override
    public boolean insertReview(String FoodId, String AccountId, String Comment, String Rating, String CreatedAt) {

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_REVIEW)) {

            ps.setString(1, FoodId);
            ps.setString(2, AccountId);
            ps.setString(3, Comment);
            ps.setString(4, Rating);
            ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));

            int affectedRows = ps.executeUpdate();
            return  true;
        } catch (SQLException ex) {
            Logger.getLogger(DAOReview.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false ;
    }
}


