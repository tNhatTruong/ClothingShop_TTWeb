package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.model.Orders;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrdersService {
    private OrdersDAO ordersDAO = new OrdersDAO();
    public int getTotalOrders() {
        return ordersDAO.countTotalOrders();
    }
    public List<Orders> getLatestOrders(int limit){
        return ordersDAO.getLatestOrders(limit);
    }
    public double getTotalRevenue() {
        return ordersDAO.countTotalRevenue();
    }

    /** 6 tháng gần nhất: nhãn hiển thị + doanh thu (VNĐ) cho biểu đồ dashboard. */
    public List<String> getRevenueChartLabels() {
        List<String> labels = new ArrayList<>();
        YearMonth now = YearMonth.now();
        for (int i = 5; i >= 0; i--) {
            YearMonth month = now.minusMonths(i);
            labels.add("Tháng " + month.getMonthValue());
        }
        return labels;
    }

    public List<Double> getRevenueChartData() {
        Map<Integer, Double> revenueByMonth = ordersDAO.getDeliveredRevenueByMonth();
        List<Double> data = new ArrayList<>();
        YearMonth now = YearMonth.now();
        for (int i = 5; i >= 0; i--) {
            YearMonth month = now.minusMonths(i);
            int key = month.getYear() * 100 + month.getMonthValue();
            data.add(revenueByMonth.getOrDefault(key, 0.0));
        }
        return data;
    }

    public int countPendingApprovalOrders() {
        return ordersDAO.countPendingApprovalOrders();
    }
    
    public List<Orders> getPendingApprovalOrders(int limit) {
        return ordersDAO.getPendingApprovalOrders(limit);
    }

    public int countReturnRequestedOrders() {
        return ordersDAO.countReturnRequestedOrders();
    }
    
    public List<Orders> getReturnRequestedOrders(int limit) {
        return ordersDAO.getReturnRequestedOrders(limit);
    }

    public List<String> getDailyRevenueChartLabels() {
        List<String> labels = new ArrayList<>();
        int lengthOfMonth = java.time.LocalDate.now().lengthOfMonth();
        for (int i = 1; i <= lengthOfMonth; i++) {
            labels.add(String.valueOf(i));
        }
        return labels;
    }

    public List<Double> getDailyRevenueChartData() {
        Map<Integer, Double> revenueByDay = ordersDAO.getDailyRevenueCurrentMonth();
        List<Double> data = new ArrayList<>();
        int lengthOfMonth = java.time.LocalDate.now().lengthOfMonth();
        for (int i = 1; i <= lengthOfMonth; i++) {
            data.add(revenueByDay.getOrDefault(i, 0.0));
        }
        return data;
    }

    public List<String> getMonthlyRevenueChartLabels() {
        List<String> labels = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            labels.add("Tháng " + i);
        }
        return labels;
    }

    public List<Double> getMonthlyRevenueChartData() {
        Map<Integer, Double> revenueByMonth = ordersDAO.getMonthlyRevenueCurrentYear();
        List<Double> data = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            data.add(revenueByMonth.getOrDefault(i, 0.0));
        }
        return data;
    }

    public Orders findById(int orderId) {
        return ordersDAO.findById(orderId);
    }

    public List<Orders> findAllOrders() {
        return ordersDAO.findAllOrders();
    }
}
