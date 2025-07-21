/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Favorite;
import Model.Food;
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
public class DAOFavorite implements IDAOFavorite {

    private static final String Querry_all = " select * from Accounts";
    private static final String favoriteFoods = "SELECT f.FoodID, f.Image, f.Price, f.FoodName, f.Ingredients, f.CategoryID, f.Description "
            + "FROM Favorites fav "
            + "JOIN Food f ON fav.FoodID = f.FoodID "
            + "WHERE fav.AccountID = ?";
    private static final String like = "INSERT INTO Favorites (AccountID, FoodID) VALUES (?, ?)";
    private static final String unLike = "DELETE FROM Favorites WHERE AccountID = ? AND FoodID = ?";
    private static final String getFavoriteFood= "SELECT FoodID,AccountID FROM Favorites WHERE AccountID = ?";
    @Override
    public ArrayList<Favorite> getAll() {
        List<Favorite> FavoriteList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Favorite favorite = new Favorite(
                        rs.getInt(1),
                        rs.getInt(2)
                );

                FavoriteList.add(favorite);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<Favorite>) FavoriteList;

    }

    @Override
    public List<Food> getFavoriteFoodsByUser(String accountID) throws SQLException {
        List<Food> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(favoriteFoods)) {

            ps.setString(1, accountID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Food f = new Food(
                            rs.getInt("FoodID"),
                            rs.getString("Image"),
                            rs.getDouble("Price"),
                            rs.getString("FoodName"),
                            rs.getString("Ingredients"),
                            rs.getInt("CategoryID"),
                            rs.getString("Description")
                    );
                    list.add(f);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return list;
        }
    }

    @Override
    public boolean like(String foodID, String accountId) {

       try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(like)) {

            ps.setString(1, accountId);
            ps.setString(2, foodID);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean unLike(String foodID, String accountId) {
      try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(unLike)) {

            ps.setString(1, accountId);
            ps.setString(2, foodID);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Favorite> getFavoriteFoodIds(String accountId) {
          List<Favorite> favorites = new ArrayList<>();
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(getFavoriteFood)) {
        ps.setString(1, accountId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Favorite f = new Favorite(
                    rs.getInt("FoodID"),
                    rs.getInt("AccountID")
                );
                favorites.add(f);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return favorites; 
}
}
