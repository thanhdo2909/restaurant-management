/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import Model.Promotion;
import service.DAOPromotionService;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/**
 *
 * @author admin
 */
//@WebServlet("/promotion")
public class PromotionController extends HttpServlet {
    private final DAOPromotionService service = new DAOPromotionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add-form":
                request.getRequestDispatcher("/promotion/add.jsp").forward(request, response);
                break;

            case "edit-form":
                int editId = Integer.parseInt(request.getParameter("id"));
                Promotion editPromo = service.getById(editId);
                request.setAttribute("promotion", editPromo);
                request.getRequestDispatcher("/promotion/edit.jsp").forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                service.delete(deleteId);
                response.sendRedirect("promotion");
                break;

            case "toggle":
                int toggleId = Integer.parseInt(request.getParameter("id"));
                boolean toggleStatus = Boolean.parseBoolean(request.getParameter("active"));
                service.toggleStatus(toggleId, toggleStatus);
                response.sendRedirect("promotion");
                break;

            case "list":
            default:
                List<Promotion> list = service.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/promotion/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String code = request.getParameter("code");
        float percent = Float.parseFloat(request.getParameter("percent"));
        Date expire = Date.valueOf(request.getParameter("expire"));

        if ("add".equals(action)) {
            Promotion newPromo = new Promotion(0, code, percent, expire, true);
            service.add(newPromo);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean active = Boolean.parseBoolean(request.getParameter("active"));
            Promotion updatedPromo = new Promotion(id, code, percent, expire, active);
            service.update(updatedPromo);
        }
        System.out.println(">> POST /promotion - action = " + request.getParameter("action"));
        response.sendRedirect("promotion");
    }
}