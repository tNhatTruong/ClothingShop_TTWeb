package com.clothingshop.styleera.model;

import java.io.Serializable;

public class OrderDetail implements Serializable {
    private int id;
    private int order_id;
    private int variant_id;
    private int quantity;
    private double price;

    public OrderDetail() {
    }

    public OrderDetail(int id, int order_id, int variant_id, int quantity, double price) {
        this.id = id;
        this.order_id = order_id;
        this.variant_id = variant_id;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getVariant_id() {
        return variant_id;
    }

    public void setVariant_id(int variant_id) {
        this.variant_id = variant_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
