/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package RoomBooking;

import Model.Account;
import Model.RoomBooking;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DAORoomBookingService;

/**
 *
 * @author ACER
 */
@WebServlet(name="RoomBookingServlet", urlPatterns={"/RoomBookingServlet"})
public class RoomBookingServlet extends HttpServlet {
    private DAORoomBookingService dao;
    @Override
    public void init() {
        dao = new DAORoomBookingService();
    }
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RoomBookingServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RoomBookingServlet at " + request.getContextPath () + "</h1>");
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
      
        try {
            request.setCharacterEncoding("UTF-8");

            String name = request.getParameter("name");
String phone = request.getParameter("phone");
String date = request.getParameter("date");        // "2025-06-04"
String start = request.getParameter("startTime");  // "20:30"
String end = request.getParameter("endTime");      // "22:00"

// Kiểm tra và đảm bảo start và end luôn có định dạng HH:mm
if (start.length() == 5) start += ":00"; // thêm giây nếu thiếu
if (end.length() == 5) end += ":00";

// Tạo chuỗi đúng định dạng Timestamp yêu cầu: yyyy-MM-dd HH:mm:ss
String startStr = date + " " + start;     
String endStr   = date + " " + end;  
            System.out.println(startStr);
            System.out.println(endStr);
            // 1. Kiểm tra bàn trống
            int availableRoom = dao.checkAvailableRoom(startStr, endStr);
            if (availableRoom == -1) {
                request.setAttribute("error", "Tất cả bàn đều đã được đặt trong thời gian này.");
                request.getRequestDispatcher("bookTable.jsp").forward(request, response);
                return;
            }

            // 2. Lấy account từ session
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("account");
            String accountId =  String.valueOf(account.getAccountID()) ;
            System.out.println(accountId);

            // 3. Gọi DAO để lưu booking
            String roomId = String.valueOf(availableRoom);
            boolean success = dao.BookRoom(accountId, roomId, startStr, endStr); // Sửa tên hàm cho đúng

            if (success) {
               int id =dao.RoomId(accountId);
               String RoomId = String.valueOf(id);
                         // Thành công → chuyển sang chọn món
                      request.setAttribute("mess", "booking");
                       request.setAttribute("roomId",RoomId );
                      request.getRequestDispatcher("home/All.jsp").forward(request, response);
               
            } else {
                request.setAttribute("error", "Lỗi khi lưu thông tin đặt bàn.");
                request.getRequestDispatcher("bookTable.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi server khi xử lý đặt bàn.");
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
