/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.User;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public interface IDAOUser {
    ArrayList<User> getAll();
    boolean InserUser (String name , String email);
}
