package com.clothingshop.styleera.util;

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
            com.clothingshop.styleera.dao.OrdersDAO ordersDAO = new com.clothingshop.styleera.dao.OrdersDAO();
            com.clothingshop.styleera.service.OrderService orderService = new com.clothingshop.styleera.service.OrderService();

            // Tìm đơn hàng "Chờ thanh toán" quá 30 phút
            List<Orders> expiredOrders = ordersDAO.findExpiredPendingOrders(30);

            if (expiredOrders != null && !expiredOrders.isEmpty()) {
                for (Orders order : expiredOrders) {
                    // Chuyển sang trạng thái hủy do quá hạn và hoàn lại tồn kho trong 1 transaction
                    boolean success = orderService.cancelOrderWithStockRestore(
                            order.getId(),
                            com.clothingshop.styleera.model.enums.OrderStatus.EXPIRED
                    );
                    
                    if (success) {
                        System.out.println("Canceled expired order: " + order.getId() + " and restored stock.");
                    } else {
                        System.err.println("Failed to cancel expired order: " + order.getId());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
