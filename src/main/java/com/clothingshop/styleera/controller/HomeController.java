package com.clothingshop.styleera.controller;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.service.ProductService;
import com.clothingshop.styleera.service.VariantService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();
        VariantService variantService = new VariantService();

        // 1. Lấy sản phẩm MỚI (New Arrivals)
        List<Product> newArrivals = productService.findNewArrivals();

        // Xử lý nút thêm giỏ hàng (Hàng Mới Về)
        for (Product p : newArrivals) {
            Integer defaultVariantId = variantService.getDefaultVariantId(p.getProduct_id());
            p.setDefaultVariantId(defaultVariantId);
        }

        // 2. Lấy sản phẩm BÁN CHẠY (Best Sellers)
        List<Product> bestSellers = productService.findBestSellers();

        // Xử lý nút thêm giỏ hàng (Sản Phẩm Bán Chạy)
        for(Product p: bestSellers){
            Integer defaultVariantId = variantService.getDefaultVariantId(p.getProduct_id());
            p.setDefaultVariantId(defaultVariantId);
        }

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("newArrivals", newArrivals);
        request.setAttribute("bestSellers", bestSellers); // Quan trọng: biến này dùng cho phần Bán chạy

        request.getRequestDispatcher("/views/pages/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}