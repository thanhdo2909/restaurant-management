/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOOrderDetail;

/**
 *
 * @author ACER
 */
public class DAOOrderDetailService {
    private final DAOOrderDetail dao ;
    public DAOOrderDetailService (){
       this.dao = new DAOOrderDetail ();
    }
  public boolean addOrderDetail (String foodId, String Quantity, String price) {
      return dao.order(foodId, Quantity, price);
  }
}
