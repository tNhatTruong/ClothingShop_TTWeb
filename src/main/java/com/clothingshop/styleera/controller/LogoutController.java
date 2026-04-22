package com.clothingshop.styleera.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogoutController", value = "/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Hủy Session
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate(); // Xóa sạch session (bao gồm auth và cart)
        }

        // 2. Xóa Cookie (nếu có dùng Remember Me)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("c_user".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        // 3. Chuyển hướng về trang chủ hoặc trang login
        response.sendRedirect(request.getContextPath() + "/login");
    }
}