package com.fashionstore.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    public void sendResetPasswordEmail(String toEmail, String resetLink) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("Reset Password - Fashion Store");
            String textContent = """
                    Đặt lại mật khẩu

                    Xin chào,

                    Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng vào link sau để đặt lại mật khẩu của bạn:

                    %s

                    Liên kết này chỉ có hiệu lực trong 1 giờ.

                    Nếu bạn không yêu cầu điều này, vui lòng bỏ qua email này.

                    Fashion Store
                    """.formatted(resetLink);

            String htmlContent = """
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <meta charset="UTF-8">
                    </head>
                    <body style="font-family: Arial, sans-serif; background-color: #f5f5f5; margin: 0; padding: 0;">
                        <div style="max-width: 600px; margin: 20px auto; background-color: white; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                            <div style="background-color: #f97316; color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0;">
                                <h2 style="margin: 0; font-size: 28px;">Đặt lại mật khẩu</h2>
                            </div>
                            <div style="padding: 30px;">
                                <p style="color: #333; font-size: 16px;">Xin chào,</p>
                                <p style="color: #555; font-size: 16px; line-height: 1.6;">Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của bạn.</p>
                                <p style="color: #555; font-size: 16px; line-height: 1.6;">Vui lòng nhấp vào nút bên dưới để tiếp tục:</p>
                                <div style="text-align: center; margin: 30px 0;">
                                    <a href="%s" style="background-color: #f97316; color: white; padding: 14px 40px; text-decoration: none; border-radius: 4px; font-size: 16px; font-weight: bold; display: inline-block;">Đặt lại mật khẩu</a>
                                </div>
                                <p style="color: #666; font-size: 14px; line-height: 1.6;">Hoặc copy đường dẫn này vào trình duyệt:</p>
                                <p style="background-color: #f0f0f0; padding: 12px; border-left: 4px solid #f97316; word-break: break-all; color: #333; font-size: 13px; margin: 10px 0;">
                                    %s
                                </p>
                                <p style="color: #e74c3c; font-size: 14px; margin: 20px 0;"><strong>Lưu ý:</strong> Liên kết này chỉ có hiệu lực trong <strong>1 giờ</strong>.</p>
                                <hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">
                                <p style="color: #888; font-size: 13px;">Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
                            </div>
                            <div style="background-color: #f9f9f9; padding: 20px; text-align: center; border-radius: 0 0 8px 8px; border-top: 1px solid #eee;">
                                <p style="color: #999; font-size: 12px; margin: 0;">© 2024 Fashion Store. All rights reserved.</p>
                            </div>
                        </div>
                    </body>
                    </html>
                    """.formatted(resetLink, resetLink);

            helper.setText(textContent, htmlContent);

            mailSender.send(message);
        } catch (Exception e) {
            throw new RuntimeException("Không thể gửi email đặt lại mật khẩu !", e);
        }
    }
}
