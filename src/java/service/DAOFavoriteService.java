/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOFavorite;
import Model.Favorite;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOFavoriteService {
     private DAOFavorite daoFavorite;

    public DAOFavoriteService( ) {
        this.daoFavorite = daoFavorite;
    }
     public ArrayList<Favorite> getAll() {
        return daoFavorite.getAll();
    }
      public static void main(String[] args) {
        DAOFavoriteService d = new DAOFavoriteService();
        ArrayList<Favorite> a = d.getAll();
          for (Favorite account : a) {
              System.out.println(account);
          }
}
}
