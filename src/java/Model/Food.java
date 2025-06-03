/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */public class Food {
    private int foodID;           
    private String image;          
    private double price;       
    private String defaultFoodName;
    private String defaultIngredients;
    private int categoryID;    
    private String description;   
 
    // Constructor
    public Food(int foodID, String image, double price, String defaultFoodName, 
                String defaultIngredients, int categoryID, String description) {
        this.foodID = foodID;
        this.image = image;
        this.price = price;
        this.defaultFoodName = defaultFoodName;
        this.defaultIngredients = defaultIngredients;
        this.categoryID = categoryID;
        this.description = description;
    }

    // Getters and Setters
    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDefaultFoodName() {
        return defaultFoodName;
    }

    public void setDefaultFoodName(String defaultFoodName) {
        this.defaultFoodName = defaultFoodName;
    }

    public String getDefaultIngredients() {
        return defaultIngredients;
    }

    public void setDefaultIngredients(String defaultIngredients) {
        this.defaultIngredients = defaultIngredients;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // toString method (optional)
    @Override
    public String toString() {
        return "Food [foodID=" + foodID + ", image=" + image + ", price=" + price 
                + ", defaultFoodName=" + defaultFoodName + ", defaultIngredients=" 
                + defaultIngredients + ", categoryID=" + categoryID + ", description=" + description + "]";
    }
}
