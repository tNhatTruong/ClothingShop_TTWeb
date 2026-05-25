package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.UserService;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "BanUserController", urlPatterns = "/admin/ban-user")
public class BanUserController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject respJson = new JsonObject();
        HttpSession session = request.getSession(false);

        // 1. Phân quyền: Kiểm tra session và quyền Admin
        User currentAdmin = (session != null) ? (User) session.getAttribute("auth") : null;
        if (currentAdmin == null || !"Admin".equalsIgnoreCase(currentAdmin.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            respJson.addProperty("status", "error");
            respJson.addProperty("message", "Không có quyền thực hiện hành động này.");
            response.getWriter().write(respJson.toString());
            return;
        }

        try {
            String userIdParam = request.getParameter("user_id");
            String action = request.getParameter("action"); // "ban" hoặc "unban"

            if (userIdParam == null || userIdParam.trim().isEmpty() || action == null || action.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                respJson.addProperty("status", "error");
                respJson.addProperty("message", "Yêu cầu không hợp lệ. Thiếu thông tin.");
                response.getWriter().write(respJson.toString());
                return;
            }

            int userId = Integer.parseInt(userIdParam);

            // 2. Bảo vệ bản thân: Admin không thể tự khóa chính mình
            if (userId == currentAdmin.getId()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                respJson.addProperty("status", "error");
                respJson.addProperty("message", "Bạn không thể tự khóa/mở khóa tài khoản của chính mình!");
                response.getWriter().write(respJson.toString());
                return;
            }

            // 3. Kiểm tra tài khoản đích
            User targetUser = userService.findById(userId);
            if (targetUser == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                respJson.addProperty("status", "error");
                respJson.addProperty("message", "Tài khoản không tồn tại.");
                response.getWriter().write(respJson.toString());
                return;
            }

            // 4. Bảo vệ hệ thống: Không cho phép Admin khóa tài khoản Admin khác qua đây
            if ("Admin".equalsIgnoreCase(targetUser.getRole())) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                respJson.addProperty("status", "error");
                respJson.addProperty("message", "Không được phép thay đổi trạng thái của tài khoản Admin khác.");
                response.getWriter().write(respJson.toString());
                return;
            }

            // 5. Thực thi nghiệp vụ
            if ("ban".equalsIgnoreCase(action)) {
                userService.banUser(userId);
                respJson.addProperty("status", "success");
                respJson.addProperty("newStatus", "BANNED");
                respJson.addProperty("message", "Đã khóa tài khoản thành công.");
            } else if ("unban".equalsIgnoreCase(action)) {
                userService.unbanUser(userId);
                respJson.addProperty("status", "success");
                respJson.addProperty("newStatus", "Hoạt Động");
                respJson.addProperty("message", "Đã mở khóa tài khoản thành công.");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                respJson.addProperty("status", "error");
                respJson.addProperty("message", "Hành động không hợp lệ.");
            }

            response.getWriter().write(respJson.toString());

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            respJson.addProperty("status", "error");
            respJson.addProperty("message", "ID người dùng không hợp lệ.");
            response.getWriter().write(respJson.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            respJson.addProperty("status", "error");
            respJson.addProperty("message", "Lỗi hệ thống: " + e.getMessage());
            response.getWriter().write(respJson.toString());
        }
    }
}
