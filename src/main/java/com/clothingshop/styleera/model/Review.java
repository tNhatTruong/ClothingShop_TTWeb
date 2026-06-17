package com.clothingshop.styleera.model;

import java.sql.Timestamp;

public class Review {
    private int id;
    private Integer variantId;
    private int productId;
    private int userId;
    private int rating;
    private String comment;
    private Timestamp createdAt;

    private Integer orderId;
    private String adminReply;
    private Integer oldRating;
    private String oldComment;
    private Timestamp editedAt;
    private Integer editCount;

    private String fullName;

    public Review() {
    }

    public Review(int id, Integer variantId, int productId, int userId, int rating, String comment, Timestamp createdAt,
                  Integer orderId, String adminReply, Integer oldRating, String oldComment, Timestamp editedAt, Integer editCount, String fullName) {
        this.id = id;
        this.variantId = variantId;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.orderId = orderId;
        this.adminReply = adminReply;
        this.oldRating = oldRating;
        this.oldComment = oldComment;
        this.editedAt = editedAt;
        this.editCount = editCount;
        this.fullName = fullName;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getAdminReply() {
        return adminReply;
    }

    public void setAdminReply(String adminReply) {
        this.adminReply = adminReply;
    }

    public Integer getOldRating() {
        return oldRating;
    }

    public void setOldRating(Integer oldRating) {
        this.oldRating = oldRating;
    }

    public String getOldComment() {
        return oldComment;
    }

    public void setOldComment(String oldComment) {
        this.oldComment = oldComment;
    }

    public Timestamp getEditedAt() {
        return editedAt;
    }

    public void setEditedAt(Timestamp editedAt) {
        this.editedAt = editedAt;
    }

    public Integer getEditCount() {
        return editCount;
    }

    public void setEditCount(Integer editCount) {
        this.editCount = editCount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getVariantId() {
        return variantId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Hàm toString()
    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", variantId=" + variantId +
                ", productId=" + productId +
                ", userId=" + userId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", createdAt=" + createdAt +
                ", orderId=" + orderId +
                ", adminReply='" + adminReply + '\'' +
                ", oldRating=" + oldRating +
                ", oldComment='" + oldComment + '\'' +
                ", editedAt=" + editedAt +
                ", editCount=" + editCount +
                ", fullName='" + fullName + '\'' +
                '}';
    }
}