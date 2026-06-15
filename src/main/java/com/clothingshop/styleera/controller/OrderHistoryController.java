package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.Variants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order-history")
public class OrderHistoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        OrdersDAO ordersDAO = new OrdersDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        VariantDAO variantDAO = new VariantDAO();

        List<Orders> ordersList = ordersDAO.findByUserId(user.getId());
        
        // Tạo Map để chứa chi tiết đơn hàng (Lấy sản phẩm đầu tiên để hiển thị)
        Map<Integer, OrderDetail> firstDetailMap = new HashMap<>();
        Map<Integer, Variants> variantMap = new HashMap<>();
        Map<Integer, Integer> detailCountMap = new HashMap<>();

        if (ordersList != null) {
            for (Orders order : ordersList) {
                List<OrderDetail> details = orderDetailsDAO.findByOrderId(order.getId());
                if (details != null && !details.isEmpty()) {
                    detailCountMap.put(order.getId(), details.size());
                    OrderDetail firstDetail = details.get(0);
                    firstDetailMap.put(order.getId(), firstDetail);
                    Variants variant = variantDAO.getById(firstDetail.getVariant_id());
                    variantMap.put(firstDetail.getVariant_id(), variant);
                } else {
                    detailCountMap.put(order.getId(), 0);
                }
            }
        }

        request.setAttribute("ordersList", ordersList);
        request.setAttribute("firstDetailMap", firstDetailMap);
        request.setAttribute("variantMap", variantMap);
        request.setAttribute("detailCountMap", detailCountMap);

        request.getRequestDispatcher("/views/pages/order-history.jsp").forward(request, response);
    }
}