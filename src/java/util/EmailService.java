package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    private static final String SMTP_EMAIL = "your_gmail_here@gmail.com";      // Gmail của bạn
    private static final String SMTP_PASSWORD = "your_app_password_here";      // App Password (không phải mật khẩu Gmail)

    public static boolean sendVerificationCode(String toEmail, String code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_EMAIL, SMTP_PASSWORD);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SMTP_EMAIL, "Electro Shop"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Mã xác thực tài khoản ElectroShop");

            String content = "<h3>Mã xác thực của bạn là:</h3>"
                           + "<h2 style='color:#ff6600;'>" + code + "</h2>"
                           + "<p>Mã có hiệu lực trong 10 phút.</p>";

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
