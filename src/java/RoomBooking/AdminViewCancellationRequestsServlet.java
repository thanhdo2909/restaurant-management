package RoomBooking;

import DAO.DAORoomBooking;
import DAO.DBConnection;
import Model.RoomBooking;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminViewCancellationRequestsServlet")
public class AdminViewCancellationRequestsServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminViewCancellationRequestsServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        DAORoomBooking daoBooking = new DAORoomBooking();
        List<RoomBooking> cancellationRequests = null;

        try {
            cancellationRequests = daoBooking.getPendingCancellations();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi truy xuất danh sách yêu cầu hủy: " + e.getMessage(), e);
            request.setAttribute("error", "Lỗi khi truy xuất danh sách yêu cầu hủy: " + e.getMessage());
            request.getRequestDispatcher("/BookTable/AdminCancellationRequests.jsp").forward(request, response);
            return;
        }

        request.setAttribute("cancellationRequests", cancellationRequests);
        request.getRequestDispatcher("/BookTable/AdminCancellationRequests.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String action = request.getParameter("action");
        DAORoomBooking daoBooking = new DAORoomBooking();
        boolean success = false;

        try {
            if ("approve".equalsIgnoreCase(action)) {
                success = daoBooking.approveCancellation(bookingId);
                if (success) {
                    session.setAttribute("success", "Yêu cầu hủy đặt bàn đã được phê duyệt thành công!");
                } else {
                    session.setAttribute("error", "Không thể phê duyệt yêu cầu hủy! Vui lòng kiểm tra lại.");
                }
            } else if ("reject".equalsIgnoreCase(action)) {
                success = daoBooking.rejectCancellation(bookingId);
                if (success) {
                    session.setAttribute("success", "Yêu cầu hủy đặt bàn đã bị từ chối thành công!");
                } else {
                    session.setAttribute("error", "Không thể từ chối yêu cầu hủy! Vui lòng kiểm tra lại.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xử lý yêu cầu hủy: " + e.getMessage(), e);
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/AdminViewCancellationRequestsServlet");
    }
}