package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.model.Product;

import com.clothingshop.styleera.service.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardController", value = "/AdminDashboard")
public class AdminDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductService productService = new ProductService();
        OrdersService ordersService = new OrdersService();
        UserService userService = new UserService();
        CategoryService categoryService = new CategoryService();
        VariantService variantService = new VariantService();

        List<Product> bestSellers = productService.findBestSellersAdmin();
        List<ParentCategory> categoryStats = categoryService.getParentCategoryStats();
        int totalQuantity = variantService.getTotalQuantity();
        int totalOrders = ordersService.getTotalOrders();
        int totalProducts = productService.getTotalProducts();
        double totalRevenue = ordersService.getTotalRevenue();
        int totalUserCount = userService.countTotalUsers();
        double totalProductPrice = productService.getTotalProductPrice();
        List<Orders> latestOrders = ordersService.getLatestOrders(4);
        List<String> revenueChartLabels = ordersService.getRevenueChartLabels();
        List<Double> revenueChartData = ordersService.getRevenueChartData();

        request.setAttribute("dashboardLoaded", true);
        request.setAttribute("revenueChartLabels", revenueChartLabels);
        request.setAttribute("revenueChartData", revenueChartData);
        request.setAttribute("latestOrders", latestOrders);
        request.setAttribute("totalProductPrice", totalProductPrice);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalUser", totalUserCount);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("categoryStats", categoryStats);
        request.setAttribute("bestSellers", bestSellers);
        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}