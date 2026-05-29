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

    private String fullName;

    public Review() {
    }

    public Review(int id, Integer variantId, int productId, int userId, int rating, String comment, Timestamp createdAt, String fullName) {
        this.id = id;
        this.variantId = variantId;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.fullName = fullName;
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
                ", fullName='" + fullName + '\'' +
                '}';
    }
}