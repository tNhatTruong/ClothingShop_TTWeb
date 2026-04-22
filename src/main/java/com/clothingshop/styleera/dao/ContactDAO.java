package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Contact;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ContactDAO {
    //lấy toàn bộ thông tin contact
    public List<Contact> findAll() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM contacts ORDER BY send_at DESC")
                        .mapToBean(Contact.class)
                        .list()
        );
    }
}
