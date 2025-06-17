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
}
