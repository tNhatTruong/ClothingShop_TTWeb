package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.CartItem;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.stream.Collectors;

public class CartDao {
    public List<CartItem> getCartItems(int userId){
        Jdbi jdbi = JDBIConnector.getJdbi();
        List<CartItem> cart = jdbi.withHandle(handle -> {
            String sql = "SELECT \n" +
                    "    ci.cart_item_id as cartItemId,\n" +
                    "    ci.user_id as userId,\n" +
                    "    v.variant_id as variantId,\n" +
                    "    p.product_name as productName,\n" +
                    "    p.price,\n" +
                    "    ci.quantity,\n" +
                    "    (p.price * ci.quantity) as totalPrice,\n" +
                    "    img.path as imageUrl\n" +
                    "FROM CartItem ci\n" +
                    "JOIN Variants v ON ci.variant_id = v.variant_id\n" +
                    "JOIN Products p ON v.product_id = p.product_id\n" +
                    "LEFT JOIN Images img ON img.product_id = p.product_id\n" +
                    "WHERE ci.user_id = ?\n" +
                    "ORDER BY ci.updated_at DESC\n";
            return handle.createQuery(sql).bind(0, userId).mapToBean(CartItem.class).stream().collect(Collectors.toList());
        });

        return cart;

    }


}
