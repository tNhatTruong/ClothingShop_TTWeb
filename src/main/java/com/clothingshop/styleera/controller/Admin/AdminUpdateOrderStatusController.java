package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.OrdersDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin-update-order-status")
public class AdminUpdateOrderStatusController extends HttpServlet {

    private static final List<String> ALLOWED_STATUSES = Arrays.asList(
            "Chờ vận chuyển",
            "Đang vận chuyển",
            "Đã Giao",
            "Đã hủy"
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        String newStatus  = request.getParameter("status");

        // Validate
        if (orderIdStr == null || newStatus == null || !ALLOWED_STATUSES.contains(newStatus)) {
            response.sendRedirect(request.getContextPath() + "/admin-orders?error=invalid");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrdersDAO ordersDAO = new OrdersDAO();
            ordersDAO.updateStatus(orderId, newStatus);
            response.sendRedirect(request.getContextPath() + "/admin-orders?success=updated");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-orders?error=invalid");
        }
    }
}
