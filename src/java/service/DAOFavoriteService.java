/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOFavorite;
import Model.Favorite;
import Model.Food;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */
public class DAOFavoriteService {
     private DAOFavorite daoFavorite;

    public DAOFavoriteService( ) {
        this.daoFavorite =  new DAOFavorite();
    }
     public ArrayList<Favorite> getAll() {
        return daoFavorite.getAll();
    } 
     public   List<Food> getFavoriteFoodsByUser(String accountID) throws SQLException{
         return daoFavorite.getFavoriteFoodsByUser(accountID);
     }
     public boolean like (String foodId,String accountId){
         return daoFavorite.like(foodId, accountId);
     }
      public boolean unLike (String foodId,String accountId){
         return daoFavorite.unLike(foodId, accountId);
     }
      public  List<Favorite> getFavoriteFoodIds(String accountId){
          return daoFavorite.getFavoriteFoodIds(accountId);
      }
      public static void main(String[] args) {
        DAOFavoriteService d = new DAOFavoriteService();
        ArrayList<Favorite> a = d.getAll();
          for (Favorite account : a) {
              System.out.println(account);
          }
}
}
