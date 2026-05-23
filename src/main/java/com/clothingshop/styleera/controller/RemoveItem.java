package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.CartDao;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RemoveItem", value = "/del-item")
public class RemoveItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession();
        String variantIdRaw = request.getParameter("variantId");

        if (variantIdRaw == null || variantIdRaw.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"status\":\"error\",\"msg\":\"Thiếu variantId\"}");
            return;
        }

        final int variantId;
        try {
            variantId = Integer.parseInt(variantIdRaw);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"status\":\"error\",\"msg\":\"variantId không hợp lệ\"}");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"status\":\"error\",\"msg\":\"Giỏ hàng trống\"}");
            return;
        }

        cart.removeItem(variantId);

        // Đồng bộ xóa với Database nếu đang đăng nhập
        User user = (User) session.getAttribute("auth");
        if (user != null) {
            CartDao cartDao = new CartDao();
            cartDao.removeCartItem(user.getId(), variantId);
        }

        if (cart.getTotalQuantity() <= 0) {
            session.removeAttribute("cart");
        } else {
            session.setAttribute("cart", cart);
        }

        response.getWriter().print(
                "{\"status\":\"success\",\"totalQuantity\":" + cart.getTotalQuantity() + ",\"cartSize\":" + cart.getItem().size() + ",\"cartTotal\":" + cart.total() + "}"
        );

    }
}