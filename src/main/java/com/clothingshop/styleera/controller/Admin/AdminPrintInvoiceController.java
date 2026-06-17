package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.util.SessionManage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminPrintInvoiceController", urlPatterns = "/admin/print-invoice")
public class AdminPrintInvoiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Bảo vệ: Chỉ Admin mới được in hóa đơn
        if (!SessionManage.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        String orderIdsStr = request.getParameter("orderIds");
        
        List<Integer> idsToPrint = new ArrayList<>();
        
        if (orderIdsStr != null && !orderIdsStr.trim().isEmpty()) {
            String[] parts = orderIdsStr.split(",");
            for (String p : parts) {
                try {
                    idsToPrint.add(Integer.parseInt(p.trim()));
                } catch (NumberFormatException ignored) {}
            }
        } else if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
            try {
                idsToPrint.add(Integer.parseInt(orderIdStr.trim()));
            } catch (NumberFormatException ignored) {}
        }

        if (idsToPrint.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid Order ID");
            return;
        }

        OrdersDAO ordersDAO = new OrdersDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        VariantDAO variantDAO = new VariantDAO();

        // Danh sách chứa thông tin đầy đủ của mỗi hóa đơn cần in
        List<Map<String, Object>> invoiceList = new ArrayList<>();

        for (int id : idsToPrint) {
            Orders order = ordersDAO.findById(id);
            if (order != null) {
                List<OrderDetail> details = orderDetailsDAO.findByOrderId(id);
                List<Map<String, Object>> items = new ArrayList<>();
                if (details != null) {
                    for (OrderDetail detail : details) {
                        Variants variant = variantDAO.getById(detail.getVariant_id());
                        Map<String, Object> itemMap = new HashMap<>();
                        itemMap.put("productName", variant != null && variant.getProduct() != null ? variant.getProduct().getProduct_name() : "Sản phẩm không tồn tại");
                        itemMap.put("size", variant != null ? variant.getSize() : "");
                        itemMap.put("color", variant != null ? variant.getColor() : "");
                        itemMap.put("quantity", detail.getQuantity());
                        itemMap.put("price", detail.getPrice());
                        itemMap.put("total", detail.getQuantity() * detail.getPrice());
                        items.add(itemMap);
                    }
                }
                
                Map<String, Object> invoiceData = new HashMap<>();
                invoiceData.put("order", order);
                invoiceData.put("items", items);
                invoiceList.add(invoiceData);
            }
        }

        if (invoiceList.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No valid orders found to print");
            return;
        }

        request.setAttribute("invoiceList", invoiceList);
        request.getRequestDispatcher("/admin/print-invoice.jsp").forward(request, response);
    }
}
