package com.clothingshop.styleera.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-success")
public class OrderSuccessController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            com.clothingshop.styleera.model.User user = (com.clothingshop.styleera.model.User) request.getSession().getAttribute("user");
            
            com.clothingshop.styleera.dao.OrdersDAO ordersDAO = new com.clothingshop.styleera.dao.OrdersDAO();
            com.clothingshop.styleera.model.Orders order = ordersDAO.findById(orderId);
            
            if (order == null || (user != null && order.getUserId() != user.getId())) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            com.clothingshop.styleera.dao.OrderDetailsDAO orderDetailsDAO = new com.clothingshop.styleera.dao.OrderDetailsDAO();
            java.util.List<com.clothingshop.styleera.model.OrderDetail> details = orderDetailsDAO.findByOrderId(orderId);

            com.clothingshop.styleera.dao.VariantDAO variantDAO = new com.clothingshop.styleera.dao.VariantDAO();
            java.util.Map<Integer, com.clothingshop.styleera.model.Variants> variantMap = new java.util.HashMap<>();
            for (com.clothingshop.styleera.model.OrderDetail d : details) {
                variantMap.put(d.getVariant_id(), variantDAO.getById(d.getVariant_id()));
            }

            request.setAttribute("order", order);
            request.setAttribute("details", details);
            request.setAttribute("variantMap", variantMap);

            request.getRequestDispatcher("/views/pages/order_success.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}