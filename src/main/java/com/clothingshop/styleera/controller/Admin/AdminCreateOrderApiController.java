package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.*;
import com.clothingshop.styleera.service.OrderService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/admin/create-order")
public class AdminCreateOrderApiController extends HttpServlet {

    private final Gson gson = new Gson();
    private final UserDAO userDAO = new UserDAO();
    private final AddressDAO addressDAO = new AddressDAO();
    private final VariantDAO variantDAO = new VariantDAO();
    private final OrderService orderService = new OrderService();

    // DTO cho Request Body
    public static class CreateOrderRequest {
        String customerName;
        String customerPhone;
        String province_name;
        String district_name;
        String ward_name;
        String street;
        String note;
        String orderStatus;
        double shippingFee;
        List<ItemRequest> items;
    }

    public static class ItemRequest {
        int variantId;
        int quantity;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> result = new HashMap<>();

        try {
            // 1. Parse JSON payload
            BufferedReader reader = request.getReader();
            CreateOrderRequest req = gson.fromJson(reader, CreateOrderRequest.class);

            if (req.items == null || req.items.isEmpty()) {
                result.put("status", "error");
                result.put("message", "Chưa có sản phẩm nào trong đơn hàng!");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            // 2. Resolve User ID (Tìm theo SDT hoặc tạo Guest)
            User user = userDAO.findByPhone(req.customerPhone);
            int finalUserId;
            if (user != null) {
                finalUserId = user.getId();
            } else {
                // Tạo Guest User
                user = new User();
                user.setUser_name(req.customerName);
                user.setPhone(req.customerPhone);
                user.setEmail("khachhang_" + System.currentTimeMillis() + "@gmail.com");
                
                finalUserId = userDAO.registerGuestUser(user);
                user.setId(finalUserId); // Gán ID để truyền vào OrderService
            }

            // 3. Resolve Address ID
            int addressId = addressDAO.saveOrUpdateAndReturnId(
                    finalUserId, req.street, req.province_name, req.district_name, req.ward_name
            );

            // 4. Load Variants, Calculate Price and Build Fake Cart Items
            double totalItemsPrice = 0;
            List<CartItem> fakeCartItems = new ArrayList<>();
            for (ItemRequest itemReq : req.items) {
                Variants variant = variantDAO.getById(itemReq.variantId);
                if (variant == null) {
                    throw new RuntimeException("Sản phẩm ID " + itemReq.variantId + " không tồn tại!");
                }
                if (variant.getQuantity() < itemReq.quantity) {
                    throw new RuntimeException("Sản phẩm " + variant.getProduct().getProduct_name() + 
                            " (Size: " + variant.getSize() + ", Màu: " + variant.getColor() + 
                            ") chỉ còn " + variant.getQuantity() + " cái!");
                }

                totalItemsPrice += (variant.getProduct().getPrice() * itemReq.quantity);

                CartItem cartItem = new CartItem();
                cartItem.setVariant(variant);
                cartItem.setQuantity(itemReq.quantity);
                fakeCartItems.add(cartItem);
            }

            double grandTotal = totalItemsPrice + req.shippingFee;
            String fullAddress = req.street + ", " + req.ward_name + ", " + req.district_name + ", " + req.province_name;

            // 5. Build Orders Object
            Orders order = new Orders();
            order.setUserId(finalUserId);
            order.setAddressId(addressId);
            order.setShippingName(req.customerName);
            order.setShippingPhone(req.customerPhone);
            order.setShippingAddress(fullAddress);
            order.setStatus(req.orderStatus);
            order.setNote(req.note);
            order.setPrice(totalItemsPrice);
            order.setFeeDelivery(req.shippingFee);
            order.setTotalPrice(grandTotal);

            // 6. Call OrderService (Transaction: Insert Order, OrderDetails, Update Stock)
            // isBuyNow = true để bỏ qua xóa CartItem thực sự trong DB
            int newOrderId = orderService.placeOrder(order, fakeCartItems, user, true);

            result.put("status", "success");
            result.put("message", "Tạo đơn hàng thành công!");
            result.put("orderId", newOrderId);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result.put("status", "error");
            result.put("message", "Lỗi: " + e.getMessage());
        }

        response.getWriter().write(gson.toJson(result));
    }
}
