/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetail;
import java.util.List;

/**
 *
 * @author ACER
 */
public interface IDAOOrderDetail {
         List<OrderDetail> getCartByUserId(int userId) ;
        boolean order (String foodId, String Quantity, String price);
           
}
