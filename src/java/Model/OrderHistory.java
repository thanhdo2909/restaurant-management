/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author ACER
 */
public class OrderHistory {
   private int orderId;
    private Date createAt;
    private double totalAmount; // Đã sửa lỗi chính tả
    private String status;
    private String img;
    private List<OrderDetail> orderDetail;
 public OrderHistory() {
    }

    public OrderHistory(int orderId, Date createAt, double totalAmount, String status, String img, List<OrderDetail> orderDetail) {
        this.orderId = orderId;
        this.createAt = createAt;
        this.totalAmount = totalAmount;
        this.status = status;
        this.img = img;
        this.orderDetail = orderDetail;
    }

    @Override
    public String toString() {
        return "OrderHistory{" + "orderId=" + orderId + ", createAt=" + createAt + ", totalAmount=" + totalAmount + ", status=" + status + ", img=" + img + ", orderDetail=" + orderDetail + '}';
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public List<OrderDetail> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetail> orderDetail) {
        this.orderDetail = orderDetail;
    }
    
}

    