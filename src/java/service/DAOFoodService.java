/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOFood;
import Model.Food;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOFoodService {

    private DAOFood daoFood;

    public DAOFoodService() {
        this.daoFood = new DAOFood();
    }

    public ArrayList<Food> getAll() {
        return daoFood.getAll();
    }
     public ArrayList<Food> getFoodByCategory(String id) {
        return daoFood.getFoodByCategory(id);
    }
     public ArrayList <Food> searchFood (String keyword){
         return daoFood.sreachFood(keyword);
     }
     public Food foodDetail(String id){
         return daoFood.foodDetail(id);
     }
    public static void main(String[] args) {
        DAOFoodService d = new DAOFoodService();
     //   ArrayList<Food> food = d.searchFood("bia");
        System.out.println(d.foodDetail("1"));
    }
}
