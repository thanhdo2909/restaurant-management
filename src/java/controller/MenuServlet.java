/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Account;
import Model.Category;
import Model.Food;
import Model.Review;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import service.DAOCategori;
import service.DAOFoodService;
import service.DAOReviewService;

/**
 *
 * @author ACER
 */
@WebServlet(name="MenuServlet", urlPatterns={"/MenuServlet"})
public class MenuServlet extends HttpServlet {
   private DAOFoodService daoFood;
    private DAOCategori daoCategori;
     private DAOReviewService daoReview ;
   
    @Override
    public void init() throws ServletException {
        daoFood = new DAOFoodService();
          daoCategori = new DAOCategori();
          daoReview = new DAOReviewService();
    }
    public void ListFood (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        System.out.println("food");
        ArrayList <Food> food = daoFood.getAll();
        request.setAttribute("menu", food);
     
        String categoryID = request.getParameter("cid");

    
        ArrayList<Food> foodList;

        if (categoryID != null && !categoryID.isEmpty()) {
           
            foodList = daoFood.getFoodByCategory(categoryID);
            request.setAttribute("tag", categoryID); //
        } else {
          
            foodList = daoFood.getAll();
        }

        ArrayList<Category> categoryList = daoCategori.getAll();
   
      
        request.setAttribute("menu", foodList);
        request.setAttribute("catelori", categoryList);
       

  
        request.getRequestDispatcher("/Menu/All.jsp").forward(request, response);
    }
    public void searchFood (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          String key = request.getParameter("search");
          System.out.println("search");
              ArrayList<Food> search = daoFood.searchFood(key);
               request.setAttribute("menu", search);
                 request.getRequestDispatcher("/Menu/All.jsp").forward(request, response);
    }
     public void FoodDetail(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         //đưa chi tiết sản phẩm vào bình luận 
         String id = request.getParameter("id");
           Food food = daoFood.foodDetail(id);
           HttpSession session = request.getSession();
           Account account = (Account) session.getAttribute("account");
         ArrayList<Review> review = daoReview.getAll(id);
         request.setAttribute("account", account);
         request.setAttribute("review", review);
           request.setAttribute("food", food);
           request.getRequestDispatcher("/Menu/foodDetail.jsp").forward(request, response);
     }
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MenuServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MenuServlet at " + request.getContextPath () + "</h1>");
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
    throws ServletException, IOException {      String name = request.getParameter("search");
System.out.println("Search param: " + name);

if (name != null && !name.trim().isEmpty()) {
    System.out.println("→ Tìm kiếm được gọi");
    searchFood(request, response);
} else {
    String id = request.getParameter("id");
        if(id != null && !id.trim().isEmpty()){
            System.out.println("vao ducojw food deatail");
             FoodDetail(request, response);
        }else{
             System.out.println("→ Gọi ListFood()");
        ListFood(request, response);  
        }
     
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

