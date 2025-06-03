/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class CartItem {
    private int foodId;
    private String foodName;
    private String image;
    private int quantity;
    private double price;

    public CartItem(int foodId, String foodName, String image, int quantity, double price) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.image = image;
        this.quantity = quantity;
        this.price = price;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "CartItem{" + "foodId=" + foodId + ", foodName=" + foodName + ", image=" + image + ", quantity=" + quantity + ", price=" + price + '}';
    }
     public double getTotalPrice() {
        return quantity * price;
    }
}
