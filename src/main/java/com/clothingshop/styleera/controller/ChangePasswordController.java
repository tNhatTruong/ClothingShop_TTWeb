package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    // Hiển thị form đổi mật khẩu (chỉ cho user đã login)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward sang reset-password.jsp (dùng chung giao diện)
        request.setAttribute("formAction", "change-password");
        request.getRequestDispatcher("/views/pages/reset-password.jsp").forward(request, response);
    }

    // Xử lý đổi mật khẩu
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String newPass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu mới
        if (newPass == null || !newPass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/views/pages/reset-password.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        UserDAO userDAO = new UserDAO();
        String hashed = PasswordUtils.hashPassword(newPass);
        userDAO.updatePassword(currentUser.getEmail(), hashed);

        // Cập nhật lại session
        currentUser.setPassword_hash(hashed);
        session.setAttribute("currentUser", currentUser);

        // Thông báo thành công
        session.setAttribute("successMsg", "Đổi mật khẩu thành công!");
        request.setAttribute("formAction", "change-password");
        response.sendRedirect(request.getContextPath() + "/account");
    }
}
