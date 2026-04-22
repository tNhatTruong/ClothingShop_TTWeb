package com.clothingshop.styleera.model;

import java.io.Serializable;

public class Variants implements Serializable {
    private int variantId;
    private Product product;
    private String size;
    private String color;
    private int quantity;

    public Variants() {
    }

    public Variants(int variantId, Product productId, String size, String color, int quantity) {
        this.variantId = variantId;
        this.product = productId;
        this.size = size;
        this.color = color;
        this.quantity = quantity;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
