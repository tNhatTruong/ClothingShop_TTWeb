package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.model.Address;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/place-order")
public class PlaceOrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullname == null || fullname.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin Họ tên, Số điện thoại và Địa chỉ!");
            setupCheckoutAttributes(request);
            request.getRequestDispatcher("/views/pages/checkout.jsp").forward(request, response);
            return;
        }

        String phoneRegex = "^(03|05|07|08|09)\\d{8}$";
        if (!phone.matches(phoneRegex)) {
            request.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập đúng định dạng 10 chữ số và bắt đầu bằng 03, 05, 07, 08 hoặc 09.");
            setupCheckoutAttributes(request);
            request.getRequestDispatcher("/views/pages/checkout.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/order-success");
    }

    private void setupCheckoutAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        double subTotal = (cart != null) ? cart.total() : 0.0;
        double shipping = 30000.0;
        request.setAttribute("cSubTotal", subTotal);
        request.setAttribute("cShipping", shipping);
        request.setAttribute("cTotal", subTotal + shipping);
        request.setAttribute("isCartCheckout", true);

        User user = (User) session.getAttribute("auth");
        if (user != null) {
            AddressDAO addressDAO = new AddressDAO();
            Address userAddress = addressDAO.findAddressByUserId(user.getId());
            if (userAddress != null) {
                request.setAttribute("userAddress", userAddress);
            }
        }
    }
}