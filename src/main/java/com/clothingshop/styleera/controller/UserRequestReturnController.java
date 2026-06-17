package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.enums.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user-request-return")
public class UserRequestReturnController extends HttpServlet {
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
                // Chỉ cho phép yêu cầu trả hàng khi đơn hàng Đã Giao
                if (OrderStatus.DELIVERED.getValue().equals(status) || OrderStatus.PAID_AT_COUNTER.getValue().equals(status)) {
                    ordersDAO.updateStatus(orderId, OrderStatus.RETURN_REQUESTED.getValue());
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/order-status?orderId=" + orderId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/order-history");
        }
    }
}
