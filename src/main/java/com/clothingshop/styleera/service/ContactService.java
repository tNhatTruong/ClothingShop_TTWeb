package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.ContactDAO;
import com.clothingshop.styleera.model.Contact;

import java.util.List;

public class ContactService {
    private ContactDAO contactDAO = new ContactDAO();

    public List<Contact> getAllContacts() {
        return contactDAO.findAll();
    }
}
