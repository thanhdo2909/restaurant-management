package RoomBooking;

import DAO.DAORoomBooking;
import DAO.DBConnection;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CancelBookingServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/home/Login.jsp");
            return;
        }

        Integer accountId = (Integer) session.getAttribute("accountId");
        String bookingIdStr = request.getParameter("bookingId");

        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            session.setAttribute("error", "Mã đặt bàn không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/CustomerViewBookingServlet");
            return;
        }

        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Mã đặt bàn không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/CustomerViewBookingServlet");
            return;
        }

        DAORoomBooking daoBooking = new DAORoomBooking();
        try {
            if (daoBooking.submitCancellationRequest(bookingId, accountId)) {
                session.setAttribute("success", "Yêu cầu hủy đặt bàn đã được gửi thành công! Vui lòng chờ admin phê duyệt.");
            } else {
                session.setAttribute("error", "Không thể gửi yêu cầu hủy! Vui lòng kiểm tra quyền hoặc trạng thái.");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi gửi yêu cầu hủy: " + e.getMessage(), e);
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/CustomerViewBookingServlet");
    }
}