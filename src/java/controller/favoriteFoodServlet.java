/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Account;
import Model.Food;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.DAOFavoriteService;


/**
 *
 * @author ACER
 */
@WebServlet(name="favoriteFoodServlet", urlPatterns={"/favoriteFoodServlet"})
public class favoriteFoodServlet extends HttpServlet {
     private DAOFavoriteService faroviteFoods;
   @Override
    public void init() {
        faroviteFoods = new DAOFavoriteService();
    }
    public void like (HttpServletRequest request, HttpServletResponse response ,String id)
    throws ServletException, IOException {
     // Kiểm tra đăng nhập
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        // Lấy thông tin người dùng
        Account account = (Account) session.getAttribute("account");
        int accountId = account.getAccountID();

        // Lấy foodId từ form
        int foodId = Integer.parseInt(request.getParameter("foodId"));

        // Gọi DAO xử lý thêm yêu thích
        
        boolean success =faroviteFoods.like(id, id);

        if (!success) {
            request.setAttribute("error", "Không thể thêm món vào yêu thích.");
        }

        // Quay lại trang trước (hoặc redirect đến MenuServlet nếu muốn)
        response.sendRedirect(request.getHeader("referer"));

    } catch (NumberFormatException ex) {
        Logger.getLogger(favoriteFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm món yêu thích.");
    }
        
    }
     public void unlike (HttpServletRequest request, HttpServletResponse response ,String id)
    throws ServletException, IOException {
         // Kiểm tra đăng nhập
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        // Lấy thông tin người dùng
        Account account = (Account) session.getAttribute("account");
        int accountId = account.getAccountID();

        // Lấy foodId từ form
        int foodId = Integer.parseInt(request.getParameter("foodId"));

        // Gọi DAO xử lý thêm yêu thích
        
        boolean success =faroviteFoods.unLike(id, id);

        if (!success) {
            request.setAttribute("error", "Không thể thêm món vào yêu thích.");
        }

        // Quay lại trang trước (hoặc redirect đến MenuServlet nếu muốn)
        response.sendRedirect(request.getHeader("referer"));

    } catch (NumberFormatException ex) {
        Logger.getLogger(favoriteFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm món yêu thích.");
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
            out.println("<title>Servlet favoriteFoodServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet favoriteFoodServlet at " + request.getContextPath () + "</h1>");
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
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        Account account = (Account) session.getAttribute("account");
        String accountid = String.valueOf(account.getAccountID());

        List<Food> favoriteFoods = faroviteFoods.getFavoriteFoodsByUser(accountid);

        request.setAttribute("menu", favoriteFoods);
        request.getRequestDispatcher("/Menu/favoriteFoods.jsp").forward(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(favoriteFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi lấy danh sách yêu thích");
    }
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
       String id = request.getParameter("foodId");
       String purpose = request.getParameter("purpose");
       if ("like".equalsIgnoreCase(purpose)){
           like(request, response, id);
       }else {
            unlike(request, response, id);
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
