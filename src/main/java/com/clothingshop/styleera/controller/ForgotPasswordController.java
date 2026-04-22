package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/pages/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/forgot-password").forward(request, response);
            return;
        }

        // 1. Tạo OTP
        int randomPin = (int) (Math.random() * 900000) + 100000;
        String otpCode = String.valueOf(randomPin);

        // 2. Lưu OTP vào DB
        userDAO.updateOtp(email, otpCode);

        // 3. Gửi Email (Chạy luồng riêng để không đơ web)
        new Thread(() -> {
            new EmailService().sendOtpEmail(email, otpCode);
        }).start();

        // 4. Lưu session để biết là đang Reset Password (khác với Verify đăng ký)
        HttpSession session = request.getSession();
        session.setAttribute("verifyType", "RESET_PASSWORD");
        session.setAttribute("resetEmail", email);

        // 5. Chuyển sang trang nhập OTP
        request.setAttribute("email", email); // Hiển thị email ở trang verify
        request.setAttribute("message", "Mã OTP khôi phục mật khẩu đã được gửi!");
        request.getSession().setAttribute("verifyMessage", "Mã OTP đã được gửi!"); // Lưu thông báo vào session tạm
        response.sendRedirect(request.getContextPath() + "/verify?email=" + email); // Chuyển hướng sang URL /verify
    }
}