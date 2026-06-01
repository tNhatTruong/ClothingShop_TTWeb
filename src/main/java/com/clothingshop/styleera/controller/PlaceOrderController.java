package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.Cart;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/place-order")
public class PlaceOrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Xử lý Font chữ tiếng Việt
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin giao hàng từ request
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // 2. Server-side Validation
        boolean isValid = true;
        String errorMsg = null;

        if (fullname == null || fullname.trim().isEmpty()) {
            isValid = false;
            errorMsg = "Họ tên không được để trống!";
        } else if (address == null || address.trim().isEmpty()) {
            isValid = false;
            errorMsg = "Địa chỉ giao hàng không được để trống!";
        } else if (phone == null || phone.trim().isEmpty()) {
            isValid = false;
            errorMsg = "Số điện thoại không được để trống!";
        } else {
            // Khớp với pattern ở frontend: bắt đầu bằng 0 hoặc 84 hoặc +84, sau đó là 3,5,7,8,9 và 8 chữ số
            String phoneRegex = "^(0|\\+?84)[35789][0-9]{8}$";
            if (!phone.matches(phoneRegex)) {
                isValid = false;
                errorMsg = "Số điện thoại không đúng định dạng Việt Nam! Vui lòng kiểm tra lại.";
            }
        }

        if (!isValid) {
            // Xử lý khi có lỗi (Error Handling): Lưu lại thông báo lỗi và dữ liệu người dùng nhập
            request.setAttribute("errorMessage", errorMsg);
            request.setAttribute("fullname", fullname);
            request.setAttribute("address", address);
            request.setAttribute("phone", phone);

            // Nạp lại địa chỉ mặc định của người dùng
            AddressDAO addressDAO = new AddressDAO();
            Address userAddress = addressDAO.findAddressByUserId(user.getId());
            if (userAddress != null) {
                request.setAttribute("userAddress", userAddress);
            }

            // Phân biệt luồng: Cart checkout vs Buy Now checkout để nạp lại đúng sản phẩm
            boolean isBuyNow = "true".equals(request.getParameter("isBuyNow"));

            if (!isBuyNow) {
                // Phục hồi giỏ hàng
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }

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
                }
                
                if (checkoutItems.isEmpty()) {
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
                // Phục hồi Buy Now
                try {
                    String name = request.getParameter("productName");
                    String image = request.getParameter("productImage");
                    String size = request.getParameter("selectedSize");
                    String color = request.getParameter("selectedColor");
                    String variantId = request.getParameter("variantId");
                    double price = Double.parseDouble(request.getParameter("productPrice"));
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

            // Forward ngược lại checkout.jsp mà không đổi URL, giữ nguyên thông tin
            request.getRequestDispatcher("/views/pages/checkout.jsp").forward(request, response);
            return;
        }

        // Nếu validation thành công, tạo đơn hàng và lưu vào DB
        try {
            com.clothingshop.styleera.dao.OrdersDAO ordersDAO = new com.clothingshop.styleera.dao.OrdersDAO();
            com.clothingshop.styleera.dao.OrderDetailsDAO orderDetailsDAO = new com.clothingshop.styleera.dao.OrderDetailsDAO();
            com.clothingshop.styleera.dao.VariantDAO variantDAO = new com.clothingshop.styleera.dao.VariantDAO();
            com.clothingshop.styleera.dao.CartDao cartDao = new com.clothingshop.styleera.dao.CartDao();

            boolean isBuyNow = "true".equals(request.getParameter("isBuyNow"));
            
            // Xử lý tạo Order
            com.clothingshop.styleera.model.Orders order = new com.clothingshop.styleera.model.Orders();
            order.setUserId(user.getId());
            // Tạm thời lấy default address ID, có thể sửa nếu form cho chọn Address
            AddressDAO addressDAO = new AddressDAO();
            Address userAddress = addressDAO.findAddressByUserId(user.getId());
            order.setAddressId(userAddress != null ? userAddress.getId() : 0);
            order.setStatus("PENDING");
            order.setNote("");
            
            double shipping = 30000.0;
            order.setFeeDelivery(shipping);
            
            if (!isBuyNow) {
                // Xử lý Cart
                Cart cart = (Cart) session.getAttribute("cart");
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
                }
                
                if (checkoutItems.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
                
                order.setPrice(subTotal);
                order.setTotalPrice(subTotal + shipping);
                
                int orderId = ordersDAO.insertOrder(order);
                
                // Lưu OrderDetails và trừ Tồn kho, Xóa giỏ hàng
                for (com.clothingshop.styleera.model.CartItem item : checkoutItems) {
                    int variantId = item.getVariant().getVariantId();
                    int qty = item.getQuantity();
                    double price = item.getVariant().getProduct().getPrice();
                    
                    com.clothingshop.styleera.model.OrderDetail detail = new com.clothingshop.styleera.model.OrderDetail(0, orderId, variantId, qty, price);
                    orderDetailsDAO.insertOrderDetail(detail);
                    variantDAO.updateStock(variantId, qty);
                    
                    // Xóa item trong DB giỏ hàng và trong đối tượng Cart session
                    cartDao.removeCartItem(user.getId(), variantId);
                    cart.removeItem(variantId);
                }
            } else {
                // Xử lý Buy Now
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                
                // Tránh lộ hổng F12 đổi giá: Lấy giá gốc từ DB
                com.clothingshop.styleera.model.Variants variantInfo = variantDAO.getById(variantId);
                double realPrice = variantInfo.getProduct().getPrice();
                double subTotal = realPrice * quantity;
                
                order.setPrice(subTotal);
                order.setTotalPrice(subTotal + shipping);
                
                int orderId = ordersDAO.insertOrder(order);
                
                com.clothingshop.styleera.model.OrderDetail detail = new com.clothingshop.styleera.model.OrderDetail(0, orderId, variantId, quantity, realPrice);
                orderDetailsDAO.insertOrderDetail(detail);
                variantDAO.updateStock(variantId, quantity);
            }
            
            // Chuyển hướng đến trang hoàn tất đặt hàng
            response.sendRedirect(request.getContextPath() + "/order-success");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đặt hàng: " + e.getMessage());
            request.getRequestDispatcher("/views/pages/checkout.jsp").forward(request, response);
        }
    }
}