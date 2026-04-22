package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminAddProduct", value = "/AdminAddProduct")
public class AdminAddProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("product_name");
        int subId = Integer.parseInt(request.getParameter("subcategory_id"));
        double price = Double.parseDouble(request.getParameter("price"));
        String shortDesc = request.getParameter("short_desc");
        String detailDesc = request.getParameter("detail_desc");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imageName = request.getParameter("image_name");
        String imagePath = request.getParameter("image_path");

        ProductService service = new ProductService();
        service.addProduct(
                name, subId, price,
                shortDesc, detailDesc,
                size, color, quantity,
                imageName, imagePath
        );

        response.sendRedirect(request.getContextPath() + "/admin-products");
    }
}