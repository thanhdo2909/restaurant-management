package AdminManagerServlet;

import DAO.DAOLayer;
import Model.RevenueStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="RevenueServlet", urlPatterns={"/RevenueServlet"})
public class RevenueServlet extends HttpServlet {
    private DAOLayer dao;

    @Override
    public void init() {
        dao = new DAOLayer();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "month"; // default
        }

        List<RevenueStats> stats = dao.getRevenueByTime(filter);
        System.out.println("Filter = " + filter + ", Revenue size = " + stats.size()); // debug

        request.setAttribute("revenueStats", stats);
        request.setAttribute("filterType", filter);
        request.getRequestDispatcher("/Amin/RevenueStats.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}
