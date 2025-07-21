/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOOrder;

/**
 *
 * @author ACER
 */
public class DAOOrderservice {
    private final DAOOrder dao = new DAOOrder();
    public boolean AddOrder (String accountId, String shipperId, String totalAmount, String status){
        return dao.addOrder(accountId, shipperId, totalAmount, status);
    }
}
