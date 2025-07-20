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
import Model.Promotion;
import service.DAOPromotionService;
import java.util.Date;

/**
 * Servlet xử lý chức năng Thêm vào giỏ cho đặt món online và đặt phòng
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    private void handlePromotion(HttpServletRequest request, List<CartItem> cart) {
        String promoIdRaw = request.getParameter("promotionId");
        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotalPrice();
        }

        if (promoIdRaw != null && !promoIdRaw.isEmpty()) {
            try {
                int promoId = Integer.parseInt(promoIdRaw);
                Promotion selectedPromo = new DAOPromotionService().getById(promoId);
                if (selectedPromo != null && selectedPromo.isActive() &&
                    !selectedPromo.getExpire().before(new java.sql.Date(System.currentTimeMillis()) ) ) {

                    float percent = selectedPromo.getPercent();
                    double discount = total * percent / 100;
                    double discountedTotal = total - discount;

                    request.setAttribute("selectedPromo", selectedPromo);
                    request.setAttribute("discount", discount);
                    request.setAttribute("discountedTotal", discountedTotal);
                }
            } catch (NumberFormatException ignored) {
            }
        }
        request.setAttribute("totalAmount", total);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        // Nếu có tham số thêm món
        String foodIdStr = request.getParameter("foodId");
        if (foodIdStr != null) {
            // => thêm món
            String foodName = request.getParameter("foodName");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            boolean found = false;
            for (CartItem item : cart) {
                if (item.getFoodId() == Integer.parseInt(foodIdStr)) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }
            if (!found) {
                cart.add(new CartItem(Integer.parseInt(foodIdStr), foodName, image, quantity, price));
            }
            session.setAttribute("cart", cart);
        }

        // Áp dụng mã giảm giá nếu có
        handlePromotion(request, cart);

        // Danh sách mã giảm giá
        List<Promotion> promoList = new DAOPromotionService().getAllActive(); // bạn tạo hàm này
        request.setAttribute("promoList", promoList);

        request.getRequestDispatcher("./Menu/Cart.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        handlePromotion(request, cart);

        List<Promotion> promoList = new DAOPromotionService().getAllActive();
        request.setAttribute("promoList", promoList);
        request.getRequestDispatcher("./Menu/Cart.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet CartServlet xử lý giỏ hàng và khuyến mãi";
    }
}
