package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response, true);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        processRequest(request, response, false);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response, boolean isGet) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // --- CODE MỚI: Load địa chỉ mặc định ---
        AddressDAO addressDAO = new AddressDAO();
        Address userAddress = addressDAO.findAddressByUserId(user.getId());
        if (userAddress != null) {
            request.setAttribute("userAddress", userAddress);
        }
        // ---------------------------------------

        if (isGet) {
            // Logic cho GET (Giỏ hàng)
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.getItem().size() == 0) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Lọc các sản phẩm được chọn để thanh toán
            String variantIdsStr = request.getParameter("variants");
            java.util.List<com.clothingshop.styleera.model.CartItem> checkoutItems = new java.util.ArrayList<>();
            double subTotal = 0;
            if (variantIdsStr != null && !variantIdsStr.trim().isEmpty()) {
                String[] selectedIds = variantIdsStr.split(",");
                java.util.Set<String> selectedIdSet = new java.util.HashSet<>(java.util.Arrays.asList(selectedIds));
                for (com.clothingshop.styleera.model.CartItem item : cart.getItem()) {
                    if (selectedIdSet.contains(String.valueOf(item.getVariant().getVariantId()))) {
                        checkoutItems.add(item);
                        subTotal += item.getVariant().getProduct().getPrice() * item.getQuantity();
                    }
                }
                // Nếu sau khi lọc mà không có sản phẩm nào hợp lệ, quay về giỏ hàng
                if (checkoutItems.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
            } else {
                // Bảo mật (Issue 31, 34): Không cho phép thanh toán nếu không có sản phẩm nào được chọn (tham số variants rỗng)
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            double shipping = 30000.0;
            request.setAttribute("checkoutItems", checkoutItems);
            request.setAttribute("cSubTotal", subTotal);
            request.setAttribute("cShipping", shipping);
            request.setAttribute("cTotal", subTotal + shipping);
            request.setAttribute("isCartCheckout", true);
        } else {
            // Logic cho POST (Mua ngay)
            try {
                String name = request.getParameter("productName");
                String image = request.getParameter("productImage");
                String size = request.getParameter("selectedSize");
                String color = request.getParameter("selectedColor");
                String variantId = request.getParameter("variantId");

                // Lấy giá thực tế từ Database (Bảo mật)
                com.clothingshop.styleera.dao.VariantDAO variantDAO = new com.clothingshop.styleera.dao.VariantDAO();
                com.clothingshop.styleera.model.Variants variant = variantDAO.getById(Integer.parseInt(variantId));
                double price = (variant != null) ? variant.getProduct().getPrice() : 0.0;

                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double subTotal = price * quantity;
                double shipping = 30000.0;

                request.setAttribute("cName", name);
                request.setAttribute("cImage", image);
                request.setAttribute("cSize", size);
                request.setAttribute("cColor", color);
                request.setAttribute("cQty", quantity);
                request.setAttribute("cPrice", price);
                request.setAttribute("cVariantId", variantId);
                request.setAttribute("cSubTotal", subTotal);
                request.setAttribute("cShipping", shipping);
                request.setAttribute("cTotal", subTotal + shipping);
                request.setAttribute("isBuyNow", true);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        }

        request.getRequestDispatcher("/views/pages/checkout.jsp").forward(request, response);
    }
}