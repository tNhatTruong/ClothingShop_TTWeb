package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ProductDAO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/api/admin/update-stock")
public class AdminUpdateStockApiController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Đọc body dạng JSON
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            Gson gson = new Gson();
            JsonObject payload = gson.fromJson(sb.toString(), JsonObject.class);

            if (payload == null || !payload.has("variants")) {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Dữ liệu không hợp lệ.\"}");
                return;
            }

            JsonArray variants = payload.getAsJsonArray("variants");
            ProductDAO productDAO = new ProductDAO();
            boolean success = true;

            for (JsonElement el : variants) {
                JsonObject v = el.getAsJsonObject();
                int variantId = v.get("variantId").getAsInt();
                int quantity = v.get("quantity").getAsInt();

                if (quantity < 0) quantity = 0; // Tránh lỗi số âm

                boolean updated = productDAO.updateVariantQuantity(variantId, quantity);
                if (!updated) {
                    success = false;
                }
            }

            if (success) {
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Cập nhật thành công.\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Một số biến thể không được cập nhật thành công.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Lỗi máy chủ nội bộ.\"}");
        }
    }
}
