/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Food;
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
public class DAOFood implements IDAOFood {
   private static  final String Querry_all="select * from Food";
   private static final String QUERY_BY_ID = "select * from Food where CategoryID = ?";
  private static final String SEARCH_SQL = "SELECT * FROM Food WHERE FoodName LIKE ?";
   private static final String foodDetail = "select * from Food where FoodId =? ";
   @Override
   public ArrayList <Food> getAll (){
         List<Food> FoodList = new ArrayList<>();
        

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(Querry_all);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Food food = new Food(
                        rs.getInt(1),
                            rs.getString(2),
                            rs.getDouble(3),
                            rs.getString(4),
                             rs.getString(5),
                              rs.getInt(6),
                        rs.getString(7)
                            
                            );

                FoodList.add(food);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<Food>) FoodList;
       
       
   }

    @Override
    public ArrayList<Food> getFoodByCategory(String id) {
        ArrayList<Food> foodList = new ArrayList<>();
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(QUERY_BY_ID)) {
         
        ps.setString(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Food food = new Food(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getDouble(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getInt(6),
                    rs.getString(7)
                );
                foodList.add(food);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return foodList;
        
    }

    @Override
    
public ArrayList<Food> sreachFood(String keyword) {
    ArrayList<Food> foodList = new ArrayList<>();

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(SEARCH_SQL)) {

        ps.setString(1, "%" + keyword + "%");

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Food food = new Food(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getDouble(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getInt(6),
                    rs.getString(7)
                );
                foodList.add(food);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return foodList;
}

    @Override
    public Food foodDetail(String id) {
        try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(foodDetail)) {

        ps.setString(1, id);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                return  new Food(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getDouble(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getInt(6),
                    rs.getString(7)
                );
                
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
       return null;
    }
    
    }
    
    

