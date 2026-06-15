package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cancel-order")
public class CancelOrderController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User authUser = (User) request.getSession().getAttribute("auth");
        if (authUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrdersDAO ordersDAO = new OrdersDAO();
            Orders order = ordersDAO.findById(orderId);

            if (order != null && order.getUserId() == authUser.getId()) {
                String status = order.getStatus();
                if ("Chờ duyệt".equals(status) || "Chờ thanh toán".equals(status) || "Đã Thanh Toán".equals(status) || "Chờ lấy hàng".equals(status) || "Chờ đơn vị vận chuyển lấy hàng".equals(status)) {
                    // Update status
                    ordersDAO.updateStatus(orderId, "Hủy (Bởi người dùng)");

                    // Restore stock
                    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
                    VariantDAO variantDAO = new VariantDAO();
                    List<OrderDetail> details = orderDetailsDAO.findByOrderId(orderId);
                    if (details != null) {
                        for (OrderDetail detail : details) {
                            variantDAO.restoreStock(detail.getVariant_id(), detail.getQuantity());
                        }
                    }
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/order-status?orderId=" + orderId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/order-history");
        }
    }
}
