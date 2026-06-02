package com.clothingshop.styleera.filter;

import com.clothingshop.styleera.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {
        "/admin/*",
        "/AdminDashboard",
        "/admin-products",
        "/AdminAddProduct",
        "/AdminEditProduct",
        "/AdminDeleteProduct",
        "/admin-category",
        "/AdminDeleteCategory",
        "/admin-user",
        "/admin-contact",
        "/AdminEditUser",
        "/AdminDeleteUser",
        "/admin-profile",
        "/admin-orders"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        // 1. Cho phép truy cập tự do các tài nguyên tĩnh (css, js, ảnh)
        if (path.endsWith(".css") || path.endsWith(".js") ||
                path.endsWith(".png") || path.endsWith(".jpg") || path.endsWith(".jpeg") ||
                path.endsWith(".gif") || path.endsWith(".avif") || path.endsWith(".svg") ||
                path.endsWith(".ico") || path.endsWith(".woff2") || path.endsWith(".woff")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Lấy User từ HttpSession
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("auth") : null;

        // 3. Kiểm tra quyền Admin
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            // Chưa đăng nhập hoặc không phải là Admin -> redirect về trang login
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Tắt cache để bảo mật tuyệt đối cho khu vực Admin
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }
}
