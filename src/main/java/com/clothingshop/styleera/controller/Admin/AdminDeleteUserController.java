package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.UserService;
import com.clothingshop.styleera.util.SessionManage;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminDeleteUserController", value = "/AdminDeleteUser")
public class AdminDeleteUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentAdmin = SessionManage.getCurrentUser(request);
        if (currentAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-user");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            UserService userService = new UserService();
            User targetUser = userService.findById(userId);

            if (targetUser == null) {
                request.getSession().setAttribute("errorMsg", "Không tìm thấy người dùng này!");
                response.sendRedirect(request.getContextPath() + "/admin-user");
                return;
            }

            // 1. Bảo vệ bản thân: Không cho tự xóa chính mình
            if (targetUser.getId() == currentAdmin.getId()) {
                request.getSession().setAttribute("errorMsg", "Bạn không thể tự xóa tài khoản của chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin-user");
                return;
            }

            // 2. Bảo vệ Admin gốc: Không ai có quyền xóa Admin gốc
            if ("qutoan23@gmail.com".equalsIgnoreCase(targetUser.getEmail())) {
                request.getSession().setAttribute("errorMsg", "Không được phép xóa tài khoản Admin gốc!");
                response.sendRedirect(request.getContextPath() + "/admin-user");
                return;
            }

            // 3. Phân quyền xóa Admin thường: Chỉ Admin gốc mới được phép
            if ("Admin".equalsIgnoreCase(targetUser.getRole())) {
                boolean isRoot = "qutoan23@gmail.com".equalsIgnoreCase(currentAdmin.getEmail());
                if (!isRoot) {
                    request.getSession().setAttribute("errorMsg", "Chỉ Admin gốc mới có quyền xóa tài khoản Admin khác!");
                    response.sendRedirect(request.getContextPath() + "/admin-user");
                    return;
                }
            }

            // 4. Thực hiện xóa cứng trong Database
            userService.deleteUser(userId);
            request.getSession().setAttribute("successMsg", "Đã xóa vĩnh viễn tài khoản '" + targetUser.getUser_name() + "' ra khỏi hệ thống thành công!");

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMsg", "ID tài khoản không đúng định dạng!");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMsg", "Lỗi khi xóa tài khoản: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin-user");
    }
}
