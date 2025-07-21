package controller.shipper;

import Model.Order;
import service.ShipperService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/shipper/orders")
public class ShipperOrderServlet extends HttpServlet {
    private ShipperService service;
    @Override
    public void init() throws ServletException {
        try {
            int shipperID = Integer.parseInt(getServletContext().getInitParameter("shipperID"));
            service = new ShipperService(shipperID);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            switch (action == null ? "list" : action) {
                case "list": {
                    List<Order> list = service.getPreparedOrders();
                    req.setAttribute("orders", list);
                    req.getRequestDispatcher("/order/list.jsp?role=shipper&action=list").forward(req, resp);
                    break;
                }
                case "listMy": {
                    List<Order> my = service.getMyOrders();
                    req.setAttribute("orders", my);
                    req.getRequestDispatcher("/order/list.jsp?role=shipper&action=listMy").forward(req, resp);
                    break;
                }
                case "detail": {
                    Order o = service.getOrderById(Integer.parseInt(req.getParameter("orderID")));
                    req.setAttribute("order", o);
                    req.getRequestDispatcher("/order/detail.jsp?role=shipper").forward(req, resp);
                    break;
                }
                case "receive": {
                    service.receiveOrder(Integer.parseInt(req.getParameter("orderID")));
                    resp.sendRedirect(req.getContextPath() + "/shipper/orders?action=list");
                    break;
                }
                case "updateStatus": {
                    boolean ok = "true".equals(req.getParameter("success"));
                    service.updateDeliveryStatus(Integer.parseInt(req.getParameter("orderID")), ok);
                    resp.sendRedirect(req.getContextPath() + "/shipper/orders?action=listMy");
                    break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}