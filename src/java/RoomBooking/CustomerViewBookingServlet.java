package RoomBooking;

import DAO.DAORoomBooking;
import Model.RoomBooking;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CustomerViewBookingServlet")
public class CustomerViewBookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        Integer accountId = (Integer) session.getAttribute("accountId");
        DAORoomBooking daoBooking = new DAORoomBooking();
        List<RoomBooking> bookings = null;
        try {
            bookings = daoBooking.getBookingsByAccount(accountId);
            request.setAttribute("bookings", bookings);
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi khi tải danh sách đặt bàn: " + e.getMessage());
        }
        request.getRequestDispatcher("/BookTable/CustomerViewBooking.jsp").forward(request, response);
    }
}