package com.clothingshop.styleera.model;

public class SubCategory {
    private int id;
    private String name;
    private int parentCategoryId;
    private String image;
    private String description;
    private ParentCategory category;

    public SubCategory() {
    }

    public SubCategory(int id, String name, int parentCategoryId, String image, String description) {
        this.id = id;
        this.name = name;
        this.parentCategoryId = parentCategoryId;
        this.image = image;
        this.description = description;
    }
    public ParentCategory getCategory() {
        return category;
    }

    public void setCategory(ParentCategory category) {
        this.category = category;
    }

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

    public int getParentCategoryId() {
        return parentCategoryId;
    }

    public void setParentCategoryId(int parentCategoryId) {
        this.parentCategoryId = parentCategoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
