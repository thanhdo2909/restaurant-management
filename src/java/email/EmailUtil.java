package email;


import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {
    

    private final String senderEmail = "thanhdvde180989@fpt.edu.vn"; 
    private final String senderPassword = "unlc olvm wmpi atnz"; 

    public void sendConfirmationEmail(String recipientEmail, String otp) {
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
        message.setSubject("Mã OTP xác nhận");

        String content = "Mã OTP của bạn là: " + otp;
        message.setContent(content, "text/plain; charset=UTF-8");

        Transport.send(message);
        System.out.println("✅ Email đã được gửi đến " + recipientEmail);
    } catch (MessagingException e) {
        e.printStackTrace();
    }
    }
    
    

}