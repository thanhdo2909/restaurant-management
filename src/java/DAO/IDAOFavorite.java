/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Favorite;
import Model.Food;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */
public interface IDAOFavorite {
    ArrayList<Favorite> getAll();
    List<Food> getFavoriteFoodsByUser(String accountID)throws SQLException ;
    boolean like (String foodID, String accountId);
    boolean unLike (String foodID, String accountId);
    List<Favorite> getFavoriteFoodIds(String accountId);
}
