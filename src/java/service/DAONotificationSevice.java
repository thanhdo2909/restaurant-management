/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAONotification;
import Model.Notification;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAONotificationSevice {
    private DAONotification dao;

    public DAONotificationSevice() {
       this.dao = new DAONotification(); 
    }
    public ArrayList<Notification> getAll(String id){
        return dao.getAll(id);
}
    public Notification notificationDatail(String id ){
        return dao.notificationDetail(id);
    }
      public static void main(String[] args) {
          DAONotificationSevice d= new DAONotificationSevice();
          System.out.println( d.notificationDatail("4"));
          
}
}