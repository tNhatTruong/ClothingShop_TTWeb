package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.UserService;
import com.clothingshop.styleera.util.SessionManage;
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

            // Phân quyền bảo mật: Admin thường không thể sửa Admin khác
            User currentAdmin = SessionManage.getCurrentUser(request);
            boolean isRoot = currentAdmin != null && "qutoan23@gmail.com".equalsIgnoreCase(currentAdmin.getEmail());
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                if (!isRoot && user.getId() != currentAdmin.getId()) {
                    request.getSession().setAttribute("errorMsg", "Chỉ Admin gốc mới có quyền chỉnh sửa Admin khác!");
                    response.sendRedirect(request.getContextPath() + "/admin-user");
                    return;
                }
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

        // Phân quyền bảo mật
        User currentAdmin = SessionManage.getCurrentUser(request);
        if (currentAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        boolean isRoot = "qutoan23@gmail.com".equalsIgnoreCase(currentAdmin.getEmail());

        try {
            int userId = Integer.parseInt(idParam);
            UserService userService = new UserService();
            User targetUser = userService.findById(userId);

            if (targetUser == null) {
                response.sendRedirect(request.getContextPath() + "/admin-user");
                return;
            }

            // 1.1. Chặn sửa Admin gốc
            if ("qutoan23@gmail.com".equalsIgnoreCase(targetUser.getEmail())) {
                if (!isRoot) {
                    request.getSession().setAttribute("errorMsg", "Không có quyền sửa Admin gốc!");
                    response.sendRedirect(request.getContextPath() + "/admin-user");
                    return;
                }
                // Admin gốc không thể tự đổi email hoặc hạ cấp của chính mình
                email = "qutoan23@gmail.com";
                role = "Admin";
                status = "Hoạt Động";
            }

            // 1.2. Chặn Admin thường sửa Admin khác
            if ("Admin".equalsIgnoreCase(targetUser.getRole())) {
                if (!isRoot && targetUser.getId() != currentAdmin.getId()) {
                    request.getSession().setAttribute("errorMsg", "Chỉ Admin gốc mới có quyền chỉnh sửa Admin khác!");
                    response.sendRedirect(request.getContextPath() + "/admin-user");
                    return;
                }
                // Chống hạ cấp (Demotion Protection)
                if (!isRoot) {
                    role = "Admin"; // Cưỡng chế vai trò không đổi nếu không phải Root Admin
                }
            }
            
            // Cập nhật thông tin vào CSDL
            userService.adminUpdateUser(userId, fullName, phone, email, role, status);
            request.getSession().setAttribute("successMsg", "Đã cập nhật thông tin tài khoản thành công!");
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
