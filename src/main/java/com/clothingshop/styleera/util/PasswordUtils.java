package com.clothingshop.styleera.util;

import org.mindrot.jbcrypt.BCrypt;
import java.util.regex.Pattern;

public class PasswordUtils {

    // Regex giải thích:
    // (?=.*[0-9])       : Phải có ít nhất 1 số
    // (?=.*[a-z])       : Phải có ít nhất 1 chữ thường
    // (?=.*[A-Z])       : Phải có ít nhất 1 chữ hoa
    // (?=.*[@#$%^&+=!]) : Phải có ít nhất 1 ký tự đặc biệt
    // (?=\\S+$)         : Không được chứa khoảng trắng
    // .{8,}             : Độ dài tối thiểu 8 ký tự
    private static final String PASS_REGEX = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";

    // Kiểm tra độ mạnh mật khẩu
    public static boolean checkPasswordStrength(String password) {
        return password != null && Pattern.compile(PASS_REGEX).matcher(password).matches();
    }

    // Mã hóa mật khẩu (Dùng khi Đăng ký)
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // Kiểm tra mật khẩu (Dùng khi Đăng nhập)
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null || !hashedPassword.startsWith("$2a$")) return false;
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}