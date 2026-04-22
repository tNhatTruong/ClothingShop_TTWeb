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

    // 2. Kiểm tra OTP có đúng không
    public boolean checkOtp(String email, String inputOtp) {
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
}