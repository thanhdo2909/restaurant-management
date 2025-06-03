/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOCatelori;
import Model.Category;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOCategori {
    private DAOCatelori daoCatelori;

    public DAOCategori() {
    this.daoCatelori = new DAOCatelori(); 
}
     public ArrayList<Category> getAll() {
        return daoCatelori.getAll();
    }
           public static void main(String[] args) {
        DAOCategori d = new DAOCategori();
        ArrayList<Category> a = d.getAll();
          for (Category account : a) {
              System.out.println(account);
          }
}
    
}
