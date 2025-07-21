/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class Favorite {
    private int userID;
    private int foodID;

    // Constructor
    public Favorite(int userID, int foodID) {
        this.userID = userID;
        this.foodID = foodID;
    }
 
    // Getters and setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    @Override
    public String toString() {
        return "Favorite{" + "userID=" + userID + ", foodID=" + foodID + '}';
    }
    
}
