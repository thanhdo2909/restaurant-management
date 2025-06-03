/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOUser;
import Model.User;
import static com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.util.Type.String;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOUserService {
    private DAOUser daoUser;
  
    public DAOUserService() {
        this.daoUser = new DAOUser();  
    }
     public ArrayList<User> getAll() {
        return daoUser.getAll();
    }
 public boolean InserUser(String name, String email) {
        return daoUser.InserUser(name, email); 
    }
}
