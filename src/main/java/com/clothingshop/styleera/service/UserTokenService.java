package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.UserTokenDAO;
import com.clothingshop.styleera.model.UserToken;

import java.sql.Timestamp;

public class UserTokenService {
    private final UserTokenDAO userTokenDAO = new UserTokenDAO();

    public void saveToken(int userId, String token, Timestamp expiryDate) {
        userTokenDAO.saveToken(userId, token, expiryDate);
    }

    public UserToken findByToken(String token) {
        return userTokenDAO.findByToken(token);
    }

    public void deleteToken(String token) {
        userTokenDAO.deleteToken(token);
    }

    public void deleteTokensByUserId(int userId) {
        userTokenDAO.deleteTokensByUserId(userId);
    }
}
