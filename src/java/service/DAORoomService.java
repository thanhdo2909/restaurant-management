/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAORoom;
import Model.Room;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAORoomService {
    private DAORoom daoroom ;

    public DAORoomService() {
        this.daoroom=daoroom;
    }
       public ArrayList<Room> getAll() {
        return daoroom.getAll();
    }
      public static void main(String[] args) {
        DAORoomService d = new DAORoomService();
        ArrayList<Room> a = d.getAll();
          for (Room room : a) {
              System.out.println(room);
          }
}
    
    
}
