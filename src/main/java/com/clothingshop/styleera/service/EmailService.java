package com.clothingshop.styleera.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {
    private static final String HOST_NAME = "smtp.gmail.com";
    private static final int TSL_PORT = 587;
    private static final String APP_EMAIL = "22130306@st.hcmuaf.edu.vn"; // <-- THAY EMAIL CỦA BẠN ( dùng cá nhân)
    private static final String APP_PASSWORD = "qyhr qggg rgeq kodk";

    public void sendOtpEmail(String toEmail, String otpCode) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.port", TSL_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(APP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("StyleEra - Mã xác thực OTP");

            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd;'>"
                    + "<h2 style='color: #333;'>Mã xác thực tài khoản</h2>"
                    + "<p>Mã OTP của bạn là:</p>"
                    + "<h1 style='color: #e74c3c; letter-spacing: 5px; font-size: 32px;'>" + otpCode + "</h1>"
                    + "<p>Mã này có hiệu lực trong thời gian ngắn. Tuyệt đối không chia sẻ mã này cho ai.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("OTP Email sent to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

//   Xử lý gửi email trong trang Liên Hệ (Contact.jsp)
    public static void sendEmail(String toEmail,String subject, String content) throws MessagingException{
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST_NAME );
        props.put("mail.smtp.port", TSL_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(APP_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(content, "text/html; charset=UTF-8");

        Transport.send(message);
    }
}