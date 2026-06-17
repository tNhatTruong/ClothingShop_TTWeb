package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.enums.OrderStatus;
import com.clothingshop.styleera.service.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/admin-update-order-status")
public class AdminUpdateOrderStatusController extends HttpServlet {

    // Cấu hình State Machine: Các trạng thái nào được phép chuyển đến trạng thái nào
    private static final Map<String, List<String>> VALID_TRANSITIONS = new HashMap<>();
    static {
        VALID_TRANSITIONS.put(OrderStatus.PENDING_APPROVAL.getValue(), Arrays.asList(OrderStatus.READY_TO_SHIP.getValue(), OrderStatus.CANCELED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.PENDING_PAYMENT.getValue(), Arrays.asList(OrderStatus.CANCELED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.PAID.getValue(), Arrays.asList(OrderStatus.READY_TO_SHIP.getValue(), OrderStatus.CANCELED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.ADMIN_CONFIRMED.getValue(), Arrays.asList(OrderStatus.READY_TO_SHIP.getValue(), OrderStatus.CANCELED.getValue()));
        
        VALID_TRANSITIONS.put(OrderStatus.READY_TO_SHIP.getValue(), Arrays.asList(OrderStatus.SHIPPING.getValue(), OrderStatus.CANCELED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.SHIPPING.getValue(), Arrays.asList(OrderStatus.DELIVERED.getValue(), OrderStatus.DELIVERY_FAILED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.PAID_AT_COUNTER.getValue(), Arrays.asList(OrderStatus.DELIVERED.getValue()));
        
        // Luồng Trả hàng
        VALID_TRANSITIONS.put(OrderStatus.RETURN_REQUESTED.getValue(), Arrays.asList(OrderStatus.RETURN_PROCESSING.getValue(), OrderStatus.RETURN_REJECTED.getValue()));
        VALID_TRANSITIONS.put(OrderStatus.RETURN_PROCESSING.getValue(), Arrays.asList(OrderStatus.REFUNDED.getValue()));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        String newStatus  = request.getParameter("status");

        if (orderIdStr == null || newStatus == null) {
            response.sendRedirect(request.getContextPath() + "/admin-orders?error=invalid");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrdersDAO ordersDAO = new OrdersDAO();
            Orders order = ordersDAO.findById(orderId);

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin-orders?error=notfound");
                return;
            }

            String currentStatus = order.getStatus();
            
            // State Machine Validation: Chuyển đổi trạng thái chỉ đi theo 1 chiều (hoặc luồng hoàn tác đã định nghĩa)
            List<String> allowedNextStates = VALID_TRANSITIONS.get(currentStatus);
            if (allowedNextStates == null || !allowedNextStates.contains(newStatus)) {
                // Ràng buộc 1 chiều bị vi phạm (Ví dụ: Từ Chờ duyệt nhảy thẳng sang Đã giao)
                response.sendRedirect(request.getContextPath() + "/admin-orders?error=invalid_transition");
                return;
            }

            // Nếu trạng thái mới là Hủy, phải gọi Service hoàn kho
            if (OrderStatus.CANCELED.getValue().equals(newStatus)) {
                OrderService orderService = new OrderService();
                orderService.cancelOrderWithStockRestore(orderId, OrderStatus.CANCELED);
            } else {
                ordersDAO.updateStatus(orderId, newStatus);
            }
            
            response.sendRedirect(request.getContextPath() + "/admin-orders?success=updated");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-orders?error=invalid");
        }
    }
}
