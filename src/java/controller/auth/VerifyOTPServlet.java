/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DAOAccountService;

/**
 *
 * @author ACER
 */
@WebServlet(name="VerifyOTPServlet", urlPatterns={"/VerifyOTPServlet"})
public class VerifyOTPServlet extends HttpServlet {
   
      private DAOAccountService accountService;
       @Override
    public void init() {
        accountService = new DAOAccountService();
    }
    public void  signUpOTP (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String otpCodeInput = request.getParameter("otpCode");
    HttpSession session = request.getSession();

    String otpCodeSession = (String) session.getAttribute("signupOtp");
    Long otpExpiry = (Long) session.getAttribute("signupOtpExpiry");
        System.out.println(otpCodeSession);
    if (otpCodeSession == null || otpExpiry == null) {
        request.setAttribute("errorMessage", "OTP không tồn tại hoặc đã hết hạn.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }

    if (System.currentTimeMillis() > otpExpiry) {
        session.removeAttribute("signupOtp");
        session.removeAttribute("signupOtpExpiry");
        request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng đăng ký lại.");
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }

    if (!otpCodeSession.equals(otpCodeInput)) {
        request.setAttribute("errorMessage", "Mã OTP không chính xác.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }

     
    String fullName = (String) session.getAttribute("signupFullName");
    String email = (String) session.getAttribute("signupEmail");
    String username = (String) session.getAttribute("signupUsername");
    String password =  MD5Hash((String) session.getAttribute("signupPassword"));
     String img=  (String) session.getAttribute("signupfileName");
    boolean created = accountService.SignUp(fullName, email, username, password, "User", img);

    if (created) {
        // Xóa dữ liệu session
        session.removeAttribute("signupFullName");
        session.removeAttribute("signupEmail");
        session.removeAttribute("signupUsername");
        session.removeAttribute("signupPassword");
        session.removeAttribute("signupOtp");
        session.removeAttribute("signupOtpExpiry");
        session.removeAttribute("signupfileName");

        response.sendRedirect("home/Login.jsp?signupSuccess=true");
    } else {
        request.setAttribute("errorMessage", "Tạo tài khoản thất bại. Vui lòng thử lại.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
    }
        
    }
    public void changepass(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            HttpSession session = request.getSession();
              String otpCodeSession = (String) session.getAttribute("otp");
               String otpCodeInput = request.getParameter("otpCode");
          String pass = (String) session.getAttribute("pass");
           Long otpExpiry = (Long) session.getAttribute("signupOtpExpiry");
           if (otpCodeSession == null || otpExpiry == null) {
        request.setAttribute("errorMessage", "OTP không tồn tại hoặc đã hết hạn.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }

    if (System.currentTimeMillis() > otpExpiry) {
        session.removeAttribute("signupOtp");
        session.removeAttribute("signupOtpExpiry");
        request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng đăng ký lại.");
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }

    if (!otpCodeSession.equals(otpCodeInput)) {
        request.setAttribute("errorMessage", "Mã OTP không chính xác.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }
      
     String id = (String) session.getAttribute("id");
     accountService.changePassword(id, pass);
     request.getRequestDispatcher("home/profile.jsp").forward(request, response);
        
    }
    public void forgetPass(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        System.out.println("queen mk");
        HttpSession session = request.getSession();
              String otpCodeSession = (String) session.getAttribute("otp");
               String otpCodeInput = request.getParameter("otpCode");
          String pass = (String) session.getAttribute("pass");
           Long otpExpiry = (Long) session.getAttribute("signupOtpExpiry");
           if (otpCodeSession == null || otpExpiry == null) {
        request.setAttribute("errorMessage", "OTP không tồn tại hoặc đã hết hạn.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }

    if (System.currentTimeMillis() > otpExpiry) {
        session.removeAttribute("signupOtp");
        session.removeAttribute("signupOtpExpiry");
        request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng đăng ký lại.");
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }

    if (!otpCodeSession.equals(otpCodeInput)) {
        request.setAttribute("errorMessage", "Mã OTP không chính xác.");
        request.getRequestDispatcher("./includes/OTP.jsp").forward(request, response);
        return;
    }
        request.getRequestDispatcher("home/newPass.jsp").forward(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyOTPServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyOTPServlet at " + request.getContextPath () + "</h1>");
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
     public static String MD5Hash(String input) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : array) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) { return null; }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     String purpose = request.getParameter("purpose");
if ("signup".equals(purpose)) {
    System.out.println("Vào signup");
    signUpOTP(request, response);
} else if ("changepass".equals(purpose)) {
    System.out.println("Vào đổi mật khẩu");
    changepass(request, response);
} else if ("forgetpass".equals(purpose)) {
    System.out.println("Vào quên mật khẩu");
    forgetPass(request, response);
} else {
    System.out.println("Không nhận được purpose");
    // Chuyển về login hoặc thông báo lỗi
}
}
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

