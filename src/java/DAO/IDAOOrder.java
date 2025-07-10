/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import java.util.List;

/**
 *
 * @author ACER
 */
public interface IDAOOrder {

    boolean addOrder(String accountId, String shipperId, String totalAmount, String status);

    boolean addOrderOff(String accountId, String totalAmount, String status);

    List<Order> findByStatus(String status) throws Exception;

    List<Order> findByStatuses(List<String> statuses) throws Exception;

    Order findById(int orderID) throws Exception;

    void assignShipper(int orderID, int shipperID) throws Exception;

    void updateStatus(int orderID, String newStatus) throws Exception;
}
