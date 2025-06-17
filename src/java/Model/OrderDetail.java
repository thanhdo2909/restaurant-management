/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class OrderDetail {
   private int orderDetailID;
    private int orderID;
    private int foodID;
    private String foodName; 
    private String img;
    private int quantity;
    private double price;
   public OrderDetail() {
    }

    public OrderDetail(int orderDetailID, int orderID, int foodID, String foodName, String img, int quantity, double price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.foodID = foodID;
        this.foodName = foodName;
        this.img = img;
        this.quantity = quantity;
        this.price = price;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderDetailID=" + orderDetailID + ", orderID=" + orderID + ", foodID=" + foodID + ", foodName=" + foodName + ", img=" + img + ", quantity=" + quantity + ", price=" + price + '}';
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
   


    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
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
    
}