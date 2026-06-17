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
                    "  r.order_id AS orderId, " +
                    "  r.admin_reply AS adminReply, " +
                    "  r.old_rating AS oldRating, " +
                    "  r.old_comment AS oldComment, " +
                    "  r.edited_at AS editedAt, " +
                    "  r.edit_count AS editCount, " +
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
                    "  r.order_id AS orderId, " +
                    "  r.admin_reply AS adminReply, " +
                    "  r.old_rating AS oldRating, " +
                    "  r.old_comment AS oldComment, " +
                    "  r.edited_at AS editedAt, " +
                    "  r.edit_count AS editCount, " +
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
    public void insertReview(int orderId, int productId, int userId, int rating, String comment) {
        JDBIConnector.getJdbi().useHandle(handle -> {
            String sql = "INSERT INTO review (order_id, product_id, user_id, rating, comment, created_at, edit_count) " +
                    "VALUES (:orderId, :productId, :userId, :rating, :comment, NOW(), 0)";

            handle.createUpdate(sql)
                    .bind("orderId", orderId)
                    .bind("productId", productId)
                    .bind("userId", userId)
                    .bind("rating", rating)
                    .bind("comment", comment)
                    .execute();
        });
    }

    public Review checkIfReviewed(int orderId, int productId, int userId) {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            String sql = "SELECT r.id, r.order_id AS orderId, r.product_id AS productId, r.user_id AS userId, " +
                         "r.rating, r.comment, r.created_at AS createdAt, r.admin_reply AS adminReply, " +
                         "r.old_rating AS oldRating, r.old_comment AS oldComment, r.edited_at AS editedAt, " +
                         "r.edit_count AS editCount, u.user_name AS fullName " +
                         "FROM review r JOIN users u ON r.user_id = u.id " +
                         "WHERE r.order_id = :orderId AND r.product_id = :productId AND r.user_id = :userId LIMIT 1";
            return handle.createQuery(sql)
                    .bind("orderId", orderId)
                    .bind("productId", productId)
                    .bind("userId", userId)
                    .mapToBean(Review.class)
                    .findOne().orElse(null);
        });
    }

    public void updateReviewByUser(int reviewId, int newRating, String newComment) {
        JDBIConnector.getJdbi().useHandle(handle -> {
            String sql = "UPDATE review SET old_rating = rating, old_comment = comment, " +
                         "rating = :newRating, comment = :newComment, edited_at = NOW(), edit_count = edit_count + 1 " +
                         "WHERE id = :reviewId AND edit_count = 0";
            handle.createUpdate(sql)
                    .bind("newRating", newRating)
                    .bind("newComment", newComment)
                    .bind("reviewId", reviewId)
                    .execute();
        });
    }

    public void updateAdminReply(int reviewId, String adminReply) {
        JDBIConnector.getJdbi().useHandle(handle -> {
            String sql = "UPDATE review SET admin_reply = :adminReply WHERE id = :reviewId";
            handle.createUpdate(sql)
                    .bind("adminReply", adminReply)
                    .bind("reviewId", reviewId)
                    .execute();
        });
    }
    public List<Review> filterReviews(String ratingFilter, String dateSort) {
        String sql = "SELECT r.id, r.variant_id AS variantId, r.product_id AS productId, " +
                "r.user_id AS userId, r.rating, r.comment, r.created_at AS createdAt, " +
                "r.order_id AS orderId, r.admin_reply AS adminReply, r.old_rating AS oldRating, " +
                "r.old_comment AS oldComment, r.edited_at AS editedAt, r.edit_count AS editCount, " +
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