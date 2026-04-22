package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/verify")
public class VerifyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy email từ URL (?email=...)
        String email = request.getParameter("email");
        if(email != null) {
            request.setAttribute("email", email);
        }

        // Lấy thông báo từ session (nếu có) rồi xóa ngay
        HttpSession session = request.getSession();
        String msg = (String) session.getAttribute("verifyMessage");
        if(msg != null) {
            request.setAttribute("message", msg);
            session.removeAttribute("verifyMessage");
        }

        request.getRequestDispatcher("/views/pages/verify.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String inputOtp = request.getParameter("otp");
        HttpSession session = request.getSession();

        UserDAO userDAO = new UserDAO();

        if (userDAO.checkOtp(email, inputOtp)) {
            // Kiểm tra xem đang ở luồng nào
            String verifyType = (String) session.getAttribute("verifyType");

            if ("RESET_PASSWORD".equals(verifyType)) {
                // == TRƯỜNG HỢP 1: QUÊN MẬT KHẨU ==
                // SỬA: Chuyển hướng về Controller (/reset-password), KHÔNG được trỏ thẳng vào JSP
                response.sendRedirect(request.getContextPath() + "/reset-password");

            } else {
                // == TRƯỜNG HỢP 2: ĐĂNG KÝ MỚI ==
                userDAO.activeUser(email);

                // Lưu thông báo vào Session (vì Redirect sẽ làm mất request attribute)
                session.setAttribute("successMsg", "Kích hoạt thành công! Vui lòng đăng nhập.");

                // SỬA: Dùng sendRedirect thay vì forward để tránh gửi method POST sang trang Login
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            // == OTP SAI ==
            request.setAttribute("error", "Mã xác thực không chính xác!");
            request.setAttribute("email", email);

            // Forward lại trang verify để hiển thị lỗi (Đúng)
            request.getRequestDispatcher("/views/pages/verify.jsp").forward(request, response);
        }
    }
}