/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
import java.util.Date;

public class Promotion {
    private int promoID;
    private String promoCode;
    private double discountPercent;
    private Date expirationDate;

    // Constructor
    public Promotion(int promoID, String promoCode, double discountPercent, Date expirationDate) {
        this.promoID = promoID;
        this.promoCode = promoCode;
        this.discountPercent = discountPercent;
        this.expirationDate = expirationDate;
    }

    // Getters and setters
    public int getPromoID() {
        return promoID;
    }

    public void setPromoID(int promoID) {
        this.promoID = promoID;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    @Override
    public String toString() {
        return "Promotion{" +
                "promoID=" + promoID +
                ", promoCode='" + promoCode + '\'' +
                ", discountPercent=" + discountPercent +
                ", expirationDate=" + expirationDate +
                '}';
    }
}
