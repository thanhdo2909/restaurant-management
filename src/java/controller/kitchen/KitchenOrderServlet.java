package controller.kitchen;

import Model.Order;
import service.KitchenService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/kitchen/orders")
public class KitchenOrderServlet extends HttpServlet {
    private KitchenService service;
    @Override
    public void init() throws ServletException {
        try { service = new KitchenService(); } catch (Exception e) { throw new ServletException(e); }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.equals("list")) {
                List<Order> list = service.getProcessingOrders();
                req.setAttribute("orders", list);
                req.getRequestDispatcher("/order/list.jsp?role=kitchen&action=list").forward(req, resp);
            } else if (action.equals("complete")) {
                service.completeOrder(Integer.parseInt(req.getParameter("orderID")));
                resp.sendRedirect(req.getContextPath() + "/kitchen/orders?action=list");
            }
        } catch (Exception e) { throw new ServletException(e); }
    }
}