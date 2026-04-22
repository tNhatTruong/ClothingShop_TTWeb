package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.model.Orders;

import java.util.List;

public class OrdersService {
    private OrdersDAO ordersDAO = new OrdersDAO();
    public int getTotalOrders() {
        return ordersDAO.countTotalOrders();
    }
    public List<Orders> getLatestOrders(int limit){
        return ordersDAO.getLatestOrders(limit);
    }

}
