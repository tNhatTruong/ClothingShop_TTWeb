package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.model.Variants;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class VariantDAO {
    // Lấy danh sách các Size duy nhất đang có
    public List<String> getAllSizes() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT DISTINCT size FROM variants ORDER BY size")
                        .mapTo(String.class)
                        .list()
        );
    }

    // Lấy danh sách các Màu duy nhất đang có
    public List<String> getAllColors() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT DISTINCT color FROM variants ORDER BY color")
                        .mapTo(String.class)
                        .list()
        );
    }
    public Variants getById(int variantId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        String sql = "SELECT v.id AS variant_id,\n" +
                "            v.size,\n" +
                "            v.color,\n" +
                "            v.quantity AS variant_quantity,\n" +
                "            p.id AS product_id,\n" +
                "            p.product_name,\n" +
                "            p.price,\n" +
                "            i.path AS thumbnail\n" +
                "        FROM variants v\n" +
                "        JOIN products p ON v.product_id = p.id\n" +
                "        LEFT JOIN images i ON p.image_id = i.id\n" +
                "        WHERE v.id = :variantId";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("variantId", variantId)
                        .map((rs, ctx) -> {
                            // Tạo Product object từ kết quả query
                            Product product = new Product();
                            product.setProduct_id(rs.getInt("product_id"));
                            product.setProduct_name(rs.getString("product_name"));
                            product.setPrice(rs.getDouble("price"));
                            product.setThumbnail(rs.getString("thumbnail"));

                            // Tạo Variants object
                            Variants variant = new Variants();
                            variant.setVariantId(rs.getInt("variant_id"));
                            variant.setSize(rs.getString("size"));
                            variant.setColor(rs.getString("color"));
                            variant.setQuantity(rs.getInt("variant_quantity"));
                            variant.setProduct(product);

                            return variant;
                        })
                        .findOne()
                        .orElse(null)
        );
    }
    public Integer getDefaultVariantId(int productId){
        Jdbi jdbi = JDBIConnector.getJdbi();
        String sql = "SELECT id\n" +
                "        FROM variants\n" +
                "        WHERE product_id = :productId\n" +
                "          AND quantity > 0\n" +
                "        ORDER BY \n" +
                "            CASE WHEN size = 'M' THEN 0 ELSE 1 END,\n" +
                "            id\n" +
                "        LIMIT 1";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(null));
    }
    public List<String> getColorsByProductId(int product_id) { // Đổi tên tham số ở đây
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                // Sử dụng product_id cho cả tên cột và tên biến bind
                handle.createQuery("SELECT DISTINCT color FROM variants WHERE product_id = :product_id")
                        .bind("product_id", product_id)
                        .mapTo(String.class)
                        .list()
        );

    }
    // tính tổng quantity trong thống kê dashboard admin
    public int getTotalQuantity() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT SUM(quantity) FROM variants")
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }

    public List<String> getSizesByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT DISTINCT size FROM variants WHERE product_id = :productId")
                        .bind("productId", productId)
                        .mapTo(String.class)
                        .list()
        );
    }

    public List<Variants> getVariantsByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        String sql = "SELECT id AS variant_id, " +
                "       size, " +
                "       color, " +
                "       quantity AS variant_quantity " +
                "FROM variants " +
                "WHERE product_id = :productId";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .map((rs, ctx) -> {
                            Variants variant = new Variants();
                            variant.setVariantId(rs.getInt("variant_id"));
                            variant.setSize(rs.getString("size"));
                            variant.setColor(rs.getString("color"));
                            variant.setQuantity(rs.getInt("variant_quantity"));
                            return variant;
                        })
                        .list()
        );
    }
    public boolean updateStock(int variantId, int quantityToSubtract) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            int updatedRows = handle.createUpdate("UPDATE variants SET quantity = quantity - :quantity " +
                    "WHERE id = :variantId AND quantity >= :quantity")
                    .bind("quantity", quantityToSubtract)
                    .bind("variantId", variantId)
                    .execute();
            return updatedRows > 0;
        });
    }
    public boolean restoreStock(int variantId, int quantityToAdd) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            int updatedRows = handle.createUpdate("UPDATE variants SET quantity = quantity + :quantity WHERE id = :variantId")
                    .bind("quantity", quantityToAdd)
                    .bind("variantId", variantId)
                    .execute();
            return updatedRows > 0;
        });
    }

    public List<Variants> searchVariantsByKeyword(String keyword) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        String sql = "SELECT v.id AS variant_id, v.size, v.color, v.quantity AS variant_quantity, " +
                "p.id AS product_id, p.product_name, p.price, i.path AS thumbnail " +
                "FROM variants v " +
                "JOIN products p ON v.product_id = p.id " +
                "LEFT JOIN images i ON p.image_id = i.id " +
                "WHERE p.product_name LIKE :keyword OR p.id = :exactId " +
                "ORDER BY p.product_name, v.size, v.color LIMIT 20";

        // Try to parse exactId in case user typed a product ID
        int exactId = -1;
        try {
            exactId = Integer.parseInt(keyword);
        } catch (Exception ignored) {}

        final int finalExactId = exactId;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("keyword", "%" + keyword + "%")
                        .bind("exactId", finalExactId)
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setProduct_id(rs.getInt("product_id"));
                            product.setProduct_name(rs.getString("product_name"));
                            product.setPrice(rs.getDouble("price"));
                            product.setThumbnail(rs.getString("thumbnail"));

                            Variants variant = new Variants();
                            variant.setVariantId(rs.getInt("variant_id"));
                            variant.setSize(rs.getString("size"));
                            variant.setColor(rs.getString("color"));
                            variant.setQuantity(rs.getInt("variant_quantity"));
                            variant.setProduct(product);

                            return variant;
                        })
                        .list()
        );
    }
}
