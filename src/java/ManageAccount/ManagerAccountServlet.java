/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package ManageAccount;

import Model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import service.DAOAccountService;

/**
 *
 * @author ACER
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
@WebServlet(name="ManagerAccountServlet", urlPatterns={"/ManagerAccountServlet"})
public class ManagerAccountServlet extends HttpServlet {
   private DAOAccountService accountService;
    @Override
    public void init() {
        accountService = new DAOAccountService();
    }
     private static final String UPLOAD_DIR = "C:/Users/ACER/Documents/SWP_391/WebApplication3/web/img";
        public static String MD5Hash(String input) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : array) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) { return null; }
    }

   public void getALlUser (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         List <Account> list =  accountService.getAll();
         request.setAttribute("userList", list);
         request.getRequestDispatcher("./ManageAccount/ManageUser.jsp").forward(request, response);
   }
   public void lockAccount (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String id = request.getParameter("userId");
       boolean success = accountService.lockAccount(id);
      //request.getRequestDispatcher("${pageContext.request.contextPath}/ManagerAccountServlet").forward(request, response);
       response.sendRedirect(request.getContextPath() + "/ManagerAccountServlet");
   }
   public void unlockAccount  (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("userId");
       boolean success = accountService.unlockAccount(id);
      
     response.sendRedirect(request.getContextPath() + "/ManagerAccountServlet");
   }
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String role = request.getParameter("role");
        
    if (!password.equals(confirmPassword)) {
        request.setAttribute("signupError", "Mật khẩu xác nhận không khớp!");
        request.setAttribute("showSignup", true);
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }
//    if ( accountService.checkEmail(email)){
//         request.setAttribute("signupError", " email da ton tais");
//        request.setAttribute("showSignup", true);
//        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
//        return;
//    }
     
    if (accountService.isUsernameExist(username)) {
        request.setAttribute("signupError", "Tên đăng nhập đã tồn tại!");
        request.setAttribute("showSignup", true);
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }
         String fileName = null;
        try {
            Part filePart = request.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;
                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                String filePath = UPLOAD_DIR + File.separator + uniqueFileName;
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }
               fileName = "img/profileImg/" + uniqueFileName;
            }
        } catch (Exception e) {
            request.setAttribute("signupError", "Lỗi upload ảnh: " + e.getMessage());
            request.setAttribute("showSignup", true);
            request.getRequestDispatcher("home/Login.jsp").forward(request, response);
            return;
        }
       boolean  success = accountService.SignUp(fullName, email, username, password, role, fileName);
        response.sendRedirect(request.getContextPath() + "/ManagerAccountServlet");
    }

     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerAccountServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerAccountServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String purpose = request.getParameter("purpose");

if ("lock".equalsIgnoreCase(purpose)) {
    lockAccount(request, response);
} else if ("unlock".equalsIgnoreCase(purpose)) {
    unlockAccount(request, response);
}
else {
    getALlUser(request, response);
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
       
    handleRegister(request, response);
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
