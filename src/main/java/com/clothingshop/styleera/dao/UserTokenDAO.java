package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.UserToken;
import org.jdbi.v3.core.Jdbi;

import java.sql.Timestamp;

public class UserTokenDAO {

    public void saveToken(int userId, String token, Timestamp expiryDate) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle -> {
            String sql = "INSERT INTO user_tokens (user_id, token, expiry_date) VALUES (?, ?, ?)";
            handle.createUpdate(sql)
                    .bind(0, userId)
                    .bind(1, token)
                    .bind(2, expiryDate)
                    .execute();
        });
    }

    public UserToken findByToken(String token) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_tokens WHERE token = ? AND expiry_date > NOW()")
                        .bind(0, token)
                        .mapToBean(UserToken.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void deleteToken(String token) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM user_tokens WHERE token = ?")
                        .bind(0, token)
                        .execute()
        );
    }

    public void deleteTokensByUserId(int userId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM user_tokens WHERE user_id = ?")
                        .bind(0, userId)
                        .execute()
        );
    }
}
