package RoomBooking;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import DAO.DAORoom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;

@WebServlet("/GenerateQRCodeServlet")
public class GenerateQRCodeServlet extends HttpServlet {
    private static final String QR_DIR = "/qrcodes";
    private static final String BASE_URL = "http://localhost:9999/quan_ly_nha_hang/ScanQRServlet?roomId=1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        DAORoom daoRoom = new DAORoom();

        try {
            if (daoRoom.isValidRoomId(roomId)) {
                String qrFileName = "room" + roomId + ".png";
                String qrFilePath = request.getServletContext().getRealPath(QR_DIR) + File.separator + qrFileName;

                File qrDir = new File(request.getServletContext().getRealPath(QR_DIR));
                if (!qrDir.exists()) {
                    qrDir.mkdirs();
                }

                String qrContent = BASE_URL + roomId;
                QRCodeWriter qrCodeWriter = new QRCodeWriter();
                BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, 250, 250);
                Path path = Paths.get(qrFilePath);
                MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

                String qrPath = QR_DIR + "/" + qrFileName;
                daoRoom.updateQRCodePath(roomId, qrPath);

                response.sendRedirect(request.getContextPath() + "/home/Home.jsp?success=QR code generated for Room " + roomId);
            } else {
                response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=Invalid Room ID");
            }
        } catch (WriterException | SQLException e) {
            response.sendRedirect(request.getContextPath() + "/home/Home.jsp?error=Error generating QR code: " + e.getMessage());
        }
    }
}