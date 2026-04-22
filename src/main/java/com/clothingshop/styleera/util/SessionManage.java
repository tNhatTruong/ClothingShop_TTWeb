package com.clothingshop.styleera.util;

import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionManage {

    // 1. Lấy User đang đăng nhập (Tránh việc phải ép kiểu (User) thủ công nhiều lần)
    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // false: không tạo mới nếu chưa có
        if (session != null && session.getAttribute("auth") != null) {
            return (User) session.getAttribute("auth");
        }
        return null;
    }

    // 2. Kiểm tra xem đã đăng nhập chưa
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }

    // 3. Kiểm tra xem có phải là Admin không
    public static boolean isAdmin(HttpServletRequest request) {
        User user = getCurrentUser(request);
        // Giả sử trong DB role bạn lưu là "Admin" hoặc "admin"
        return user != null && "Admin".equalsIgnoreCase(user.getRole());
    }

    // 4. Lấy Giỏ hàng hiện tại (Nếu chưa có thì tự tạo mới - dùng cho AddCart)
    public static Cart getCart(HttpServletRequest request) {
        HttpSession session = request.getSession(true); // true: chưa có thì tạo mới
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // 5. Đăng xuất (Xóa sạch Session)
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}