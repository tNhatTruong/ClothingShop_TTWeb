package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.CartItem;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.model.Variants;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CartDao {
    public List<CartItem> getCartItems(int userId){
        Jdbi jdbi = JDBIConnector.getJdbi();
        List<CartItem> cart = jdbi.withHandle(handle -> {
            String sql = "SELECT \n" +
                    "    ci.id as cartItemId,\n" +
                    "    ci.user_id as userId,\n" +
                    "    v.id as variantId,\n" +      // <--- Sửa 1: v.variant_id thành v.id (hoặc tên đúng trong DB)
                    "    v.color as color,\n" +
                    "    v.size as size,\n" +
                    "    p.product_name as productName,\n" +
                    "    p.price,\n" +
                    "    ci.quantity,\n" +
                    "    (p.price * ci.quantity) as totalPrice,\n" +
                    "    img.path as imageUrl\n" +
                    "FROM cartitem ci\n" +
                    // Sửa 2: Chỗ ON cũng phải sửa cho đúng tên cột của cả 2 bảng
                    "JOIN variants v ON ci.variant_id = v.id\n" +
                    "JOIN products p ON v.product_id = p.id\n" +  // Chú ý: Cả p.product_id có thể cũng chỉ là p.id thôi
                    "LEFT JOIN images img ON img.product_id = p.id\n" +
                    "WHERE ci.user_id = ?\n" +
                    "ORDER BY ci.updated_at DESC\n";
            // Trong file CartDao.java
            return handle.createQuery(sql)
                    .bind(0, userId)
                    .map((rs, ctx) -> {
                        // 1. Tạo đối tượng Product và nhét dữ liệu
                        // Lưu ý: Đổi tên setter cho đúng với class Product của bạn nhé
                        Product product = new Product();
                        product.setProduct_name(rs.getString("productName"));
                        product.setPrice(rs.getDouble("price"));
                        product.setThumbnail(rs.getString("imageUrl"));

                        // 2. Tạo đối tượng Variant và nhét Product vào
                        Variants variant = new Variants();
                        variant.setVariantId(rs.getInt("variantId"));
                        variant.setColor(rs.getString("color"));
                        variant.setSize(rs.getString("size"));
                        variant.setProduct(product);

                        // 3. Tạo CartItem và nhét Variant vào
                        CartItem cartItem = new CartItem();
                        cartItem.setCartItemId(rs.getInt("cartItemId"));
                        cartItem.setQuantity(rs.getInt("quantity"));
                        cartItem.setVariant(variant);

                        return cartItem;
                    })
                    .list(); // Lấy ra danh sách
        });

        return cart;

    }

    // Thêm hàm này vào CartDao.java
    public void saveOrUpdateCartItem(int userId, int variantId, int quantity) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            // 1. Kiểm tra xem sản phẩm này đã có trong giỏ hàng của user chưa
            int count = handle.createQuery("SELECT count(*) FROM cartitem WHERE user_id = ? AND variant_id = ?")
                    .bind(0, userId)
                    .bind(1, variantId)
                    .mapTo(Integer.class)
                    .one();

            if (count > 0) {
                // 2. Nếu có rồi -> Cập nhật cộng dồn số lượng
                String sqlUpdate = "UPDATE cartitem SET quantity = quantity + ? WHERE user_id = ? AND variant_id = ?";
                handle.createUpdate(sqlUpdate)
                        .bind(0, quantity)
                        .bind(1, userId)
                        .bind(2, variantId)
                        .execute();
            } else {
                // 3. Nếu chưa có -> Thêm mới vào bảng
                // Lưu ý: Kiểm tra lại tên cột (user_id, variant_id, quantity) cho khớp với DB của bạn
                String sqlInsert = "INSERT INTO cartitem (user_id, variant_id, quantity) VALUES (?, ?, ?)";
                handle.createUpdate(sqlInsert)
                        .bind(0, userId)
                        .bind(1, variantId)
                        .bind(2, quantity)
                        .execute();
            }
        });
    }

    public void removeCartItem(int userId, int variantId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sqlDelete = "DELETE FROM cartitem WHERE user_id = ? AND variant_id = ?";
            handle.createUpdate(sqlDelete)
                    .bind(0, userId)
                    .bind(1, variantId)
                    .execute();
        });
    }

    public void updateCartItemQuantity(int userId, int variantId, int newQuantity) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sqlUpdate = "UPDATE cartitem SET quantity = ? WHERE user_id = ? AND variant_id = ?";
            handle.createUpdate(sqlUpdate)
                    .bind(0, newQuantity)
                    .bind(1, userId)
                    .bind(2, variantId)
                    .execute();
        });
    }
}
