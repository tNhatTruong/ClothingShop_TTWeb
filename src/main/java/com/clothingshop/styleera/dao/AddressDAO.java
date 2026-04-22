package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Address;
import org.jdbi.v3.core.Jdbi;

import java.util.Optional;

public class AddressDAO {

    // 1. Lấy địa chỉ mặc định của User
    public Address findAddressByUserId(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, id DESC LIMIT 1")
                        .bind(0, userId)
                        .mapToBean(Address.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // 2. Lưu hoặc Cập nhật địa chỉ
    public void saveOrUpdate(int userId, String street, String province, String district) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {

            String selectSql = "SELECT id FROM addresses WHERE user_id = ? ORDER BY is_default DESC, id DESC LIMIT 1";

            Optional<Integer> existId = handle.createQuery(selectSql)
                    .bind(0, userId)
                    .mapTo(Integer.class)
                    .findOne();

            if (existId.isPresent()) {
                // UPDATE
                String updateSql = "UPDATE addresses SET street = ?, province = ?, district = ? WHERE id = ?";
                handle.createUpdate(updateSql)
                        .bind(0, street)
                        .bind(1, province)
                        .bind(2, district)
                        .bind(3, existId.get())
                        .execute();
            } else {
                // INSERT
                String insertSql = "INSERT INTO addresses (user_id, street, province, district, is_default) VALUES (?, ?, ?, ?, 1)";
                handle.createUpdate(insertSql)
                        .bind(0, userId)
                        .bind(1, street)
                        .bind(2, province)
                        .bind(3, district)
                        .execute();
            }
        });
    }
}