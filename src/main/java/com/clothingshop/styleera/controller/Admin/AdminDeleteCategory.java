package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.service.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminDeleteCategory", value = "/AdminDeleteCategory")
public class AdminDeleteCategory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int subId = Integer.parseInt(request.getParameter("id"));

        CategoryService service = new CategoryService();
        service.deleteSubCategory(subId);

        response.sendRedirect(request.getContextPath() + "/admin-category");
    }
}