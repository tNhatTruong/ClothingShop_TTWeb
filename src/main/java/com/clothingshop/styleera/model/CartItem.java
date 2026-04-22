package com.clothingshop.styleera.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class CartItem implements Serializable {
    private int cartItemId;
    private User user;
    private Variants variant;
    private int quantity;
    private Timestamp created_at;
    private Timestamp updated_at;

    public CartItem() {
    }

    public CartItem(int cartItemId, User user, Variants variant, int quantity, Timestamp created_at, Timestamp updated_at) {
        this.cartItemId = cartItemId;
        this.user = user;
        this.variant = variant;
        this.quantity = quantity;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }
    public CartItem(Variants variant, int quantity) {
        this.variant = variant;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Variants getVariant() {
        return variant;
    }

    public void setVariant(Variants variant) {
        this.variant = variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public double getTotalPrice(){
        if(variant != null){
            return variant.getProduct().getPrice() * this.getQuantity();
        }
        return 0;
    }
    public void addQuantity(int quantity){
        this.quantity += quantity;
    }
}


