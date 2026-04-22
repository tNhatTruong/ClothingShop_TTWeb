package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.CategoryDAO;
import com.clothingshop.styleera.dao.ProductDAO;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardController", value = "/AdminDashboard")
public class AdminDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();
        OrdersService ordersService = new OrdersService();
        UserService userService = new UserService();
        CategoryService categoryService = new CategoryService();
        VariantService variantService = new VariantService();


        List<Product> bestSellers = productService.findBestSellersAdmin();
        List<ParentCategory> categoryStats = categoryService.getParentCategoryStats();
        int totalQuantity = variantService.getTotalQuantity();
        int totalOrders = ordersService.getTotalOrders();
        List<User> userTotal = userService.getAllUsers();
        double totalProductPrice = productService.getTotalProductPrice();
        List<Orders> latestOrders = ordersService.getLatestOrders(4);


        request.setAttribute("latestOrders", latestOrders);
        request.setAttribute("totalProductPrice", totalProductPrice);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUser", userTotal);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("categoryStats", categoryStats);
        request.setAttribute("bestSellers", bestSellers);
        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}