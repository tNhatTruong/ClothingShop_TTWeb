package com.clothingshop.styleera.util;

import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.Orders;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

@WebListener
public class OrderCleanupListener implements ServletContextListener {

    private Timer timer = null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true);
        // Chạy lần đầu ngay lập tức, sau đó lặp lại mỗi 10 phút (600000 ms)
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                cleanupExpiredOrders();
            }
        }, 0, 10 * 60 * 1000);
        System.out.println("OrderCleanupListener initialized. Checking for expired orders every 10 minutes.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
            System.out.println("OrderCleanupListener destroyed.");
        }
    }

    private void cleanupExpiredOrders() {
        try {
            OrdersDAO ordersDAO = new OrdersDAO();
            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            VariantDAO variantDAO = new VariantDAO();

            // Tìm đơn hàng PENDING quá 30 phút
            List<Orders> expiredOrders = ordersDAO.findExpiredPendingOrders(30);

            if (expiredOrders != null && !expiredOrders.isEmpty()) {
                for (Orders order : expiredOrders) {
                    // Chuyển sang trạng thái hủy do quá hạn
                    ordersDAO.updateStatus(order.getId(), "Hủy (Quá hạn thanh toán)");

                    // Hoàn lại số lượng tồn kho
                    List<OrderDetail> details = orderDetailsDAO.findByOrderId(order.getId());
                    if (details != null) {
                        for (OrderDetail detail : details) {
                            variantDAO.restoreStock(detail.getVariant_id(), detail.getQuantity());
                        }
                    }
                    System.out.println("Canceled expired order: " + order.getId() + " and restored stock.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
