/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.CartItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */
@WebServlet(name="CartServlet", urlPatterns={"/CartServlet"})
public class CartServlet extends HttpServlet { 
    
    public void orderForRoomBooking(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        int foodId = Integer.parseInt(request.getParameter("foodId"));
        String foodName = request.getParameter("foodName");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getFoodId() == foodId) {
                item.setQuantity(item.getQuantity() + quantity); // cập nhật số lượng
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
    public void orderOnliine (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        int foodId = Integer.parseInt(request.getParameter("foodId"));
        String foodName = request.getParameter("foodName");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getFoodId() == foodId) {
                item.setQuantity(item.getQuantity() + quantity); // cập nhật số lượng
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(foodId, foodName, image, quantity, price));
        }
    

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("./Menu/Cart.jsp").forward(request, response); // hoặc trở lại trang menu
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
String id = request.getParameter("roomId");
   if(id != null){
       orderForRoomBooking(request, response);
     
   }else {
       orderOnliine(request, response);
   }
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
