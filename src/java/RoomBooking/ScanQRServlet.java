package RoomBooking;

import DAO.DAORoom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ScanQRServlet")
public class ScanQRServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam != null && !roomIdParam.isEmpty()) {
            try {
                int roomId = Integer.parseInt(roomIdParam);
                DAORoom daoRoom = new DAORoom();

                if (daoRoom.isValidRoomId(roomId)) {
                    request.setAttribute("roomId", roomId);
                    request.getRequestDispatcher("/DisplayRoomId.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=Invalid Room ID or table not found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=Invalid Room ID format");
            } catch (SQLException e) {
                response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=No Room ID provided");
        }
    }
}