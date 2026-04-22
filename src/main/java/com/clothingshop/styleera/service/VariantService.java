package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.Variants;

public class VariantService {
    private VariantDAO variantDAO = new VariantDAO();
    public Variants getById(int id){
        return variantDAO.getById(id);
    }
    public Integer getDefaultVariantId(int productId){
        return variantDAO.getDefaultVariantId(productId);
    }
    public int getTotalQuantity() {
        return variantDAO.getTotalQuantity();
    }
}
