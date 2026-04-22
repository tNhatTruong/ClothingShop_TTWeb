package com.clothingshop.styleera.model;

import java.util.List;

public class ParentCategory {
    private int id;
    private String name;
    private List<SubCategory> subCategories;
    // thêm tính tổng % danh mục cho trang admin dashboard
    private int totalProduct;
    private double percent;

    public ParentCategory() {
    }

    public ParentCategory(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters/Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<SubCategory> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<SubCategory> subCategories) {
        this.subCategories = subCategories;
    }
    public int getTotalProduct() {
        return totalProduct;
    }

    public void setTotalProduct(int totalProduct) {
        this.totalProduct = totalProduct;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }
}
