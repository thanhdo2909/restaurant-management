    package RoomBooking;

import DAO.DAORoom;
import Model.Room;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ViewRoomsServlet", urlPatterns = {"/ViewRoomsServlet"})
public class ViewRoomsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAORoom dao = new DAORoom();
        try {
            // Retrieve filtering parameters
            String date = request.getParameter("date");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String peopleStr = request.getParameter("people");
            String message = request.getParameter("message");

            // Store parameters in session for persistence
            HttpSession session = request.getSession();
            session.setAttribute("date", date);
            session.setAttribute("startTime", startTime);
            session.setAttribute("endTime", endTime);
            session.setAttribute("people", peopleStr);
            session.setAttribute("message", message);

            List<Room> rooms;
            if (date != null && startTime != null && endTime != null && peopleStr != null &&
                !date.isEmpty() && !startTime.isEmpty() && !endTime.isEmpty() && !peopleStr.isEmpty()) {
                int people = Integer.parseInt(peopleStr);
                Timestamp startTimestamp = Timestamp.valueOf(date + " " + startTime + ":00");
                Timestamp endTimestamp = Timestamp.valueOf(date + " " + endTime + ":00");
                rooms = dao.getAvailableRooms(people, startTimestamp, endTimestamp);
            } else {
                rooms = dao.getAllRooms();
            }

            request.setAttribute("rooms", rooms);
        } catch (SQLException ex) {
            Logger.getLogger(ViewRoomsServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Không thể tải danh sách bàn: " + ex.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(ViewRoomsServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
        }
        request.getRequestDispatcher("/BookTable/roomMap.jsp").forward(request, response);
    }
}   