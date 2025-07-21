package email;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class BookingEmailUtil {
    private final String senderEmail = "thanhdvde180989@fpt.edu.vn"; 
    private final String senderPassword = "unlc olvm wmpi atnz"; 

    public void sendBookingConfirmationEmail(String recipientEmail, String customerName, int roomId, 
            String date, String startTime, String endTime, int people) {
        // Cấu hình SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // Tạo phiên email
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });
        session.setDebug(true);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Xác Nhận Đặt Bàn Thành Công - The Golden Spoon");

            // Nội dung email
            String content = "Kính gửi " + customerName + ",\n\n" +
                    "Cảm ơn bạn đã đặt bàn tại The Golden Spoon Restaurant!\n\n" +
                    "Thông tin đặt bàn:\n" +
                    "- Tên khách hàng: " + customerName + "\n" +
                    "- Số bàn: " + roomId + "\n" +
                    "- Ngày: " + date + "\n" +
                    "- Giờ bắt đầu: " + startTime + "\n" +
                    "- Giờ kết thúc: " + endTime + "\n" +
                    "- Số người: " + people + " khách\n\n" +
                    "Vui lòng đến đúng giờ để trải nghiệm dịch vụ của chúng tôi. Nếu có thay đổi, vui lòng liên hệ qua email này.\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ The Golden Spoon";

            message.setContent(content, "text/plain; charset=UTF-8");

            Transport.send(message);
            System.out.println("✅ Email xác nhận đã được gửi đến " + recipientEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Lỗi gửi email: " + e.getMessage());
        }
    }
}