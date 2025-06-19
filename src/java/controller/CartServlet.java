package controller;

import Model.CartItem;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet xử lý chức năng Thêm vào giỏ cho đặt món online và đặt phòng
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    /**
     * Xử lý thêm món cho đặt phòng
     */
    public void orderForRoomBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra và parse tham số
        String foodIdStr = request.getParameter("foodId");
        String priceStr = request.getParameter("price");
        String qtyStr = request.getParameter("quantity");
        if (foodIdStr == null || priceStr == null || qtyStr == null) {
            response.sendRedirect(request.getContextPath() + "/MenuServlet");
            return;
        }
        int foodId;
        double price;
        int quantity;
        try {
            foodId = Integer.parseInt(foodIdStr.trim());
            price = Double.parseDouble(priceStr.trim());
            quantity = Integer.parseInt(qtyStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/MenuServlet");
            return;
        }

        String foodName = request.getParameter("foodName");
        String image = request.getParameter("image");

        // Cập nhật giỏ
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getFoodId() == foodId) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }
        if (!found) {
            cart.add(new CartItem(foodId, foodName, image, quantity, price));
        }

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("./Menu/Cart.jsp").forward(request, response);
    }

    /**
     * Xử lý thêm món cho đặt online
     */
    public void orderOnliine(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra và parse tham số
        String foodIdStr = request.getParameter("foodId");
        String priceStr = request.getParameter("price");
        String qtyStr = request.getParameter("quantity");
        if (foodIdStr == null || priceStr == null || qtyStr == null) {
            response.sendRedirect(request.getContextPath() + "/MenuServlet");
            return;
        }
        int foodId;
        double price;
        int quantity;
        try {
            foodId = Integer.parseInt(foodIdStr.trim());
            price = Double.parseDouble(priceStr.trim());
            quantity = Integer.parseInt(qtyStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/MenuServlet");
            return;
        }

        String foodName = request.getParameter("foodName");
        String image = request.getParameter("image");

        // Cập nhật giỏ
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getFoodId() == foodId) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }
        if (!found) {
            cart.add(new CartItem(foodId, foodName, image, quantity, price));
        }

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("./Menu/Cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomId = request.getParameter("roomId");
        if (roomId != null) {
            orderForRoomBooking(request, response);
        } else {
            orderOnliine(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về menu nếu truy cập GET
        response.sendRedirect(request.getContextPath() + "/MenuServlet");
    }

    @Override
    public String getServletInfo() {
        return "Servlet CartServlet xử lý giỏ hàng";
    }
}
