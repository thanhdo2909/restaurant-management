/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class BestSellingFood {
    private int foodID;
    private String foodName;
    private int totalSold;

    public BestSellingFood(int foodID, String foodName, int totalSold) {
        this.foodID = foodID;
        this.foodName = foodName;
        this.totalSold = totalSold;
    }

    public int getFoodID() { return foodID; }
    public String getFoodName() { return foodName; }
    public int getTotalSold() { return totalSold; }
}
