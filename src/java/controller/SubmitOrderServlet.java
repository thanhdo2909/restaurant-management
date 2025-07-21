/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Account;
import Model.CartItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import service.DAOOrderDetailService;
import service.DAOOrderservice;

/**
 *
 * @author ACER
 */
@WebServlet(name="SubmitOrderServlet", urlPatterns={"/SubmitOrderServlet"})
public class SubmitOrderServlet extends HttpServlet {
       private DAOOrderservice dao;
       private DAOOrderDetailService daoOrderDetail;
   @Override
    public void init() {
        dao = new DAOOrderservice();
        daoOrderDetail = new DAOOrderDetailService ();
    }
    public void orderOnline (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        Account account = (Account) session.getAttribute("account");
        
        // Kiểm tra giỏ hàng và đăng nhập
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CRUDproduct");
            return;
        }
       
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }
        
        try {
           
            // Tính tổng tiền
            double totalAmount = cart.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
            
            // Tạo order
            String total = String.valueOf(totalAmount);
            String accountID = String.valueOf(account.getAccountID());
            boolean orderId = dao.AddOrder(accountID, null, total, "Pending");
           
            // Thêm order details
            for (CartItem item : cart) {
                String foodId = String.valueOf(item.getFoodId());
                String price = String.valueOf(item.getPrice());
                String quantity = String.valueOf(item.getQuantity());
              daoOrderDetail.addOrderDetail(foodId, quantity, price);
            }
            
    
            
            // Xóa giỏ hàng sau khi đặt hàng thành công
            session.removeAttribute("cart");
            
            // Chuyển hướng đến trang thành công
            request.getRequestDispatcher("/home/Home.jsp").forward(request, response);
            
        } catch (Exception e) {
                  e.printStackTrace();
            request.setAttribute("errorMessage", "Đặt hàng thất bại: " + e.getMessage());
            request.getRequestDispatcher("/home/OrderError.jsp").forward(request, response);  
        }
    }



    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SubmitOrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubmitOrderServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        orderOnline(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
