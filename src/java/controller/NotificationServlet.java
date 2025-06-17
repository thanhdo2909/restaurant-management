/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.DAONotification;
import Model.Account;
import Model.Notification;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
@WebServlet(name="NotificationServlet", urlPatterns={"/NotificationServlet"})
public class NotificationServlet extends HttpServlet {
     private DAONotification notification;
    @Override
    public void init() {
        notification = new DAONotification();
    }
     public void notification (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String id = String.valueOf(account.getAccountID());
       ArrayList <Notification> list = notification.getAll(id);
       request.setAttribute("notification", list);
       request.getRequestDispatcher("notification/notification.jsp").forward(request, response);
    }
     public void notificationDetail (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String id =request.getParameter("id");
       Notification n= notification.notificationDetail(id);
       notification.isRead(id);
       request.setAttribute("notification", n);
        request.getRequestDispatcher("notification/notificationDetail.jsp").forward(request, response);
     }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NotificationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NotificationServlet at " + request.getContextPath () + "</h1>");
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
           String id = request.getParameter("id");
        System.out.println(id);// Lấy từ form hoặc query
    if (id == null || id.isEmpty()) {
        notification(request, response);
    } else {
        notificationDetail(request, response);
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
