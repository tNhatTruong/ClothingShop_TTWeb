package com.clothingshop.styleera.model;

import java.io.Serializable;

public class Address implements Serializable {
    private int id;
    private int userId;
    private String street;   // Số nhà, tên đường
    private String province; // Tỉnh/Thành phố
    private String district; // Quận/Huyện
    private int isDefault;   // 1 là mặc định, 0 là thường

    public Address() {
    }

    public Address(int userId, String street, String province, String district) {
        this.userId = userId;
        this.street = street;
        this.province = province;
        this.district = district;
        this.isDefault = 1; // Mặc định là 1 khi tạo mới từ trang Account
    }

    // --- GETTER & SETTER ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getStreet() { return street; }
    public void setStreet(String street) { this.street = street; }
    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }
    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }
    public int getIsDefault() { return isDefault; }
    public void setIsDefault(int isDefault) { this.isDefault = isDefault; }
}