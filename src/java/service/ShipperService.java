package service;

import DAO.DAOOrder;
import DAO.IDAOOrder;
import Model.Order;
import java.util.Arrays;
import java.util.List;

public class ShipperService {
    private IDAOOrder dao;
    private int shipperID;

    public ShipperService(int shipperID) throws Exception {
        this.dao = new DAOOrder();
        this.shipperID = shipperID;
    }

    public List<Order> getPreparedOrders() throws Exception {
        return dao.findByStatus("Prepared");
    }

    public void receiveOrder(int orderID) throws Exception {
        dao.assignShipper(orderID, shipperID);
    }

    public List<Order> getMyOrders() throws Exception {
        return dao.findByStatuses(Arrays.asList("InDelivery","Delivered","Failed"));
    }

    public Order getOrderById(int orderID) throws Exception {
        return dao.findById(orderID);
    }

    public void updateDeliveryStatus(int orderID, boolean success) throws Exception {
        dao.updateStatus(orderID, success ? "Delivered" : "Failed");
    }
}