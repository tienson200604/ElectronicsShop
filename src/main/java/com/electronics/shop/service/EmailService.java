package com.electronics.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationEmail(String toEmail, String verificationCode) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("noreply@electronicsshop.com");
        message.setTo(toEmail);
        message.setSubject("Xác thực tài khoản - Electronics Shop");
        message.setText("Mã xác thực của bạn là: " + verificationCode);

        mailSender.send(message);
    }
}
