package com.clothingshop.styleera.model;

import java.time.LocalDateTime;

public class Orders {
    private int id;
    private int userId;
    private int addressId;
    private String status;
    private String note;
    private double price;
    private double feeDelivery;
    private double totalPrice;
    private LocalDateTime createdAt;

    public Orders() {
    }

    public Orders(int id, int userId, int addressId, String status, String note, double price, double feeDelivery, double totalPrice) {
        this.id = id;
        this.userId = userId;
        this.addressId = addressId;
        this.status = status;
        this.note = note;
        this.price = price;
        this.feeDelivery = feeDelivery;
        this.totalPrice = totalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getFeeDelivery() {
        return feeDelivery;
    }

    public void setFeeDelivery(double feeDelivery) {
        this.feeDelivery = feeDelivery;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
