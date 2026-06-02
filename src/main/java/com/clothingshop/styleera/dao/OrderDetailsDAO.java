package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.OrderDetail;
import org.jdbi.v3.core.Jdbi;

public class OrderDetailsDAO {
    public void insertOrderDetail(OrderDetail detail) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "INSERT INTO orderdetails (order_id, variant_id, quantity, price) " +
                         "VALUES (:order_id, :variant_id, :quantity, :price)";
            handle.createUpdate(sql)
                  .bind("order_id", detail.getOrder_id())
                  .bind("variant_id", detail.getVariant_id())
                  .bind("quantity", detail.getQuantity())
                  .bind("price", detail.getPrice())
                  .execute();
        });
    }
    public java.util.List<OrderDetail> findByOrderId(int orderId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
            handle.createQuery("SELECT id, order_id, variant_id, quantity, price FROM orderdetails WHERE order_id = :orderId")
                  .bind("orderId", orderId)
                  .mapToBean(OrderDetail.class)
                  .list()
        );
    }
}
