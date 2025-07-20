/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
import java.sql.Date;

public class Promotion {
    private int promoID;
    private String promoCode;
    private float discountPercent;
    private Date expirationDate;
    private boolean isActive;

    public Promotion() {}

    public Promotion(int promoID, String promoCode, float discountPercent, Date expirationDate, boolean isActive) {
        this.promoID = promoID;
        this.promoCode = promoCode;
        this.discountPercent = discountPercent;
        this.expirationDate = expirationDate;
        this.isActive = isActive;
    }

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

    public float getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(float discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public float getPercent() {
        return this.discountPercent;
    }

    public boolean isActive() {
        return this.isActive;
    }

    public Date getExpire() {
        return this.expirationDate;
    }
}