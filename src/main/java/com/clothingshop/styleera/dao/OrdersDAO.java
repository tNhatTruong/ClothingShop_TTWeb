package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Orders;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrdersDAO {
    private Jdbi jdbi;
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

}
