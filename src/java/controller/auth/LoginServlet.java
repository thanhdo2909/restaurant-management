package controller.auth;

import Model.Account;
import email.EmailUtil;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import service.DAOAccountService;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
@MultipartConfig
public class LoginServlet extends HttpServlet {
    private DAOAccountService accountService;
    private static final String UPLOAD_DIR = "C:/Users/ACER/Documents/SWP_391/WebApplication3/web/img";

    @Override
    public void init() {
        accountService = new DAOAccountService();
    }

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            handleRegister(request, response);
        } else { // Default is login
            handleLogin(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name");
        String pass=request.getParameter("pass");
        String password = MD5Hash(request.getParameter("pass"));
        String remember = request.getParameter("rememberMe");
        Account account = accountService.Login(username, password);
        if (account != null) {
            HttpSession session = request.getSession(); 
            session.setAttribute("account", account);
            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("name", username);
                Cookie passCookie = new Cookie("pass", pass);
                userCookie.setMaxAge(7 * 24 * 60 * 60);
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            } else {
                response.addCookie(new Cookie("name", ""));
                response.addCookie(new Cookie("pass", ""));
            }
            response.sendRedirect("home/Home.jsp");
        } else {
          
            request.setAttribute("loginError", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
 
    if (!password.equals(confirmPassword)) {
        request.setAttribute("signupError", "Mật khẩu xác nhận không khớp!");
        request.setAttribute("showSignup", true);
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }
    if ( accountService.checkEmail(email)){
         request.setAttribute("signupError", " email da ton tais");
        request.setAttribute("showSignup", true);
        request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        return;
    }
     
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

     

    // Tạo OTP 6 chữ số
    Random random = new Random();
    String otpCode = String.format("%06d", random.nextInt(999999));

    // Gửi email OTP
    EmailUtil emailUtil = new EmailUtil();
    emailUtil.sendConfirmationEmail(email, otpCode);

    // Lưu dữ liệu đăng ký + OTP + thời gian hết hạn vào session
    HttpSession session = request.getSession();
    session.setAttribute("signupFullName", fullName);
    session.setAttribute("signupEmail", email);
    session.setAttribute("signupUsername", username);
    session.setAttribute("signupPassword", password);
     session.setAttribute("signupfileName", fileName);
    session.setAttribute("signupOtp", otpCode);
    session.setAttribute("signupOtpExpiry", System.currentTimeMillis() + 10 * 60 * 1000); // 10 phút

    // Chuyển tới trang xác minh OTP
     //request.getRequestDispatcher("").forward(request, response);
    session.setAttribute("purpose", "signup"); 
    response.sendRedirect("./includes/OTP.jsp");
}
}
