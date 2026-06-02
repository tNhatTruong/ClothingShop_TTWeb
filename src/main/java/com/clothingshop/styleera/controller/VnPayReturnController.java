package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.util.VnPayConfig;
import com.clothingshop.styleera.util.VnPayUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@WebServlet("/vnpay-return")
public class VnPayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }

        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    hashData.append('&');
                }
            }
        }

        String signValue = VnPayUtils.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());
        
        OrdersDAO ordersDAO = new OrdersDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        VariantDAO variantDAO = new VariantDAO();

        String txnRef = request.getParameter("vnp_TxnRef");
        int orderId = 0;
        try {
            orderId = Integer.parseInt(txnRef);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                // Thanh toán thành công
                if (orderId > 0) {
                    ordersDAO.updateStatus(orderId, "Đã Thanh Toán");
                }
                response.sendRedirect(request.getContextPath() + "/order-success?id=" + orderId);
            } else {
                // Thanh toán thất bại hoặc bị hủy
                if (orderId > 0) {
                    ordersDAO.updateStatus(orderId, "Hủy (Lỗi Thanh Toán)");
                    // Hoàn trả số lượng tồn kho
                    List<OrderDetail> details = orderDetailsDAO.findByOrderId(orderId);
                    if (details != null) {
                        for (OrderDetail detail : details) {
                            variantDAO.restoreStock(detail.getVariant_id(), detail.getQuantity());
                        }
                    }
                }
                request.setAttribute("errorMessage", "Thanh toán không thành công hoặc đã bị hủy.");
                request.getRequestDispatcher("/views/pages/cart.jsp").forward(request, response);
            }
        } else {
            // Chữ ký không hợp lệ
            if (orderId > 0) {
                ordersDAO.updateStatus(orderId, "Hủy (Lỗi Thanh Toán)");
                List<OrderDetail> details = orderDetailsDAO.findByOrderId(orderId);
                if (details != null) {
                    for (OrderDetail detail : details) {
                        variantDAO.restoreStock(detail.getVariant_id(), detail.getQuantity());
                    }
                }
            }
            request.setAttribute("errorMessage", "Lỗi bảo mật: Chữ ký thanh toán không hợp lệ!");
            request.getRequestDispatcher("/views/pages/cart.jsp").forward(request, response);
        }
    }
}
