/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.UserVoucher;
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
public class DAOUserVoucher implements IDAOUserVoucher {
     private static final String Querry_all = "select * from User_Voucher";

    @Override
    public ArrayList<UserVoucher> getAll() {
         List<UserVoucher> UserVoucherList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(Querry_all); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserVoucher userVoucher = new UserVoucher(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getBoolean(4)
                );

                UserVoucherList.add(userVoucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (ArrayList<UserVoucher>) UserVoucherList;
    }
    }
     

