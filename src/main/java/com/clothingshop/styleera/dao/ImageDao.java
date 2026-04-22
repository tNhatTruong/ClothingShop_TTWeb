package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Image;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class ImageDao {

    // 1. Tìm tất cả ảnh của một sản phẩm (Dùng cho album ảnh)
    public List<Image> findByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id AS imageId, image_name AS imageName, path AS imagePath " +
                    "FROM images WHERE product_id = ?";
            return handle.createQuery(sql)
                    .bind(0, productId)
                    .mapToBean(Image.class)
                    .list();
        });
    }

    // 2. Tìm ảnh theo ID ảnh (Phương thức bạn đang bị thiếu)
    public List<Image> findById(int imageId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id AS imageId, image_name AS imageName, path AS imagePath " +
                    "FROM images WHERE id = ?";
            return handle.createQuery(sql)
                    .bind(0, imageId)
                    .mapToBean(Image.class)
                    .list();
        });
    }
}