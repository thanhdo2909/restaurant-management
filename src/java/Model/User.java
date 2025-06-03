/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author ACER
 */
public class User {
    private int userID;
    private String fullName;
    private String email;
    private java.sql.Date birthDate;
    private int tierID;
    private java.sql.Timestamp createdAt;

    // Constructor
    public User(int userID, String fullName, String email, java.sql.Date birthDate, int tierID, java.sql.Timestamp createdAt) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.birthDate = birthDate;
        this.tierID = tierID;
        this.createdAt = createdAt;
    }

    public User(int aInt, String string, String string0, Date date, Timestamp timestamp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Getters and setters
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public java.sql.Date getBirthDate() { return birthDate; }
    public void setBirthDate(java.sql.Date birthDate) { this.birthDate = birthDate; }

    public int getTierID() { return tierID; }
    public void setTierID(int tierID) { this.tierID = tierID; }

    public java.sql.Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.sql.Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "User{" + "userID=" + userID + ", fullName=" + fullName + ", email=" + email + ", birthDate=" + birthDate + ", tierID=" + tierID + ", createdAt=" + createdAt + '}';
    }
    
}
