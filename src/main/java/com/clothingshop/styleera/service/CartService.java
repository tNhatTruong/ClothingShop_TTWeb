package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.model.CartItem;

import java.util.List;

public class CartService {
    private CartDao cartDao = new CartDao();
    public List<CartItem> findById(int id){
        return cartDao.getCartItems(id);

    }
}
