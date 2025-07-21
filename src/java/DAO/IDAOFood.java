/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Food;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public interface IDAOFood {
        ArrayList<Food> getAll();
         ArrayList<Food> getFoodByCategory( String id);
     ArrayList <Food> sreachFood(String keyword);
     Food  foodDetail(String id);
     boolean  AddFood (String name , String defaultIngredients , String price ,String description , String fileName ,String catID);
     boolean EditFoodd(String foodID, String name, String ingredients, String price,
                          String description, String image, String catID);
     boolean deleFood (String id);
}
