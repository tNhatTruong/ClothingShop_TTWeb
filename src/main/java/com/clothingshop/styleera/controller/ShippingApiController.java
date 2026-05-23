package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.service.ShippingService;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/calculate-shipping")
public class ShippingApiController extends HttpServlet {

    private ShippingService shippingService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo service
        shippingService = new ShippingService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Thiết lập trả về JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu gửi lên từ JS
            int toDistrictId = Integer.parseInt(request.getParameter("district_id"));
            String toWardCode = request.getParameter("ward_code");

            // Giả sử tổng trọng lượng đơn hàng là 500 gram (Bạn có thể lấy động từ Giỏ hàng Session nếu muốn)
            int weight = 500;

            // Gọi hàm tính tiền
            long fee = shippingService.calculateShippingFee(toDistrictId, toWardCode, weight);

            // Trả JSON thành công
            JsonObject successResp = new JsonObject();
            successResp.addProperty("status", "success");
            successResp.addProperty("fee", fee);

            response.getWriter().write(successResp.toString());

        } catch (Exception e) {
            // Trả JSON thất bại
            JsonObject errorResp = new JsonObject();
            errorResp.addProperty("status", "error");
            errorResp.addProperty("message", e.getMessage());

            response.getWriter().write(errorResp.toString());
        }
    }
}