/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AdminManagerServlet;

import DAO.DAOLayer;
import Model.RevenueStats;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.*;
import java.util.List;

@WebServlet(name = "ExportReportServlet", urlPatterns = {"/ExportReportServlet"})
public class ExportReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String format = request.getParameter("format"); // pdf or excel
        String filter = request.getParameter("filter"); // day/month/year/quarter

        DAOLayer dao = new DAOLayer();
        List<RevenueStats> stats = dao.getRevenueByTime(filter);

        if ("excel".equalsIgnoreCase(format)) {
            exportExcel(stats, response);
        } else if ("pdf".equalsIgnoreCase(format)) {
            exportPdf(stats, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid format");
        }
    }

    private void exportExcel(List<RevenueStats> stats, HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Revenue Report");

        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Thời gian");
        header.createCell(1).setCellValue("Tổng doanh thu (VNĐ)");

        int rowNum = 1;
        for (RevenueStats stat : stats) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(stat.getTimeUnit());
            row.createCell(1).setCellValue(stat.getTotalRevenue().doubleValue());
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=revenue_report.xlsx");

        workbook.write(response.getOutputStream());
        workbook.close();
    }

    private void exportPdf(List<RevenueStats> stats, HttpServletResponse response) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=revenue_report.pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Báo cáo doanh thu", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph("\n"));

            PdfPTable table = new PdfPTable(2);
            table.setWidths(new float[]{3, 3});
            table.addCell("Thời gian");
            table.addCell("Tổng doanh thu (VNĐ)");

            for (RevenueStats stat : stats) {
                table.addCell(stat.getTimeUnit());
                table.addCell(String.valueOf(stat.getTotalRevenue()));
            }

            document.add(table);
            document.close();
        } catch (DocumentException e) {
            throw new IOException(e);
        }
    }
}
