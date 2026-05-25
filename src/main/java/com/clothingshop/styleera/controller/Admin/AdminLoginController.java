package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AdminLoginController", value = "/admin-login")
public class AdminLoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. Server-side Validation
        boolean isValid = true;
        String errorMsg = null;

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            isValid = false;
            errorMsg = "Email không đúng định dạng hoặc thiếu thông tin!";
        } else {
            // Regex kiểm tra định dạng email chuẩn quốc tế
            String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
            if (!email.matches(emailRegex)) {
                isValid = false;
                errorMsg = "Email không đúng định dạng hoặc thiếu thông tin!";
            }
        }

        if (!isValid) {
            request.setAttribute("errorMsg", errorMsg);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
            return;
        }

        // 2. Query Database and check password
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmail(email);

            if (user != null && PasswordUtils.checkPassword(password, user.getPassword_hash())) {
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    user.setPassword_hash(null); // Tẩy rửa mật khẩu băm để tránh rò rỉ dữ liệu nhạy cảm
                    HttpSession session = request.getSession();
                    session.setAttribute("auth", user);
                    session.setAttribute("currentUser", user);
                    session.setMaxInactiveInterval(30 * 60);

                    response.sendRedirect(request.getContextPath() + "/AdminDashboard");
                    return;
                } else {
                    // Không có quyền Admin
                    request.setAttribute("errorMsg", "Tài khoản không có quyền truy cập Admin!");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
                    return;
                }
            } else {
                // Sai Email hoặc Mật khẩu
                request.setAttribute("errorMsg", "Sai tài khoản hoặc mật khẩu!");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            System.err.println("[AdminLoginController] Lỗi khi đăng nhập Admin: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMsg", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
        }
    }
}
