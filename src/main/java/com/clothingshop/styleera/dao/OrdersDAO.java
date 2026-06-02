package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Orders;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /** Doanh thu theo tháng (year*100+month -> tổng tiền) cho đơn đã giao. */
    public Map<Integer, Double> getDeliveredRevenueByMonth() {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            Map<Integer, Double> revenueByMonth = new HashMap<>();
            handle.createQuery(
                            "SELECT YEAR(created_at) AS y, MONTH(created_at) AS m, " +
                                    "COALESCE(SUM(total_price), 0) AS revenue " +
                                    "FROM orders WHERE status = 'Đã Giao' " +
                                    "GROUP BY YEAR(created_at), MONTH(created_at)"
                    )
                    .map((rs, ctx) -> {
                        int key = rs.getInt("y") * 100 + rs.getInt("m");
                        return Map.entry(key, rs.getDouble("revenue"));
                    })
                    .list()
                    .forEach(entry -> revenueByMonth.put(entry.getKey(), entry.getValue()));
            return revenueByMonth;
        });
    }

    // Lấy thông tin đơn hàng theo ID
    public Orders findById(int orderId) {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery(
                                "SELECT id, user_id, address_id, status, note, price, " +
                                        "fee_delivery, total_price, created_at " +
                                        "FROM orders " +
                                        "WHERE id = :id"
                        )
                        .bind("id", orderId)
                        .mapToBean(Orders.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public int insertOrder(Orders order) {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            String sql = "INSERT INTO orders (user_id, address_id, status, note, price, fee_delivery, total_price) " +
                         "VALUES (:userId, :addressId, :status, :note, :price, :feeDelivery, :totalPrice)";
            return handle.createUpdate(sql)
                    .bindBean(order)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        });
    }
    public boolean updateStatus(int orderId, String status) {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            int rows = handle.createUpdate("UPDATE orders SET status = :status WHERE id = :id")
                    .bind("status", status)
                    .bind("id", orderId)
                    .execute();
            return rows > 0;
        });
    }

    public List<Orders> findExpiredPendingOrders(int timeoutMinutes) {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT id, user_id, address_id, status, note, price, fee_delivery, total_price, created_at " +
                                "FROM orders " +
                                "WHERE status = 'PENDING' AND TIMESTAMPDIFF(MINUTE, created_at, NOW()) >= :timeout")
                        .bind("timeout", timeoutMinutes)
                        .mapToBean(Orders.class)
                        .list()
        );
    }
}
