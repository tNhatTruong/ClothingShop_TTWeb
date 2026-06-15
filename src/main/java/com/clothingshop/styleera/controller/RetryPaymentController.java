package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.OrdersService;
import com.clothingshop.styleera.util.SessionManage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/retry-payment")
public class RetryPaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionManage.getCurrentUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order-history");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        OrdersService ordersService = new OrdersService();
        Orders order = ordersService.findById(orderId);

        if (order == null || order.getUserId() != user.getId() || !"Chờ thanh toán".equals(order.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/order-status?id=" + orderId);
            return;
        }

        try {
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            long amount = (long) (order.getTotalPrice() * 100);
            String vnp_TxnRef = orderId + "_" + System.currentTimeMillis();
            String vnp_IpAddr = com.clothingshop.styleera.util.VnPayUtils.getIpAddress(request);

            java.util.Map<String, String> vnp_Params = new java.util.HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", com.clothingshop.styleera.util.VnPayConfig.vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
            vnp_Params.put("vnp_OrderType", orderType);
            vnp_Params.put("vnp_Locale", "vn");

            String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + com.clothingshop.styleera.util.VnPayConfig.vnp_ReturnUrl;
            vnp_Params.put("vnp_ReturnUrl", returnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            java.util.Calendar cld = java.util.Calendar.getInstance(java.util.TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
            java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
            formatter.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(java.util.Calendar.MINUTE, 30);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            java.util.List<String> fieldNames = new java.util.ArrayList<>(vnp_Params.keySet());
            java.util.Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            java.util.Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(java.net.URLEncoder.encode(fieldValue, java.nio.charset.StandardCharsets.US_ASCII.toString()));
                    query.append(java.net.URLEncoder.encode(fieldName, java.nio.charset.StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(java.net.URLEncoder.encode(fieldValue, java.nio.charset.StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = com.clothingshop.styleera.util.VnPayUtils.hmacSHA512(com.clothingshop.styleera.util.VnPayConfig.vnp_HashSecret, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = com.clothingshop.styleera.util.VnPayConfig.vnp_PayUrl + "?" + queryUrl;

            response.sendRedirect(paymentUrl);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/order-status?id=" + orderId + "&error=system");
        }
    }
}
