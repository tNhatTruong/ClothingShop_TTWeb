package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Google;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.GoogleUtils;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.CartItem;
import java.util.List;

@WebServlet(urlPatterns = {"/login-google", "/StyleEra/login-google"})
public class GoogleLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        // Nếu người dùng nhấn "Hủy" hoặc không có mã code trả về
        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login?error=GoogleLoginFailed");
            return;
        }

        try {
            // 1. Dùng code lấy Access Token từ Google
            GoogleUtils googleUtils = new GoogleUtils();
            String accessToken = googleUtils.getToken(code);

            // 2. Dùng Access Token lấy thông tin User (Email, ID, Tên...)
            Google googleUser = googleUtils.getUserInfo(accessToken);

            // 3. Kiểm tra User trong DB
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmail(googleUser.getEmail());

            if (user == null) {
                // === TRƯỜNG HỢP 1: NGƯỜI DÙNG MỚI (Chưa có trong DB) ===
                user = new User();
                user.setEmail(googleUser.getEmail());
                user.setUser_name(googleUser.getName()); // Lấy tên từ Google
                user.setRole("User");
                user.setStatus("Hoạt Động");
                user.setEnabled(1); // Google đã xác thực nên kích hoạt luôn
                user.setGoogle_id(googleUser.getId());

                // Mật khẩu để trống hoặc random vì đăng nhập qua Google không cần pass
                // user.setPassword_hash("");

                // Lưu vào DB
                userDAO.registerUserGoogle(user);

                // Quan trọng: Lấy lại User từ DB để có ID tự tăng (dùng cho các chức năng khác)
                user = userDAO.findByEmail(googleUser.getEmail());

            } else {
                // === TRƯỜNG HỢP 2: ĐÃ CÓ TÀI KHOẢN (Trùng Email) ===
                // Nếu tài khoản cũ chưa có Google ID -> Cập nhật thêm vào
                if (user.getGoogle_id() == null || user.getGoogle_id().isEmpty()) {
                    userDAO.updateGoogleId(user.getEmail(), googleUser.getId());

                    // Cập nhật luôn vào object user hiện tại để lưu Session cho đúng
                    user.setGoogle_id(googleUser.getId());
                }
            }

            // 3.5 Kiểm tra tài khoản bị khóa
            if ("BANNED".equalsIgnoreCase(user.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/login?error=banned");
                return;
            }

            // 4. Tạo Session Đăng nhập
            user.setPassword_hash(null); // Tẩy rửa mật khẩu băm để tránh rò rỉ dữ liệu nhạy cảm
            HttpSession session = request.getSession();
            session.setAttribute("auth", user);

            // Set thời gian hết hạn session (30 phút - giống Login thường)
            session.setMaxInactiveInterval(30 * 60);

            // === Gộp giỏ hàng khách (nếu có) vào CSDL ===
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

            // 5. Chuyển hướng về trang chủ hoặc trang trước đó
            String returnUrl = (String) session.getAttribute("returnUrl");
            session.removeAttribute("returnUrl"); // Xóa sau khi dùng

            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            } else if (returnUrl != null && !returnUrl.isEmpty()) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi hệ thống, chuyển về login và báo lỗi
            response.sendRedirect(request.getContextPath() + "/login?error=SystemError");
        }
    }
}