package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.PasswordUtils;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public List<User> getAllUsers(){
        List<User> users = userDAO.findAllUsers();
        List<Address> address = userDAO.findAllAddresses();
        for (User u : users) {
            List<Address> userAddresses = new ArrayList<>();
            for (Address a : address) {
                if (a.getUserId() == u.getId()) {
                    userAddresses.add(a);
                }
            }
            u.setAddresses(userAddresses);
        }
        return users;
    }

    // Đăng ký tài khoản Admin mới với kiểm tra trùng email và băm mật khẩu BCrypt
    public void registerAdmin(User user) throws Exception {
        // Kiểm tra email đã tồn tại chưa
        if (userDAO.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email đã được sử dụng bởi một tài khoản khác!");
        }
        // Băm mật khẩu bằng BCrypt trước khi lưu
        String hashedPassword = PasswordUtils.hashPassword(user.getPassword_hash());
        user.setPassword_hash(hashedPassword);
        // Lưu vào CSDL
        userDAO.insertAdmin(user);
    }
}
