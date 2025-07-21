package service;

import DAO.DAOOrder;
import DAO.IDAOOrder;
import Model.Order;
import java.util.List;

public class KitchenService {
    private IDAOOrder dao;
    public KitchenService() throws Exception {
        this.dao = new DAOOrder();
    }
    public List<Order> getProcessingOrders() throws Exception {
        return dao.findByStatus("Processing");
    }
    public void completeOrder(int orderID) throws Exception {
        dao.updateStatus(orderID, "Prepared");
    }
}    
