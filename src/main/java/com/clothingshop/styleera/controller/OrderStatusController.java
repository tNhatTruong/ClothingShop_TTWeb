package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.OrdersService;
import com.clothingshop.styleera.util.SessionManage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-status")
public class OrderStatusController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra người dùng đã đăng nhập chưa
        User currentUser = SessionManage.getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy orderId từ client gửi lên
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            idParam = request.getParameter("orderId");
        }

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam.trim());
                OrdersService ordersService = new OrdersService();
                Orders order = ordersService.findById(orderId);

                if (order != null) {
                    // 3. Phòng chống lỗi IDOR: Luôn check quyền sở hữu dữ liệu
                    if (order.getUserId() != currentUser.getId()) {
                        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn không có quyền truy cập đơn hàng này!");
                        return;
                    }
                    request.setAttribute("order", order);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Đơn hàng không tồn tại!");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã đơn hàng không hợp lệ!");
                return;
            }
        }

        request.getRequestDispatcher("/views/pages/order_status.jsp").forward(request, response);
    }
}