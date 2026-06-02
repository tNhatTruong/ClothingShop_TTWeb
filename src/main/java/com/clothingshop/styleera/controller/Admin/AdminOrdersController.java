package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.service.OrdersService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrdersController", urlPatterns = "/admin-orders")
public class AdminOrdersController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrdersService ordersService = new OrdersService();
        List<Orders> orders = ordersService.findAllOrders();
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/admin-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
