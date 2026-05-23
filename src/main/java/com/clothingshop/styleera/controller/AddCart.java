package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.service.VariantService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AddCart", value = "/addcart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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