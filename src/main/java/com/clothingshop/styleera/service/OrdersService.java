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
}
