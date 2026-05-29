package com.clothingshop.styleera.filter;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Áp dụng cho TẤT CẢ các request
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        // 1. Bỏ qua các tài nguyên tĩnh (CSS, JS, Ảnh) để web chạy nhanh
        if (path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".jpg")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Xác định các trang CẦN BẢO VỆ (Phải đăng nhập mới được vào)
        // Bạn có thể thêm các trang khác vào danh sách này
        boolean isProtectedPage = path.contains("/account.jsp") ||
                path.contains("/checkout.jsp") ||
                path.contains("/order-history.jsp") ||
                path.contains("/order_status.jsp") ||
                path.contains("/order_success.jsp");

        // 3. Logic kiểm tra Session
        HttpSession session = req.getSession(false); // false: Chỉ lấy session cũ, không tạo mới
        boolean isLoggedIn = (session != null && session.getAttribute("auth") != null);

        // 3.5 Kiểm tra nếu đã đăng nhập và bị khóa thì hủy session lập tức
        if (isLoggedIn) {
            User sessionUser = (User) session.getAttribute("auth");
            boolean isAuthPath = path.contains("/login") || path.contains("/logout") || path.contains("/register") || path.contains("/verify");
            if (!isAuthPath) {
                UserDAO userDAO = new UserDAO();
                User latestUser = userDAO.findByEmail(sessionUser.getEmail());
                if (latestUser != null && "BANNED".equalsIgnoreCase(latestUser.getStatus())) {
                    session.invalidate();
                    res.sendRedirect(req.getContextPath() + "/login?error=banned");
                    return;
                }
            }
        }

        // 3.6 Phân quyền cho toàn bộ hệ thống Admin (Bảo vệ tất cả trang admin)
        boolean isAdminPage = path.contains("/admin/") ||
                path.contains("/AdminDashboard") ||
                path.contains("/admin-products") ||
                path.contains("/AdminAddProduct") ||
                path.contains("/AdminEditProduct") ||
                path.contains("/AdminDeleteProduct") ||
                path.contains("/admin-category") ||
                path.contains("/AdminDeleteCategory") ||
                path.contains("/admin-user") ||
                path.contains("/admin-contact") ||
                path.contains("/AdminEditUser");

        // Loại trừ trang login của admin
        if (path.contains("/admin/admin-login.jsp") || path.contains("/AdminLogin")) {
            isAdminPage = false;
        }

        if (isAdminPage) {
            if (!isLoggedIn) {
                // Nếu chưa đăng nhập -> Chuyển về trang login admin
                res.sendRedirect(req.getContextPath() + "/admin/admin-login.jsp");
                return;
            } else {
                User sessionUser = (User) session.getAttribute("auth");
                if (!"Admin".equalsIgnoreCase(sessionUser.getRole())) {
                    // Nếu đã đăng nhập nhưng không phải Admin -> Báo lỗi 403
                    res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập vào khu vực Quản trị viên.");
                    return;
                }
                // Nếu là Admin hợp lệ -> Tắt cache để bảo mật
                disableCache(res);
            }
        }

        if (isProtectedPage) {
            if (!isLoggedIn) {
                // A. Nếu chưa đăng nhập mà cố vào trang bảo mật -> Đá về Login
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            } else {
                // B. Nếu đã đăng nhập -> Chặn Cache để khi Logout không Back lại được
                disableCache(res);
            }
        }

        // 4. Logic cho trang Login/Register (Nếu đã đăng nhập thì không cho vào lại
        // trang login nữa)
        boolean isAuthPage = path.contains("/login.jsp") || path.contains("/register.jsp");
        if (isAuthPage && isLoggedIn) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 5. Logic cho trang Reset Password
        // Trang này cho phép vào nếu: (Đã đăng nhập) HOẶC (Đang trong quy trình Quên
        // mật khẩu hợp lệ)
        if (path.contains("/reset-password.jsp")) {
            String verifyType = (session != null) ? (String) session.getAttribute("verifyType") : null;
            boolean isResetFlow = "RESET_PASSWORD".equals(verifyType);

            // Nếu KHÔNG phải user đang đăng nhập VÀ KHÔNG phải đang reset pass từ email
            if (!isLoggedIn && !isResetFlow) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            // Nếu được phép vào thì cũng chặn cache
            disableCache(res);
        }

        // Cho phép đi tiếp
        chain.doFilter(request, response);
    }

    private void disableCache(HttpServletResponse res) {
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);
    }
}