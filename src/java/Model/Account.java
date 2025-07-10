/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class Account {

    private int AccountID;
    private String fullName;
    private String Email;
    private String username;
    private String passwordHash;
    private int failedLoginCount;
    private String status;
    private String profileImage;
    private String role;
    private int tierID;

    public Account(int accountID, String fullName, String Email, String username, String passwordHash, int failedLoginCount, String status, String profileImage, String role, int tierID) {
        this.AccountID = accountID;
        this.fullName = fullName;
        this.Email = Email;
        this.username = username;
        this.passwordHash = passwordHash;
        this.failedLoginCount = failedLoginCount;
        this.status = status;
        this.profileImage = profileImage;
        this.role = role;
        this.tierID = tierID;
    }

    @Override
    public String toString() {
        return "Account{" + "accountID=" + AccountID + ", fullName=" + fullName + ", Email=" + Email + ", username=" + username + ", passwordHash=" + passwordHash + ", failedLoginCount=" + failedLoginCount + ", status=" + status + ", profileImage=" + profileImage + ", role=" + role + ", tierID=" + tierID + '}';
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public int getFailedLoginCount() {
        return failedLoginCount;
    }

    public void setFailedLoginCount(int failedLoginCount) {
        this.failedLoginCount = failedLoginCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getProfileImage() {
    return (profileImage != null) ? profileImage : "default-avatar.png";
}


    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

}
