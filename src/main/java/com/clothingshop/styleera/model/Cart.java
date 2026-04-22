package com.clothingshop.styleera.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart {
    Map<Integer, CartItem> items;
    private User user;
    public Cart() {
        items = new HashMap<>();
    }

    public void addItem(Variants variants, int quantity) {
        if(quantity <=0) quantity = 1;
        int variantId = variants.getVariantId();

        if(items.containsKey(variantId)){
            items.get(variantId).addQuantity(quantity);
        }else{
            items.put(variantId, new CartItem(variants, quantity));
        }
    }
    public boolean updateItem(int variantId, int quantity) {
        CartItem item = items.get(variantId);
        if(item == null) return false;
        if(quantity <= 0) quantity = 1;
        item.setQuantity(quantity);
        return true;
    }
    public CartItem removeItem(int variantId){
        if(items.get(variantId)==null){
            return null;
        }
        return items.remove(variantId);
    }
    public List<CartItem> removeAllItem(){
        ArrayList<CartItem> cartItems = new ArrayList<>(items.values());
        items.clear();
        return cartItems;
    }
    public List<CartItem> getItem(){
        return new ArrayList<>(items.values());
    }
    public int getTotalQuantity(){
        AtomicInteger total = new AtomicInteger();
        getItem().forEach(item ->{
            total.addAndGet(item.getQuantity());
        });
        return total.get();
    }
    public double total(){
        AtomicReference<Double> total = new AtomicReference<>((double)0);
        getItem().forEach(item ->{
            total.updateAndGet(v -> v + (item.getQuantity() * item.getVariant().getProduct().getPrice()));
        });
        return total.get();
    }
    public void updateCustomer(User user){
        this.user = user;
    }
}
