/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOFood;
import Model.Food;
import java.util.ArrayList;
import java.util.List;

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
     public boolean addFood ( String name ,  String defaultIngredients , String price ,String description , String fileName , String catID ) {
         return daoFood.AddFood(name, defaultIngredients, price, description, fileName, catID);
     }
     public boolean editFood (String foodID, String name, String ingredients, String price,
                          String description, String image, String catID){
         return daoFood.EditFoodd(foodID, name, ingredients, price, description, image, catID);
     }
     public boolean deleFood (String id ){
         return daoFood.deleFood(id);
     }
    public static void main(String[] args) {
        DAOFoodService d = new DAOFoodService();
        List<Food> list = d.getAll(); System.out.println("ok");
        for (Food food : list) {
            System.out.println(food);
        }
    }
}
