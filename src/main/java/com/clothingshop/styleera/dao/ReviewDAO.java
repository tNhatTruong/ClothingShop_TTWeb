package com.clothingshop.styleera.dao;
import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Review;

import java.util.List;

public class ReviewDAO {
    public List<Review> findAll() {
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
                    "ORDER BY r.created_at DESC";

            return handle.createQuery(sql)
                    .mapToBean(Review.class)
                    .list();
        });
    }
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
    public void insertReview(int productId, int userId, int rating, String comment) {
        JDBIConnector.getJdbi().useHandle(handle -> {
            String sql = "INSERT INTO review (product_id, user_id, rating, comment, created_at) " +
                    "VALUES (:productId, :userId, :rating, :comment, NOW())";

            handle.createUpdate(sql)
                    .bind("productId", productId)
                    .bind("userId", userId)
                    .bind("rating", rating)
                    .bind("comment", comment)
                    .execute();
        });
    }
    public List<Review> filterReviews(String ratingFilter, String dateSort) {
        String sql = "SELECT r.id, r.variant_id AS variantId, r.product_id AS productId, " +
                "r.user_id AS userId, r.rating, r.comment, r.created_at AS createdAt, " +
                "u.user_name AS fullName FROM review r " +
                "JOIN users u ON r.user_id = u.id WHERE 1=1 ";

        if ("good".equals(ratingFilter)) sql += " AND r.rating >= 4";
        else if ("average".equals(ratingFilter)) sql += " AND r.rating >= 3 AND r.rating < 4";
        else if ("bad".equals(ratingFilter)) sql += " AND r.rating < 3";

        sql += " ORDER BY r.created_at " + ("oldest".equals(dateSort) ? "ASC" : "DESC");

        String finalSql = sql;
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery(finalSql).mapToBean(Review.class).list());
    }
}