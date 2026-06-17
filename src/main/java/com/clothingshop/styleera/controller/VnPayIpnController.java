package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.enums.OrderStatus;
import com.clothingshop.styleera.util.VnPayConfig;
import com.clothingshop.styleera.util.VnPayUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet("/vnpay-ipn")
public class VnPayIpnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
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

            if (signValue.equals(vnp_SecureHash)) {
                String txnRef = request.getParameter("vnp_TxnRef");
                int orderId = 0;
                if (txnRef != null && txnRef.contains("_")) {
                    orderId = Integer.parseInt(txnRef.split("_")[0]);
                } else if (txnRef != null) {
                    orderId = Integer.parseInt(txnRef);
                }

                OrdersDAO ordersDAO = new OrdersDAO();
                Orders order = ordersDAO.findById(orderId);

                if (order != null) {
                    // Kiem tra so tien
                    long vnp_Amount = Long.parseLong(request.getParameter("vnp_Amount")) / 100;
                    if (vnp_Amount == (long) order.getTotalPrice()) {
                        // Kiem tra trang thai don hang
                        if (OrderStatus.PENDING_PAYMENT.getValue().equals(order.getStatus())) {
                            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                                // Giao dich thanh cong
                                ordersDAO.updateStatus(orderId, OrderStatus.PAID.getValue());
                            } else {
                                // Giao dich loi / huy
                                // Khong can lam gi vi OrderCleanupListener se don dep sau 30p neu van chua thanh toan
                            }
                            out.print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                        } else {
                            out.print("{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}");
                        }
                    } else {
                        out.print("{\"RspCode\":\"04\",\"Message\":\"Invalid Amount\"}");
                    }
                } else {
                    out.print("{\"RspCode\":\"01\",\"Message\":\"Order not found\"}");
                }
            } else {
                out.print("{\"RspCode\":\"97\",\"Message\":\"Invalid Checksum\"}");
            }
        } catch (Exception e) {
            out.print("{\"RspCode\":\"99\",\"Message\":\"Unknown error\"}");
        }
    }
}
