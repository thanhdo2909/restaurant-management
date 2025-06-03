/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Profile;

import Model.Account;
import email.EmailUtil;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import static java.lang.System.out;
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
@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    private DAOAccountService accountService;
    private static final String UPLOAD_DIR = "C:/Users/ACER/Documents/SWP_391/WebApplication3/web/img/profileImg";

    @Override
    public void init() {
        accountService = new DAOAccountService();
    }

    public void forgetPass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tk = request.getParameter("taikhoan");
        Account account = accountService.checkAccount(tk);
        String id = String.valueOf(account.getAccountID());
        if (account == null) {
            request.setAttribute("mess", "không timg thấy tài khoản của bạn");
        } else {
            HttpSession session = request.getSession();
            Random random = new Random();
            String otpCode = String.format("%06d", random.nextInt(999999));

            // Gửi email OTP
            EmailUtil emailUtil = new EmailUtil();
            emailUtil.sendConfirmationEmail(account.getEmail(), otpCode);

            // Lưu dữ liệu đăng ký + OTP + thời gian hết hạn vào session
            session.setAttribute("id", id);
            session.setAttribute("taikhoan", tk);
            session.setAttribute("purpose", "forgetpass");
            session.setAttribute("otp", otpCode);
            session.setAttribute("signupOtpExpiry", System.currentTimeMillis() + 10 * 60 * 1000); // 10 phút
            response.sendRedirect("./includes/OTP.jsp");

        }
    }

    public void newPass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String pass = request.getParameter("newPass");
        String confirmNewPass = request.getParameter("confirmNewPass");
        if (pass.equals(confirmNewPass)) {
            accountService.changePassword(id, pass);
            request.getRequestDispatcher("home/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("mess", "sai mat khau");
            request.getRequestDispatcher("home/newPass.jsp").forward(request, response);
        }
    }

    public void upload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // upload ảnh
        String fileName = null;
        try {
            Part filePart = request.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;

                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = UPLOAD_DIR + File.separator + uniqueFileName;
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }

                fileName = "img/profileImg/" + uniqueFileName;

            }
        } catch (Exception e) {
            request.setAttribute("signupError", "Lỗi upload ảnh: " + e.getMessage());
            request.getRequestDispatcher("home/Login.jsp").forward(request, response);
            return;
        }

// cập nhật trong DB
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        accountService.updateProfile(String.valueOf(account.getAccountID()), fileName);

// 🟢 cập nhật lại đối tượng account trong session
        account.setProfileImage(fileName);
        session.setAttribute("account", account);

// 🟢 redirect với timestamp để tránh cache
        if (account != null) {

            out.println("Mật khẩu: " + account.getProfileImage());
        } else {
            out.println("Không có tài khoản trong session");
        }
        session.setAttribute("justUploaded", "true");
        response.sendRedirect("home/profile.jsp");

    }

    public void changePass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("đã vào đây");
        String oldPass = request.getParameter("oldPass");
        String pass = request.getParameter("newPass");
        String ConfirmPass = request.getParameter("confirmNewPass");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String id = String.valueOf(account.getAccountID());
        System.out.println(account);
        String mhdpass = MD5Hash(oldPass);
        System.out.println(mhdpass);
        if (mhdpass.equals(account.getPasswordHash())) {

            // Tạo OTP 6 chữ số
            Random random = new Random();
            String otpCode = String.format("%06d", random.nextInt(999999));

            // Gửi email OTP
            EmailUtil emailUtil = new EmailUtil();
            emailUtil.sendConfirmationEmail(account.getEmail(), otpCode);

            // Lưu dữ liệu đăng ký + OTP + thời gian hết hạn vào session
            session.setAttribute("id", id);
            session.setAttribute("purpose", "changepass");
            session.setAttribute("pass", pass);
            session.setAttribute("otp", otpCode);
            session.setAttribute("signupOtpExpiry", System.currentTimeMillis() + 10 * 60 * 1000); // 10 phút
            response.sendRedirect("./includes/OTP.jsp");

        } else {
            request.setAttribute("pass", "mật khẩu cũ không đúng ");

        }
    }

    public void changeAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("đã vào ducowj đôi rtk ");
        HttpSession session = request.getSession();
        Account account1 = (Account) session.getAttribute("account");
        String account = request.getParameter("taikhoan");
        System.out.println(account1);
        String id = String.valueOf(account1.getAccountID());
        account1.setUsername(account);
        session.setAttribute("account", account1);
        if (account1 != null) {

            out.println("Mật khẩu: " + account1.getUsername());
        } else {
            out.println("Không có tài khoản trong session");
        }
        accountService.changeAccount(id, account);
        request.getRequestDispatcher("home/profile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        if (action.equalsIgnoreCase("changePass")) {
            System.out.println("vao quên mk");
            changePass(request, response);
            return;
        } else if (action.equalsIgnoreCase("ForgetPass")) {
            System.out.println("vào quên mk");
            forgetPass(request, response);
            return;
        } else if (action.equalsIgnoreCase("newPass")) {
            System.out.println(" vaođặt lại mk");
            newPass(request, response);
            return;
        } else if (action.equalsIgnoreCase("changeaccount")) {
            System.out.println("vào đỏi tk");
            changeAccount(request, response);
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
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        upload(request, response);
    }

    public static String MD5Hash(String input) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : array) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
