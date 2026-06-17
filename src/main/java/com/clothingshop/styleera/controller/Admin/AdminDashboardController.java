package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.Orders;
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
        VariantService variantService = new VariantService();

        List<Product> bestSellers = productService.findBestSellersAdmin();
        int totalQuantity = variantService.getTotalQuantity();
        int totalOrders = ordersService.getTotalOrders();
        int totalProducts = productService.getTotalProducts();
        double totalRevenue = ordersService.getTotalRevenue();
        int totalUserCount = userService.countTotalUsers();
        double totalProductPrice = productService.getTotalProductPrice();
        List<Orders> latestOrders = ordersService.getLatestOrders(4);
        
        // Biểu đồ theo tháng (trong năm nay)
        List<String> monthlyLabels = ordersService.getMonthlyRevenueChartLabels();
        List<Double> monthlyData = ordersService.getMonthlyRevenueChartData();
        
        // Biểu đồ theo ngày (trong tháng này)
        List<String> dailyLabels = ordersService.getDailyRevenueChartLabels();
        List<Double> dailyData = ordersService.getDailyRevenueChartData();

        // Việc cần làm ngay
        int pendingApprovalCount = ordersService.countPendingApprovalOrders();
        int returnRequestedCount = ordersService.countReturnRequestedOrders();
        int lowStockCount = variantService.countLowStockVariants(5); // Ngưỡng dưới 5 sản phẩm

        // Lấy danh sách chi tiết hiển thị
        List<Orders> pendingOrders = ordersService.getPendingApprovalOrders(3);
        List<Orders> returnOrders = ordersService.getReturnRequestedOrders(3);
        List<com.clothingshop.styleera.model.Variants> lowStockVariantsList = variantService.getLowStockVariants(5, 3);

        request.setAttribute("dashboardLoaded", true);
        
        request.setAttribute("monthlyLabels", monthlyLabels);
        request.setAttribute("monthlyData", monthlyData);
        request.setAttribute("dailyLabels", dailyLabels);
        request.setAttribute("dailyData", dailyData);
        
        request.setAttribute("pendingApprovalCount", pendingApprovalCount);
        request.setAttribute("returnRequestedCount", returnRequestedCount);
        request.setAttribute("lowStockCount", lowStockCount);
        
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("returnOrders", returnOrders);
        request.setAttribute("lowStockVariantsList", lowStockVariantsList);

        request.setAttribute("latestOrders", latestOrders);
        request.setAttribute("totalProductPrice", totalProductPrice);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalUser", totalUserCount);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("bestSellers", bestSellers);
        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}