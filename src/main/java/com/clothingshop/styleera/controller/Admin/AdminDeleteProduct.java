package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminDeleteProduct", value = "/AdminDeleteProduct")
public class AdminDeleteProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductService ps = new ProductService();

        ps.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/admin-products");
    }
}