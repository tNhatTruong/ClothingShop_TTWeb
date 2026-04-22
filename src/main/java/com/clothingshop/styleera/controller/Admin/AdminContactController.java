package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.Contact;
import com.clothingshop.styleera.service.ContactService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminContactController", urlPatterns = "/admin-contact")
public class AdminContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ContactService contactService = new ContactService();
        List<Contact> contacts = contactService.getAllContacts();
        request.setAttribute("contactList", contacts);
        request.getRequestDispatcher("/admin/admin-contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}