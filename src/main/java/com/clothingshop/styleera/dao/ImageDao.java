package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Image;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class ImageDao {

    // 1. Tìm chính xác TẤT CẢ ẢNH của RIÊNG sản phẩm được chọn
    public List<Image> findByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id AS imageId, image_name AS imageName, path AS imagePath " +
                    "FROM images WHERE product_id = :productId";
            return handle.createQuery(sql)
                    .bind("productId", productId)
                    .mapToBean(Image.class)
                    .list();
        });
    }

    // 2. Tìm ảnh theo ID ảnh
    public List<Image> findById(int imageId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id AS imageId, image_name AS imageName, path AS imagePath " +
                    "FROM images WHERE id = :imageId";
            return handle.createQuery(sql)
                    .bind("imageId", imageId)
                    .mapToBean(Image.class)
                    .list();
        });
    }
}