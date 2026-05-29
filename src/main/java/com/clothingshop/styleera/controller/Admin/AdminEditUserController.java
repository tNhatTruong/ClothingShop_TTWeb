package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminEditUserController", value = "/AdminEditUser")
public class AdminEditUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-user");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            UserService userService = new UserService();
            User user = userService.findById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin-user");
                return;
            }

            request.setAttribute("userToEdit", user);
            request.getRequestDispatcher("/admin/admin-form-user.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-user");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idParam = request.getParameter("id");
        String fullName = request.getParameter("user_name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-user");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            UserService userService = new UserService();
            
            // Cập nhật thông tin vào CSDL
            userService.adminUpdateUser(userId, fullName, phone, email, role, status);

            response.sendRedirect(request.getContextPath() + "/admin-user");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật tài khoản thất bại!");
            // Nạp lại thông tin cũ để hiển thị trên form nếu có lỗi
            try {
                int userId = Integer.parseInt(idParam);
                UserService userService = new UserService();
                User user = userService.findById(userId);
                request.setAttribute("userToEdit", user);
            } catch (Exception ex) {
                // Ignore
            }
            request.getRequestDispatcher("/admin/admin-form-user.jsp").forward(request, response);
        }
    }
}
