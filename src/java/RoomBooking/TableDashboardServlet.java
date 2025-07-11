package RoomBooking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/TableDashboardServlet")
public class TableDashboardServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        String customerName = request.getParameter("customerName");
        int roomId = Integer.parseInt(request.getParameter("roomId"));

        if (customerName != null && !customerName.isEmpty()) {
            session.setAttribute("customerName", customerName);
            session.setAttribute("roomId", roomId);
            response.sendRedirect(request.getContextPath() + "/TableDashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/CustomerInfo.jsp?error=Please enter your name");
        }
    }
}