/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ManageFood;

import Model.Category;
import Model.Food;
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
import service.DAOCategori;
import service.DAOFoodService;

/**
 *
 * @author ACER
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
@WebServlet(name = "ManageFoodServlet", urlPatterns = {"/ManageFoodServlet"})
public class ManageFoodServlet extends HttpServlet {

    private DAOFoodService daoFood;
    private DAOCategori daoCategori;
    private static final String UPLOAD_DIR = "C:/Users/ACER/Documents/SWP_391/QLNH/web/img";

    @Override
    public void init() throws ServletException {
        daoFood = new DAOFoodService();
        daoCategori = new DAOCategori();

    }

    public void getAllFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Food> list = daoFood.getAll();
        request.setAttribute("foodList", list);
        request.getRequestDispatcher("./ManageFood/ManageFood.jsp").forward(request, response);
    }

    public void createFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ok ");
        String name = request.getParameter("defaultFoodName");
        String defaultIngredients = request.getParameter("defaultIngredients");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String catID= request.getParameter("categoryID");
        String fileName = null;
        try {
            Part filePart = request.getPart("image");
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
                fileName = "img/" + uniqueFileName;
            }
        } catch (Exception e) {
            request.setAttribute("signupError", "Lỗi upload ảnh: " + e.getMessage());
            request.setAttribute("showSignup", true);
            request.getRequestDispatcher("home/Login.jsp").forward(request, response);
            return;
        }
        boolean success = daoFood.addFood(name, defaultIngredients, price, description, fileName,catID);
        if (success == true){
            System.out.println("thanh cong ");
             response.sendRedirect(request.getContextPath() + "/ManageFoodServlet");
        }else {
        }
    }

   public void editFood(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    System.out.println("===> Đang xử lý sửa món ăn");

    String id = request.getParameter("foodID");
    String name = request.getParameter("defaultFoodName");
    String defaultIngredients = request.getParameter("defaultIngredients");
    String price = request.getParameter("price");
    String description = request.getParameter("description");
    String catID = request.getParameter("categoryID");
    String oldImage = request.getParameter("oldImage");

    String fileName = null;

    try {
        Part filePart = request.getPart("image");

        if (filePart != null && filePart.getSize() > 0) {
            // Có ảnh mới → upload
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

            fileName = "img/" + uniqueFileName;
        } else {
            // Không có ảnh mới → giữ lại ảnh cũ
            fileName = oldImage;
        }

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
        response.sendRedirect("error.jsp"); // xử lý redirect hoặc forward đến trang thông báo lỗi nếu cần
        return;
    }

    boolean success = daoFood.editFood(id, name, defaultIngredients, price, description, fileName, catID);
       System.out.println(id);
    if (success) {
        System.out.println("✔ Cập nhật thành công!");
        response.sendRedirect(request.getContextPath() + "/ManageFoodServlet");
    } else {
        System.out.println("❌ Lỗi khi cập nhật món ăn!");
        request.setAttribute("error", "Cập nhật thất bại");
        response.sendRedirect("error.jsp");
    }
}


    public void delFood(HttpServletRequest request, HttpServletResponse response ,String id1)
            throws ServletException, IOException {
        System.out.println("ok");
        String id =id1;
        System.out.println(id);
        boolean success = daoFood.deleFood(id);
        if ( success== true){
          response.sendRedirect(request.getContextPath() + "/ManageFoodServlet");
            System.out.println("thanh cong");
        }else {
            System.out.println(" ko dc");
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
            out.println("<title>Servlet ManageFoodServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageFoodServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String purpose = request.getParameter("purpose");
        if ("addfood".equalsIgnoreCase(purpose)) {
                 List <Category> List = daoCategori.getAll();
                 request.setAttribute("categoryList", List);
                request.getRequestDispatcher("./ManageFood/AddFood.jsp").forward(request, response);
        } else if ("edit".equalsIgnoreCase(purpose)) {
            List <Category> List = daoCategori.getAll();
                 request.setAttribute("categoryList", List);
            String id = request.getParameter("id");
            Food food = daoFood.foodDetail(id);
            request.setAttribute("food", food);
            request.getRequestDispatcher("./ManageFood/EditFood.jsp").forward(request, response);
        } else if ("delete".equalsIgnoreCase(purpose)) {
            String id = request.getParameter("foodID");
            delFood(request, response,id);
        } else {
            getAllFood(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String purpose = request.getParameter("purpose");
        if ("addfood".equalsIgnoreCase(purpose)) {
                 createFood(request, response);
        } else if ("editfood".equalsIgnoreCase(purpose)) {
            editFood(request, response);
        } else if ("delete".equalsIgnoreCase(purpose)) {
          //  delFood(request, response );
        } else {
            getAllFood(request, response);
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
