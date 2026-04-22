package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email);

        // 1. Kiểm tra đăng nhập
        if (user != null && PasswordUtils.checkPassword(pass, user.getPassword_hash())) {

            // 2. Nếu đúng pass, kiểm tra kích hoạt
            if (user.getEnabled() == 0) {
                request.setAttribute("error", "Tài khoản chưa được kích hoạt! Vui lòng nhập mã xác thực.");
                request.setAttribute("email", email);
                // Chuyển sang trang verify.jsp để nhập mã (Đúng logic)
                request.getRequestDispatcher("views/pages/verify.jsp").forward(request, response);
                return;
            }

            // 3. Đăng nhập thành công
            // 30 phút * 60 giây = 1800 giây
            // Nếu user không làm gì trong 30p, server tự hủy session này.
            HttpSession session = request.getSession();
            session.setAttribute("auth", user);
            session.setMaxInactiveInterval(30 * 60);

            // 4. Cookie
            Cookie cEmail = new Cookie("c_user", remember != null ? email : "");
            cEmail.setMaxAge(remember != null ? 7 * 24 * 60 * 60 : 0);
            cEmail.setPath("/");
            response.addCookie(cEmail);

            // 5. Chuyển hướng
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } else {
            // Nếu sai Email/Pass -> Quay lại trang LOGIN (login.jsp) chứ KHÔNG PHẢI verify.jsp
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            // Giữ lại email để người dùng không phải nhập lại
            request.setAttribute("email", email);
            request.getRequestDispatcher("views/pages/login.jsp").forward(request, response);
        }
    }
}