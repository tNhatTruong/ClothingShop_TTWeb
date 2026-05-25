package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Orders;
import java.util.List;

public class OrdersDAO {
    // đếm tổng các order (đơn hàng)
    public int countTotalOrders() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM orders")
                        .mapTo(Integer.class)
                        .one()
        );
    }
    // lấy 4 đơn hàng gần đây nhất:
    public List<Orders> getLatestOrders(int limit) {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery(
                                "SELECT id, user_id, address_id, status, note, price, " +
                                        "fee_delivery, total_price, created_at " +
                                        "FROM orders " +
                                        "ORDER BY created_at DESC " +
                                        "LIMIT :limit"
                        )
                        .bind("limit", limit)
                        .mapToBean(Orders.class)
                        .list()
        );
    }

    // tính tổng doanh thu từ các đơn hàng đã giao thành công
    public double countTotalRevenue() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT COALESCE(SUM(total_price), 0) FROM orders WHERE status = 'Đã Giao'")
                        .mapTo(Double.class)
                        .one()
        );
    }

}
