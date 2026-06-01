package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UserDAO {

    // 1. Đăng ký user kèm mã OTP
    public void registerUser(User user, String otpCode) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "INSERT INTO users (user_name, email, password_hash, phone, role, status, verification_code, enabled) " +
                    "VALUES (?, ?, ?, ?, 'User', 'Hoạt Động', ?, 0)";
            handle.createUpdate(sql)
                    .bind(0, user.getUser_name())
                    .bind(1, user.getEmail())
                    .bind(2, user.getPassword_hash())
                    .bind(3, user.getPhone())
                    .bind(4, otpCode)
                    .execute();
        });
    }

    // 2. Kiểm tra OTP có đúng không (Hỗ trợ master OTP '123456' để test cục bộ)
    public boolean checkOtp(String email, String inputOtp) {
        if ("123456".equals(inputOtp)) {
            return findByEmail(email) != null;
        }
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND verification_code = ?";
            int count = handle.createQuery(sql)
                    .bind(0, email)
                    .bind(1, inputOtp)
                    .mapTo(Integer.class)
                    .one();
            return count > 0;
        });
    }

    // 3. Kích hoạt tài khoản (Xóa OTP, set enabled=1)
    public void activeUser(String email) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET enabled = 1, verification_code = NULL WHERE email = ?";
            handle.createUpdate(sql).bind(0, email).execute();
        });
    }

    // 4. Tìm User theo Email (Dùng cho login & check trùng)
    public User findByEmail(String email) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE email = ?")
                        .bind(0, email)
                        .mapToBean(User.class)
                        .findOne().orElse(null)
        );
    }

    // 5. Lưu user không cần mật khẩu
    public void registerUserGoogle(User user) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "INSERT INTO users (user_name, email, role, status, enabled, google_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            handle.createUpdate(sql)
                    .bind(0, user.getUser_name())
                    .bind(1, user.getEmail())
                    .bind(2, "User")
                    .bind(3, "Hoạt Động")
                    .bind(4, 1) // Google đã xác thực nên enable luôn
                    .bind(5, user.getGoogle_id())
                    .execute();
        });
    }

    // 6. Lưu verification_code
    public void updateOtp(String email, String otp) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            // Cập nhật mã OTP mới cho email tương ứng
            String sql = "UPDATE users SET verification_code = ? WHERE email = ?";
            handle.createUpdate(sql)
                    .bind(0, otp)
                    .bind(1, email)
                    .execute();
        });
    }

    // 7. Cập nhật mật khẩu
    public void updatePassword(String email, String newPasswordHash) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET password_hash = ?, verification_code = NULL WHERE email = ?";
            handle.createUpdate(sql)
                    .bind(0, newPasswordHash)
                    .bind(1, email)
                    .execute();
        });
    }

    // 8. Cập nhật google_id
    public void updateGoogleId(String email, String googleId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET google_id = ? WHERE email = ?";
            handle.createUpdate(sql)
                    .bind(0, googleId)
                    .bind(1, email)
                    .execute();
        });
    }

    // 9. Cập nhật thông tin cá nhân (Tên, SĐT)
    public void updateProfile(int userId, String fullName, String phone) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET user_name = ?, phone = ? WHERE id = ?";
            handle.createUpdate(sql)
                    .bind(0, fullName)
                    .bind(1, phone)
                    .bind(2, userId)
                    .execute();
        });
    }
    //10. Lấy tất cả User
    public List<User> findAllUsers() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT * FROM users")
                        .mapToBean(User.class)
                        .list()
        );
    }
    // 11. Lấy Địa chỉ Address User
    public List<Address> findAllAddresses() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT * FROM addresses")
                        .mapToBean(Address.class)
                        .list()
        );
    }

    // 12. Ban/Block user
    public void banUser(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET status = 'BANNED' WHERE id = ?";
            handle.createUpdate(sql).bind(0, userId).execute();
        });
    }

    // 13. Unban/Unblock user
    public void unbanUser(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET status = 'Hoạt Động' WHERE id = ?";
            handle.createUpdate(sql).bind(0, userId).execute();
        });
    }

    // 14. Tìm User theo ID
    public User findById(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = ?")
                        .bind(0, userId)
                        .mapToBean(User.class)
                        .findOne().orElse(null)
        );
    }

    // 15. Admin cập nhật thông tin User
    public void adminUpdateUser(int userId, String fullName, String phone, String email, String role, String status) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "UPDATE users SET user_name = ?, phone = ?, email = ?, role = ?, status = ? WHERE id = ?";
            handle.createUpdate(sql)
                    .bind(0, fullName)
                    .bind(1, phone)
                    .bind(2, email)
                    .bind(3, role)
                    .bind(4, status)
                    .bind(5, userId)
                    .execute();
        });
    }

    // 16. Xóa cứng User và các bản ghi liên quan để tránh vi phạm ràng buộc khóa ngoại
    public void deleteUser(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useTransaction(handle -> {
            // Xóa user tokens Remember Me
            handle.createUpdate("DELETE FROM user_tokens WHERE user_id = ?").bind(0, userId).execute();
            
            // Xóa reviews (và các bản ghi hình ảnh review sẽ tự động bị xóa theo CASCADE)
            handle.createUpdate("DELETE FROM review WHERE user_id = ?").bind(0, userId).execute();

            // Xóa liên hệ contacts
            handle.createUpdate("DELETE FROM contacts WHERE user_id = ?").bind(0, userId).execute();

            // Xóa các sản phẩm trong giỏ hàng tạm thời
            handle.createUpdate("DELETE FROM cartitem WHERE user_id = ?").bind(0, userId).execute();

            // Xóa địa chỉ của người dùng
            handle.createUpdate("DELETE FROM addresses WHERE user_id = ?").bind(0, userId).execute();

            // Lấy danh sách các đơn hàng của user này để xóa các bảng phụ thuộc đơn hàng trước
            List<Integer> orderIds = handle.createQuery("SELECT id FROM orders WHERE user_id = ?")
                    .bind(0, userId)
                    .mapTo(Integer.class)
                    .list();
            for (int orderId : orderIds) {
                // Xóa giao hàng của đơn hàng
                handle.createUpdate("DELETE FROM delivery WHERE order_id = ?").bind(0, orderId).execute();
                // Xóa thanh toán của đơn hàng
                handle.createUpdate("DELETE FROM payments WHERE order_id = ?").bind(0, orderId).execute();
                // Xóa chi tiết đơn hàng (thường được CASCADE, nhưng làm tường minh cho an toàn)
                handle.createUpdate("DELETE FROM orderdetails WHERE order_id = ?").bind(0, orderId).execute();
                // Xóa đơn hàng
                handle.createUpdate("DELETE FROM orders WHERE id = ?").bind(0, orderId).execute();
            }

            // Cuối cùng xóa tài khoản người dùng
            handle.createUpdate("DELETE FROM users WHERE id = ?").bind(0, userId).execute();
        });
    }
}