package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.CartItem;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String referer = request.getHeader("Referer");
        // Lưu trang trước đó để sau khi đăng nhập xong thì quay lại
        if (referer != null && !referer.contains("/login") && !referer.contains("/register") && !referer.contains("/verify") && !referer.contains("/reset-password")) {
            session.setAttribute("returnUrl", referer);
        }

        String errorParam = request.getParameter("error");
        if ("banned".equalsIgnoreCase(errorParam)) {
            request.setAttribute("errorMsg", "Tài khoản của bạn đã bị khóa do vi phạm chính sách.");
        }
        
        request.getRequestDispatcher("/views/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email);

        // 1. Kiểm tra đăng nhập
        if (user != null && PasswordUtils.checkPassword(pass, user.getPassword_hash())) {

            // 2. Nếu đúng pass, kiểm tra kích hoạt
            if (user.getEnabled() == 0) {
                request.setAttribute("error", "Tài khoản chưa được kích hoạt! Vui lòng nhập mã xác thực.");
                request.setAttribute("email", email);
                // Chuyển sang trang verify.jsp để nhập mã (Đúng logic)
                request.getRequestDispatcher("views/pages/verify.jsp").forward(request, response);
                return;
            }

            // 2.5 Kiểm tra tài khoản bị khóa
            if ("BANNED".equalsIgnoreCase(user.getStatus())) {
                request.setAttribute("errorMsg", "Tài khoản của bạn đã bị khóa do vi phạm chính sách.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/views/pages/login.jsp").forward(request, response);
                return;
            }

            // 3. Đăng nhập thành công
            // 30 phút * 60 giây = 1800 giây
            // Nếu user không làm gì trong 30p, server tự hủy session này.
            user.setPassword_hash(null); // Tẩy rửa mật khẩu băm để tránh rò rỉ dữ liệu nhạy cảm
            HttpSession session = request.getSession();
            session.setAttribute("auth", user);
            session.setAttribute("currentUser", user);
            session.setMaxInactiveInterval(30 * 60);

            // Gộp giỏ hàng khách (nếu có) vào CSDL
            CartDao cartDao = new CartDao();
            Cart guestCart = (Cart) session.getAttribute("cart");
            if (guestCart != null && !guestCart.getItem().isEmpty()) {
                for (CartItem item : guestCart.getItem()) {
                    cartDao.saveOrUpdateCartItem(user.getId(), item.getVariant().getVariantId(), item.getQuantity());
                }
            }

            // Tải lại toàn bộ giỏ hàng từ CSDL (đã bao gồm đồ của khách)
            List<CartItem> dbCartItems = cartDao.getCartItems(user.getId());

            Cart cart = new Cart();
            if (dbCartItems != null && !dbCartItems.isEmpty()) {
                cart.loadFromList(dbCartItems);
            }

            session.setAttribute("cart", cart);

            // 4. Cookie và Remember Me Token
            if (remember != null) {
                String token = java.util.UUID.randomUUID().toString();
                java.sql.Timestamp expiryDate = new java.sql.Timestamp(System.currentTimeMillis() + 30L * 24 * 60 * 60 * 1000); // 30 ngày
                com.clothingshop.styleera.service.UserTokenService tokenService = new com.clothingshop.styleera.service.UserTokenService();
                tokenService.saveToken(user.getId(), token, expiryDate);

                Cookie cRemember = new Cookie("remember_token", token);
                cRemember.setMaxAge(30 * 24 * 60 * 60); // 30 ngày
                cRemember.setPath("/");
                cRemember.setHttpOnly(true); // Tăng bảo mật chống XSS
                response.addCookie(cRemember);
            } else {
                Cookie cRemember = new Cookie("remember_token", "");
                cRemember.setMaxAge(0);
                cRemember.setPath("/");
                response.addCookie(cRemember);
            }

            Cookie cEmail = new Cookie("c_user", remember != null ? email : "");
            cEmail.setMaxAge(remember != null ? 30 * 24 * 60 * 60 : 0);
            cEmail.setPath("/");
            response.addCookie(cEmail);

            // 5. Chuyển hướng
            String returnUrl = (String) session.getAttribute("returnUrl");
            session.removeAttribute("returnUrl"); // Xóa sau khi dùng

            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/AdminDashboard");
            } else if (returnUrl != null && !returnUrl.isEmpty()) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } else {
            // Nếu sai Email/Pass -> Quay lại trang LOGIN (login.jsp) chứ KHÔNG PHẢI verify.jsp
            request.setAttribute("errorMsg", "Sai tài khoản hoặc mật khẩu!");
            // Giữ lại email để người dùng không phải nhập lại
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/pages/login.jsp").forward(request, response);
        }
    }
}