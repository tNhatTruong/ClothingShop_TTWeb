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
}
