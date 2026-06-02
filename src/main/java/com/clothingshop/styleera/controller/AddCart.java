package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.service.VariantService;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "AddCart", value = "/addcart")
public class AddCart extends HttpServlet {
    private final VariantService variantService = new VariantService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String productIdStr = request.getParameter("productId");

            if (productIdStr == null || productIdStr.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"status\":\"error\",\"msg\":\"Thiếu productId\"}");
                return;
            }

            int productId = Integer.parseInt(productIdStr);

            // Gọi hàm từ Service để lấy danh sách biến thể
            List<Variants> listVariants = variantService.getVariantsByProductId(productId);

            // Trả về chuỗi JSON cho AJAX nhận
            out.print(this.gson.toJson(listVariants));
            out.flush();

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"status\":\"error\",\"msg\":\"Định dạng productId không đúng\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"status\":\"error\",\"msg\":\"Lỗi hệ thống khi lấy phân loại\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            int variantId = Integer.parseInt(request.getParameter("variantId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // 1. TÌM SẢN PHẨM TỪ DB TRƯỚC
            VariantService variantService = new VariantService();
            Variants variant = variantService.getById(variantId);

            if (variant == null) {
                out.print("{\"status\":\"error\",\"msg\":\"Sản phẩm không tồn tại\"}");
                return;
            }

            // 2. THÊM VÀO GIỎ HÀNG SESSION (ĐỂ HIỂN THỊ NHANH)
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            cart.addItem(variant, quantity);
            session.setAttribute("cart", cart);

            // 3. THÊM XUỐNG DATABASE (ĐỂ LƯU VĨNH VIỄN KHÔNG BỊ MẤT)
            User user = (User) session.getAttribute("auth");
            if (user != null) {
                CartDao cartDao = new CartDao();
                cartDao.saveOrUpdateCartItem(user.getId(), variant.getVariantId(), quantity);
            }

            // 4. TRẢ VỀ KẾT QUẢ THÀNH CÔNG CHO AJAX (JSP)
            out.print("{"
                    + "\"status\":\"success\","
                    + "\"msg\":\"Đã thêm vào giỏ hàng thành công\","
                    + "\"totalQuantity\":" + cart.getTotalQuantity() + ","
                    + "\"cartSize\":" + cart.getItem().size()
                    + "}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"msg\":\"Lỗi dữ liệu\"}");
        }
    }
}