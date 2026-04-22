package com.clothingshop.styleera.model;

import java.sql.Timestamp;

public class Image {
    private int imageId;
    private Product product;
    private String imageName;
    private String imagePath;
    private Timestamp updated_at;

    public Image() {
    }

    public Image(int imageId, Product product, String imageName, String imagePath, Timestamp updated_at) {
        this.imageId = imageId;
        this.product = product;
        this.imageName = imageName;
        this.imagePath = imagePath;
        this.updated_at = updated_at;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
}
