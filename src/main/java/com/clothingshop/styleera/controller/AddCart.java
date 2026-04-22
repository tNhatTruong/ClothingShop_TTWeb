package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Cart;
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

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) cart = new Cart();

            VariantService variantService = new VariantService();
            Variants variant = variantService.getById(variantId);

            if (variant == null) {
                out.print("{\"status\":\"error\",\"msg\":\"Sản phẩm không tồn tại\"}");
                return;
            }

            cart.addItem(variant, quantity);
            session.setAttribute("cart", cart);
            out.print("{"
                    + "\"status\":\"success\","
                    + "\"msg\":\"Đã thêm vào giỏ hàng thành công\","
                    + "\"totalQuantity\":" + cart.getTotalQuantity()
                    + "}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"msg\":\"Lỗi dữ liệu\"}");
        }

    }
}