package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ProductDAO;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductsController", urlPatterns = "/admin-products")
public class AdminProductsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();
        List<Product> productsAdmin = productService.findAll();
        if (productsAdmin == null) {
            productsAdmin = new java.util.ArrayList<>();
        }
        ProductDAO dao = new ProductDAO();
        //lọc theo danh mục:
        String parent = request.getParameter("parent");
        String sub = request.getParameter("sub");
        String size = request.getParameter("size");
        String color = request.getParameter("color");

        // Nếu tất cả filter đều trống, lấy tất cả sản phẩm
        if ((parent == null || parent.isEmpty()) &&
                (sub == null || sub.isEmpty()) &&
                (size == null || size.isEmpty()) &&
                (color == null || color.isEmpty())) {
            productsAdmin = dao.findAll();
        } else {
            // Nếu có cả ParentCategory và SubCategory
            if ((parent != null && !parent.isEmpty()) && (sub != null && !sub.isEmpty())) {
                productsAdmin = dao.filterParentAndSubCategory(parent, sub);
            }
            // Lọc theo danh mục SubCategory
            else if (sub != null && !sub.isEmpty()) {
                productsAdmin = dao.filterSubCategory(sub);
            }
            // Lọc theo danh mục ParentCategory
            else if (parent != null && !parent.isEmpty()) {
                productsAdmin = dao.filterParentCategory(parent);
            }
            // Nếu không có cả hai, lấy tất cả
            else {
                productsAdmin = dao.findAll();
            }
        }
        // Lọc theo biến thể Size và Color
        if ((size != null && !size.isEmpty()) || (color != null && !color.isEmpty())) {
            productsAdmin = dao.filterVariants(productsAdmin, size, color);
        }

        if (productsAdmin == null) {
            productsAdmin = new java.util.ArrayList<>();
        }


        request.setAttribute("productsAdmin", productsAdmin);
        request.getRequestDispatcher("/admin/admin-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}