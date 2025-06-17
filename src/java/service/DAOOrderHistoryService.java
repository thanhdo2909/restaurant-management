/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOOrderHistory;
import Model.OrderHistory;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOOrderHistoryService {
    private DAOOrderHistory dao;
    public DAOOrderHistoryService(){
        this.dao= new DAOOrderHistory ();
    }
    public ArrayList<OrderHistory> getAll (String id){
        return dao.getAll(id);
        
    }
       public static void main(String[] args) {
           DAOOrderHistoryService d = new DAOOrderHistoryService();

         ArrayList<OrderHistory> list= d.getAll("22");
           for (OrderHistory orderHistory : list) {
               System.out.println("ok");
               System.out.println(orderHistory);
           }
         
          
}
}
