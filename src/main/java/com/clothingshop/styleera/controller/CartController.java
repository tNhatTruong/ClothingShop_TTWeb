package com.clothingshop.styleera.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CartController", value = "/cart")
public class CartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem đã có giỏ hàng trong session chưa (để tránh null pointer bên JSP nếu cần)
        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null) {
            // Có thể tạo mới hoặc để JSP tự xử lý
        }

        // Chuyển hướng sang trang giao diện
        request.getRequestDispatcher("/views/pages/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}