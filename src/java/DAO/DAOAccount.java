/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Account;
import java.beans.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ACER
 */
public class DAOAccount implements IDAOAccount {

    private static final String Querry_all = " select * from Accounts";
    private static final String login = "SELECT * FROM Accounts WHERE Username = ? AND PasswordHash = ?";
    private static final String SignUp = "INSERT INTO Accounts (FullName, Email, BirthDate, TierID, CreatedAt, Username, PasswordHash, FailedLoginCount, Status, ProfileImage, Role) "
            + "VALUES (?, ?, ?, ?, GETDATE(), ?, ?, 0, 'active', ?, ?)";
    private static final String checkname = "SELECT * FROM Accounts WHERE Username = ?";
    private static final String updateProfile = "UPDATE Accounts SET ProfileImage = ? WHERE AccountID = ?";
    private static final String changePass = "UPDATE Accounts SET PasswordHash = ? WHERE AccountID = ?";
    private static final String changeAccount = "UPDATE Accounts SET Username = ? WHERE AccountID = ?";
    private static final String checkEmail = "SELECT * FROM Accounts WHERE Email = ?";

    @Override
    public ArrayList<Account> getAll() {

        List<Account> AccountList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Account account = new Account(
                        rs.getInt("AccountID"), //
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("PasswordHash"),
                        rs.getInt("FailedLoginCount"),
                        rs.getString("Status"),
                        rs.getString("ProfileImage"),
                        rs.getString("Role"),
                        rs.getInt("TierID")
                );

                AccountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<Account>) AccountList;

    }

    @Override
    public Account Login(String name, String pass) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(login)) {

            ps.setString(1, name);
            ps.setString(2, pass);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getInt("AccountID"), //
                            rs.getString("FullName"),
                            rs.getString("Email"),
                            rs.getString("Username"),
                            rs.getString("PasswordHash"),
                            rs.getInt("FailedLoginCount"),
                            rs.getString("Status"),
                            rs.getString("ProfileImage"),
                            rs.getString("Role"),
                            rs.getInt("TierID")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean isUsernameExist(String name) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(checkname);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // true nếu tồn tại
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean SignUp(String fullName, String email, String username, String pass, String role, String fileName) {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SignUp)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setDate(3, null);
            ps.setInt(4, 1);
            ps.setString(5, username);
            ps.setString(6, (pass));

            ps.setString(7, fileName);
            ps.setString(8, role);

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public void updateProfileImage(String accountId, String newProfileImage) {

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(updateProfile)) {
            stmt.setString(1, newProfileImage);
            stmt.setString(2, accountId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("✅ Ảnh đại diện của tài khoản ID " + accountId + " đã được cập nhật.");
            } else {
                System.out.println("⚠️ Không tìm thấy tài khoản để cập nhật.");
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    @Override
    public void changePass(String id, String pass) {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(changePass)) {
            stmt.setString(1, pass);
            stmt.setString(2, id);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("cập nhật mk thành công ");
            } else {
                System.out.println("⚠️ Không tìm thấy tài khoản để cập nhật.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void changeAccount(String id, String account) {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(changeAccount)) {
            stmt.setString(1, account);
            stmt.setString(2, id);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("cập nhật  tài khoản thành công ");
            } else {
                System.out.println("⚠️ Không tìm thấy tài khoản để cập nhật.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Account checkAccount(String account) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(checkname);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Nếu tồn tại, trả về đối tượng Account
                return new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("PasswordHash"),
                        rs.getInt("FailedLoginCount"),
                        rs.getString("Status"),
                        rs.getString("ProfileImage"),
                        rs.getString("Role"),
                        rs.getInt("TierID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Không tìm thấy username
    }

    @Override
    public boolean checkEmail(String email) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(checkEmail);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // true nếu tồn tại
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
