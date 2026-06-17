package com.clothingshop.styleera.service;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.CartItem;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.enums.OrderStatus;

import java.util.List;

public class OrderService {

    /**
     * Thực hiện luồng Tạo đơn hàng, Lưu chi tiết, Trừ tồn kho và Xóa giỏ hàng
     * trong cùng 1 khối Transaction. Nếu 1 bước lỗi sẽ rollback toàn bộ.
     */
    public int placeOrder(Orders order, List<CartItem> checkoutItems, User user, boolean isBuyNow) throws Exception {
        return JDBIConnector.getJdbi().inTransaction(handle -> {
            try {
                // 1. Insert Order
                String insertOrderSql = "INSERT INTO orders (user_id, address_id, shipping_name, shipping_phone, shipping_address, status, note, price, fee_delivery, total_price) " +
                        "VALUES (:userId, :addressId, :shippingName, :shippingPhone, :shippingAddress, :status, :note, :price, :feeDelivery, :totalPrice)";
                
                int currentOrderId = handle.createUpdate(insertOrderSql)
                        .bindBean(order)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();

                // 2. Process each item (Insert details, Update stock, Remove from cart)
                String insertDetailSql = "INSERT INTO orderdetails (order_id, variant_id, quantity, price) " +
                        "VALUES (:order_id, :variant_id, :quantity, :price)";
                String updateStockSql = "UPDATE variants SET quantity = quantity - :quantity WHERE id = :variantId AND quantity >= :quantity";
                String deleteCartItemSql = "DELETE FROM cartitem WHERE user_id = ? AND variant_id = ?";

                for (CartItem item : checkoutItems) {
                    int variantId = item.getVariant().getVariantId();
                    int qty = item.getQuantity();
                    double price = item.getVariant().getProduct().getPrice();

                    // Insert detail
                    handle.createUpdate(insertDetailSql)
                            .bind("order_id", currentOrderId)
                            .bind("variant_id", variantId)
                            .bind("quantity", qty)
                            .bind("price", price)
                            .execute();

                    // Update stock
                    int updatedRows = handle.createUpdate(updateStockSql)
                            .bind("quantity", qty)
                            .bind("variantId", variantId)
                            .execute();

                    if (updatedRows == 0) {
                        throw new RuntimeException("Lỗi: Số lượng tồn kho không đủ cho sản phẩm ID " + variantId);
                    }

                    // Xóa item trong DB giỏ hàng nếu không phải Mua Ngay
                    if (!isBuyNow && user != null) {
                        handle.createUpdate(deleteCartItemSql)
                                .bind(0, user.getId())
                                .bind(1, variantId)
                                .execute();
                    }
                }
                
                return currentOrderId;
                
            } catch (Exception e) {
                // Ném ngoại lệ để JDBI tự động Rollback giao dịch này
                handle.rollback();
                throw new RuntimeException("Giao dịch tạo đơn hàng thất bại: " + e.getMessage(), e);
            }
        });
    }

    /**
     * Hủy đơn hàng và hoàn lại số lượng tồn kho nguyên tử.
     */
    public boolean cancelOrderWithStockRestore(int orderId, OrderStatus cancelStatus) {
        return JDBIConnector.getJdbi().inTransaction(handle -> {
            try {
                // 1. Cập nhật trạng thái hủy
                int rows = handle.createUpdate("UPDATE orders SET status = :status WHERE id = :id")
                        .bind("status", cancelStatus.getValue())
                        .bind("id", orderId)
                        .execute();

                if (rows > 0) {
                    // 2. Lấy danh sách chi tiết đơn hàng
                    List<OrderDetail> details = handle.createQuery("SELECT id, order_id, variant_id, quantity, price FROM orderdetails WHERE order_id = :orderId")
                            .bind("orderId", orderId)
                            .mapToBean(OrderDetail.class)
                            .list();

                    // 3. Hoàn kho
                    String restoreStockSql = "UPDATE variants SET quantity = quantity + :quantity WHERE id = :variantId";
                    for (OrderDetail detail : details) {
                        handle.createUpdate(restoreStockSql)
                                .bind("quantity", detail.getQuantity())
                                .bind("variantId", detail.getVariant_id())
                                .execute();
                    }
                    return true;
                }
                return false;
            } catch (Exception e) {
                handle.rollback();
                e.printStackTrace();
                return false;
            }
        });
    }
}
