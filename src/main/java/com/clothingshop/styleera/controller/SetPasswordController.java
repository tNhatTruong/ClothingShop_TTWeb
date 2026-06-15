package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/set-password")
public class SetPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("auth");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Nếu đã có mật khẩu rồi thì chuyển sang trang đổi mật khẩu
        if (currentUser.getPassword_hash() != null && !currentUser.getPassword_hash().trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/change-password");
            return;
        }

        request.setAttribute("formAction", "set-password");
        request.getRequestDispatcher("/views/pages/set-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("auth");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Bảo mật: Nếu có mật khẩu rồi thì không cho phép dùng form này
        if (currentUser.getPassword_hash() != null && !currentUser.getPassword_hash().trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/change-password");
            return;
        }

        String newPass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (newPass == null || !newPass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("formAction", "set-password");
            request.getRequestDispatcher("/views/pages/set-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        String hashed = PasswordUtils.hashPassword(newPass);
        userDAO.updatePassword(currentUser.getEmail(), hashed);

        currentUser.setPassword_hash(hashed);
        session.setAttribute("currentUser", currentUser);
        session.setAttribute("auth", currentUser);

        session.setAttribute("successMsg", "Thiết lập mật khẩu thành công!");
        response.sendRedirect(request.getContextPath() + "/account");
    }
}
