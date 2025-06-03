/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class UserVoucher {
    private int id;
    private int userID;
    private int promoID;
    private boolean isUsed;

    // Constructor
    public UserVoucher(int id, int userID, int promoID, boolean isUsed) {
        this.id = id;
        this.userID = userID;
        this.promoID = promoID;
        this.isUsed = isUsed;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getPromoID() {
        return promoID;
    }

    public void setPromoID(int promoID) {
        this.promoID = promoID;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        isUsed = used;
    }

    @Override
    public String toString() {
        return "UserVoucher{" +
                "id=" + id +
                ", userID=" + userID +
                ", promoID=" + promoID +
                ", isUsed=" + isUsed +
                '}';
    }
}
