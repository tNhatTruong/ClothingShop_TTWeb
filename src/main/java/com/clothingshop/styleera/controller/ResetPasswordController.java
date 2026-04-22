package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    // 1. Xử lý GET: Hiển thị form nhập mật khẩu mới
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String verifyType = (String) session.getAttribute("verifyType");

        // Bảo mật: Chỉ cho phép vào nếu đang trong luồng RESET_PASSWORD
        // Nếu user cố tình gõ URL này mà chưa qua bước OTP -> Đá về login
        if (!"RESET_PASSWORD".equals(verifyType)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Chuyển hướng vào Kho (File JSP) để hiển thị giao diện
        request.getRequestDispatcher("/views/pages/reset-password.jsp").forward(request, response);
    }

    // 2. Xử lý POST: Nhận mật khẩu mới và cập nhật
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        String verifyType = (String) session.getAttribute("verifyType");

        // Bảo mật: Kiểm tra lại session lần nữa
        if (email == null || !"RESET_PASSWORD".equals(verifyType)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String newPass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        // Validate mật khẩu
        if (newPass == null || !newPass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            // Lỗi -> Forward lại về trang JSP cũ để hiện lỗi
            request.getRequestDispatcher("/views/pages/reset-password.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới vào DB
        UserDAO userDAO = new UserDAO();
        userDAO.updatePassword(email, PasswordUtils.hashPassword(newPass));

        // Xóa session để kết thúc quy trình (quan trọng để bảo mật)
        session.removeAttribute("verifyType");
        session.removeAttribute("resetEmail");

        // Thành công -> Chuyển hướng sang trang Login
        // Dùng Session để truyền thông báo vì sendRedirect sẽ làm mất request attribute
        session.setAttribute("successMsg", "Đổi mật khẩu thành công! Hãy đăng nhập lại.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}