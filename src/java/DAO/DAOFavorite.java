/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Favorite;
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
public class DAOFavorite implements IDAOFavorite {
     private static final String Querry_all = " select * from Accounts";

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
         
        
    }
    
   
