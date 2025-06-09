/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author ACER
 */
public interface IDAOOrder {
     boolean addOrder (String accountId , String shipperId , String totalAmount ,String status );
     boolean addOrderOff (String accountId  , String totalAmount ,String status );
}
