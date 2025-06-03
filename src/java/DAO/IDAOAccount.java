/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Account;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public interface IDAOAccount {
    ArrayList<Account> getAll();
      Account Login( String name, String pass);
     boolean  SignUp( String fullName,String email, String username, String pass, String role,String  fileName); 
      boolean isUsernameExist(String name);
       void updateProfileImage(String accountId, String newProfileImage);
       void changePass(String id , String pass);
       void changeAccount ( String id , String account );
       Account  checkAccount (String account);
       boolean checkEmail (String email);
}
