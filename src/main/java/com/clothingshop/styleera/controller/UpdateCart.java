package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.CartItem;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@WebServlet(name = "UpdateCart", value = "/update-cart")
public class UpdateCart extends HttpServlet {

    // GSON dùng để chuyển đổi Map thành chuỗi JSON
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Không xử lý GET, trả về lỗi hoặc redirect
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Cấu hình header trả về JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Map chứa dữ liệu trả về
        Map<String, Object> result = new HashMap<>();

        try {
            // 2. Lấy dữ liệu từ Session
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null) {
                result.put("status", "error");
                result.put("msg", "Giỏ hàng trống!");
                out.print(gson.toJson(result));
                return;
            }

            // 3. Lấy và kiểm tra tham số
            String variantIdStr = request.getParameter("variantId");
            String action = request.getParameter("action");

            if (variantIdStr == null || action == null) {
                result.put("status", "error");
                result.put("msg", "Thiếu tham số!");
                out.print(gson.toJson(result));
                return;
            }

            int variantId = Integer.parseInt(variantIdStr);

            // 4. Tìm item trong giỏ hàng (Dùng Stream API)
            // Lưu ý: cart.getItem() trả về List<CartItem>
            Optional<CartItem> itemOpt = cart.getItem().stream()
                    .filter(i -> i.getVariant().getVariantId() == variantId)
                    .findFirst();

            if (!itemOpt.isPresent()) {
                result.put("status", "error");
                result.put("msg", "Sản phẩm không tồn tại trong giỏ!");
                out.print(gson.toJson(result));
                return;
            }

            CartItem item = itemOpt.get();
            int currentQty = item.getQuantity();
            int newQty = currentQty;

            // 5. Xử lý logic tăng/giảm
            if ("increase".equals(action)) {
                newQty++;
            } else if ("decrease".equals(action)) {
                newQty--;
                if (newQty < 1) newQty = 1; // Không cho giảm dưới 1
            }

            // 6. Cập nhật vào model Cart
            // Hàm updateItem trả về boolean, nhưng ở đây ta chỉ cần gọi nó thực hiện
            cart.updateItem(variantId, newQty);

            // Lưu lại session (quan trọng để đồng bộ)
            session.setAttribute("cart", cart);

            // 7. Tính toán các con số mới để trả về cho Frontend cập nhật ngay lập tức
            double itemPrice = item.getVariant().getProduct().getPrice();
            double itemTotal = newQty * itemPrice;
            double cartTotal = cart.total();
            int totalQuantity = cart.getTotalQuantity();

            // 8. Đóng gói JSON thành công
            result.put("status", "success");
            result.put("quantity", newQty);
            result.put("itemTotal", itemTotal);
            result.put("totalQuantity", totalQuantity);
            result.put("cartTotal", cartTotal);

            out.print(gson.toJson(result));

        } catch (NumberFormatException e) {
            result.put("status", "error");
            result.put("msg", "Dữ liệu ID không hợp lệ!");
            out.print(gson.toJson(result));
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("msg", "Lỗi hệ thống: " + e.getMessage());
            out.print(gson.toJson(result));
        }
    }
}