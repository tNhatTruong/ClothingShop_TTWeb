package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.EmailService;
import com.clothingshop.styleera.util.PasswordUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/pages/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Nhận dữ liệu
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");

        UserDAO userDAO = new UserDAO();

        // 2. Validate dữ liệu
        if (!pass.equals(confirmPass)) {
            forwardWithError(request, response, "Mật khẩu xác nhận không khớp!");
            return;
        }
        if (userDAO.findByEmail(email) != null) {
            forwardWithError(request, response, "Email này đã được sử dụng!");
            return;
        }

        // 3. Xử lý logic nghiệp vụ (Tạo OTP, Hash Pass)
        String otpCode = generateOTP();
        String hashedPassword = PasswordUtils.hashPassword(pass);

        User user = new User();
        user.setUser_name(name);
        user.setEmail(email);
        user.setPassword_hash(hashedPassword);
        user.setPhone(phone);
        user.setEnabled(0); // Chưa kích hoạt

        // 4. Lưu vào DB
        userDAO.registerUser(user, otpCode);

        // 5. Gửi Email (Chạy luồng riêng để user không phải đợi)
        new Thread(() -> {
            new EmailService().sendOtpEmail(email, otpCode);
        }).start();

        // 6. Điều hướng
        // Lưu email vào request để trang verify tự điền
        request.setAttribute("email", email);
        request.setAttribute("message", "Mã xác thực đã được gửi đến email của bạn.");
        request.getRequestDispatcher("/views/pages/verify.jsp").forward(request, response);
    }

    // Hàm phụ trợ: Tạo OTP 6 số
    private String generateOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    // Hàm phụ trợ: Báo lỗi
    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, String error) throws ServletException, IOException {
        req.setAttribute("error", error);
        req.getRequestDispatcher("/views/pages/register.jsp").forward(req, resp);
    }
}