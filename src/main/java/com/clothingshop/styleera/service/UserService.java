package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.User;

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

    public void banUser(int userId) {
        userDAO.banUser(userId);
    }

    public void unbanUser(int userId) {
        userDAO.unbanUser(userId);
    }

    public User findById(int userId) {
        return userDAO.findById(userId);
    }

    public void adminUpdateUser(int userId, String fullName, String phone, String email, String role, String status) {
        userDAO.adminUpdateUser(userId, fullName, phone, email, role, status);
    }

    public void deleteUser(int userId) {
        userDAO.deleteUser(userId);
    }
}
