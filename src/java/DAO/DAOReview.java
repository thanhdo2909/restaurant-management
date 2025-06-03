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

/**
 *
 * @author ACER
 */
public class DAOReview implements IDAOReview {
        private static final String Querry_all = " select * from Reviews";

    @Override
    public ArrayList<Review> getAll() {
        
        List<Review> ReviewList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Review review = new Review(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getDate(6)
                       
                );

                ReviewList.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<Review>) ReviewList;

    }

    }
    

