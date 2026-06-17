package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.OrderDetailsDAO;
import com.clothingshop.styleera.dao.OrdersDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.OrderDetail;
import com.clothingshop.styleera.model.Orders;
import com.clothingshop.styleera.model.Variants;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import java.lang.reflect.Type;
import java.time.LocalDateTime;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/admin/order-detail")
public class AdminOrderDetailApiController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new JsonSerializer<LocalDateTime>() {
                    @Override
                    public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
                        return new JsonPrimitive(src.toString());
                    }
                })
                .create();
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(gson.toJson(Map.of("error", "Missing order ID")));
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            OrdersDAO ordersDAO = new OrdersDAO();
            Orders order = ordersDAO.findById(orderId);

            if (order == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print(gson.toJson(Map.of("error", "Order not found")));
                return;
            }

            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            List<OrderDetail> details = orderDetailsDAO.findByOrderId(orderId);

            VariantDAO variantDAO = new VariantDAO();
            List<Map<String, Object>> items = new ArrayList<>();

            if (details != null) {
                for (OrderDetail detail : details) {
                    Variants variant = variantDAO.getById(detail.getVariant_id());
                    Map<String, Object> itemMap = new HashMap<>();
                    itemMap.put("productName", variant != null && variant.getProduct() != null ? variant.getProduct().getProduct_name() : "Sản phẩm không tồn tại");
                    itemMap.put("thumbnail", variant != null && variant.getProduct() != null ? variant.getProduct().getThumbnail() : "");
                    itemMap.put("size", variant != null ? variant.getSize() : "");
                    itemMap.put("color", variant != null ? variant.getColor() : "");
                    itemMap.put("quantity", detail.getQuantity());
                    itemMap.put("price", detail.getPrice());
                    itemMap.put("total", detail.getQuantity() * detail.getPrice());
                    items.add(itemMap);
                }
            }

            Map<String, Object> result = new HashMap<>();
            result.put("order", order);
            result.put("items", items);

            out.print(gson.toJson(result));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(gson.toJson(Map.of("error", "Invalid order ID")));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(gson.toJson(Map.of("error", "Server Error: " + e.getMessage())));
            e.printStackTrace();
        }
    }
}
