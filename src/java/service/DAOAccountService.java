/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOAccount;
import Model.Account;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOAccountService {
    private DAOAccount daoAccount;

    public DAOAccountService( ) {
    
    this.daoAccount = new DAOAccount(); 
    }
      ArrayList<Account> getAll() {
        return daoAccount.getAll();
    }
   public  boolean SignUp (  String fullName,String email, String username, String pass, String role,String  fileName){
          return daoAccount.SignUp(fullName, email, username, pass, role, fileName);
     }
    public Account Login(String name, String pass) {
         return daoAccount.Login(name, pass);
     }
   public  boolean isUsernameExist(String name ){
         return daoAccount.isUsernameExist(name);
     }
   public  void updateProfile (String id, String img){
       daoAccount.updateProfileImage(id , img);
   }
   public void changePassword(String id , String pass){
       String passwword = MD5Hash(pass);
       daoAccount.changePass(id, passwword);
   }
   public void changeAccount(String id , String account){
       daoAccount.changeAccount(id, account);
   }
   public Account checkAccount(String account){
       return daoAccount.checkAccount(account);
   }
   public boolean checkEmail (String email ){
       return daoAccount.checkEmail(email);
   }
    public static String MD5Hash(String input) {
    try {
        java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
        byte[] array = md.digest(input.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : array) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    } catch (java.security.NoSuchAlgorithmException e) {
        e.printStackTrace();
        return null;
    }
}
     
      public static void main(String[] args) {
           DAOAccountService d = new DAOAccountService();
          System.out.println(   d.checkAccount("nguyenvana"));
         
          
}
}
