/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class MembershipTier {
    private int tierID;
    private String tierName;
    private double minSpending;
    private double discountPercent;
public MembershipTier(int tierID, String tierName, double minSpending, double discountPercent) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.minSpending = minSpending;
        this.discountPercent = discountPercent;
    }

    // Getters and setters
    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public double getMinSpending() {
        return minSpending;
    }

    public void setMinSpending(double minSpending) {
        this.minSpending = minSpending;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    @Override
    public String toString() {
        return "MembershipTier{" +
                "tierID=" + tierID +
                ", tierName='" + tierName + '\'' +
                ", minSpending=" + minSpending +
                ", discountPercent=" + discountPercent +
                '}';
    }
}
