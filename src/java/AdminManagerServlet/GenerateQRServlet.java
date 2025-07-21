/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AdminManagerServlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.zxing.*;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;


import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
/**
 *
 * @author ACER
 */
@WebServlet(name="GenerateQRServlet", urlPatterns={"/GenerateQRServlet"})
public class GenerateQRServlet extends HttpServlet {
   
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
            out.println("<title>Servlet GenerateQRServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerateQRServlet at " + request.getContextPath () + "</h1>");
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
          String tableParam = request.getParameter("table");
        
        try {
            if (tableParam == null || tableParam.trim().isEmpty()) {
                request.setAttribute("error", "Thiếu tham số 'table'");
                request.getRequestDispatcher("/Amin/tables.jsp").forward(request, response);
                return;
            }

            int tableNum = Integer.parseInt(tableParam.trim());
            String contextPath = request.getContextPath();
            String qrContent = request.getRequestURL().toString().replace("GenerateQRServlet", 
                          "MenuServlet") + "?table=" + tableNum;

            // Tạo QR code
            QRCodeWriter writer = new QRCodeWriter();
            BitMatrix matrix = writer.encode(qrContent, BarcodeFormat.QR_CODE, 300, 300);
            
            // Thư mục lưu QR
            String qrFolder = getServletContext().getRealPath("/img/QR");
            File dir = new File(qrFolder);
            if (!dir.exists()) dir.mkdirs();
            
            // Lưu file ảnh
            Path outputPath = new File(dir, "table_" + tableNum + ".png").toPath();
            MatrixToImageWriter.writeToPath(matrix, "PNG", outputPath);
            
            // Truyền dữ liệu sang JSP
            request.setAttribute("tableNumber", tableNum);
            request.setAttribute("qrPath", "img/QR/table_" + tableNum + ".png");
            
            // Chuyển hướng sang JSP
            request.getRequestDispatcher("/Amin/tables.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi tạo QR: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/tables.jsp").forward(request, response);
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
