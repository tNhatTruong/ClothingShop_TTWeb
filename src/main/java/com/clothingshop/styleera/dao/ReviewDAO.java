package com.clothingshop.styleera.dao;
import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Review;

import java.util.List;

public class ReviewDAO {
    public List<Review> findByProductId(int productId) {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            String sql = "SELECT " +
                    "  r.id, " +
                    "  r.variant_id AS variantId, " +
                    "  r.product_id AS productId, " +
                    "  r.user_id AS userId, " +
                    "  r.rating, " +
                    "  r.comment, " +
                    "  r.created_at AS createdAt, " +
                    "  u.user_name AS fullName " +
                    "FROM review r " +
                    "JOIN users u ON r.user_id = u.id " +
                    "WHERE r.product_id = :productId " +
                    "ORDER BY r.created_at DESC";

            return handle.createQuery(sql)
                    .bind("productId", productId)
                    .mapToBean(Review.class)
                    .list();
        });
    }
}