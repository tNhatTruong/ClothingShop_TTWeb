package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.Variants;

import java.util.List;

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
    public List<Variants> getVariantsByProductId(int productId) {
        VariantDAO variantDAO = new VariantDAO();
        return variantDAO.getVariantsByProductId(productId);
    }
    public int countLowStockVariants(int threshold) {
        return variantDAO.countLowStockVariants(threshold);
    }
    public List<Variants> getLowStockVariants(int threshold, int limit) {
        return variantDAO.getLowStockVariants(threshold, limit);
    }
}
