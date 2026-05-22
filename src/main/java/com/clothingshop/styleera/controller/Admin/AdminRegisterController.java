package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminRegisterController", urlPatterns = "/admin-register")
public class AdminRegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang giao diện đăng ký Admin
        request.getRequestDispatcher("/admin/admin-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        String fullName  = request.getParameter("fullName");
        String email     = request.getParameter("email");
        String phone     = request.getParameter("phone");
        String password  = request.getParameter("password");

        // --- Kiểm tra đầu vào cơ bản ---
        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\",\"msg\":\"Vui lòng điền đầy đủ thông tin bắt buộc!\"}");
            return;
        }

        if (password.length() < 8) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\",\"msg\":\"Mật khẩu phải có ít nhất 8 ký tự!\"}");
            return;
        }

        // --- Xây dựng đối tượng User ---
        User newAdmin = new User();
        newAdmin.setUser_name(fullName.trim());
        newAdmin.setEmail(email.trim());
        newAdmin.setPhone(phone != null ? phone.trim() : "");
        newAdmin.setPassword_hash(password); // Service sẽ băm BCrypt

        // --- Gọi Service để đăng ký ---
        try {
            UserService userService = new UserService();
            userService.registerAdmin(newAdmin);
            out.print("{\"status\":\"success\",\"msg\":\"Tạo tài khoản Admin thành công!\"}");
        } catch (IllegalArgumentException e) {
            // Email trùng lặp
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            out.print("{\"status\":\"error\",\"msg\":\"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            // Lỗi hệ thống
            System.err.println("[AdminRegisterController] Lỗi khi tạo Admin: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\",\"msg\":\"Lỗi hệ thống, vui lòng thử lại!\"}");
        }
    }
}
