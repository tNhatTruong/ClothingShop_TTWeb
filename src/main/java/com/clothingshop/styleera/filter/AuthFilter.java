package com.clothingshop.styleera.filter;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.util.List;

// Áp dụng cho TẤT CẢ các request
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String lowerPath = path.toLowerCase();

        if (lowerPath.contains("/uploads/") ||
                lowerPath.contains("/images/") ||
                lowerPath.endsWith(".css") ||
                lowerPath.endsWith(".js") ||
                lowerPath.endsWith(".png") ||
                lowerPath.endsWith(".jpg") ||
                lowerPath.endsWith(".jpeg") ||
                lowerPath.endsWith(".webp") ||
                lowerPath.endsWith(".gif")) {

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

        // 3. Logic kiểm tra Session và tự động đăng nhập bằng Remember Me Token
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("auth") != null);

        if (!isLoggedIn) {
            Cookie[] cookies = req.getCookies();
            String rememberToken = null;
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("remember_token".equals(c.getName())) {
                        rememberToken = c.getValue();
                        break;
                    }
                }
            }

            if (rememberToken != null && !rememberToken.isEmpty()) {
                try {
                    com.clothingshop.styleera.service.UserTokenService tokenService = new com.clothingshop.styleera.service.UserTokenService();
                    com.clothingshop.styleera.model.UserToken ut = tokenService.findByToken(rememberToken);
                    if (ut != null) {
                        com.clothingshop.styleera.dao.UserDAO userDAO = new com.clothingshop.styleera.dao.UserDAO();
                        User user = userDAO.findById(ut.getUserId());
                        if (user != null && user.getEnabled() == 1 && !"BANNED".equalsIgnoreCase(user.getStatus())) {
                            user.setPassword_hash(null); // tẩy rửa mật khẩu bảo mật
                            
                            // Tạo session mới và set thuộc tính đăng nhập
                            session = req.getSession(true);
                            session.setAttribute("auth", user);
                            session.setAttribute("currentUser", user);
                            session.setMaxInactiveInterval(30 * 60);

                            // Load giỏ hàng từ DB
                            com.clothingshop.styleera.dao.CartDao cartDao = new com.clothingshop.styleera.dao.CartDao();
                            List<com.clothingshop.styleera.model.CartItem> dbCartItems = cartDao.getCartItems(user.getId());
                            com.clothingshop.styleera.model.Cart cart = new com.clothingshop.styleera.model.Cart();
                            if (dbCartItems != null && !dbCartItems.isEmpty()) {
                                cart.loadFromList(dbCartItems);
                            }
                            session.setAttribute("cart", cart);

                            isLoggedIn = true;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

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