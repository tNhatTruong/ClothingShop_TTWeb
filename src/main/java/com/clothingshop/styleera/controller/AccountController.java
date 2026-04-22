package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.util.SessionManage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/account")
public class AccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = SessionManage.getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy địa chỉ từ DB
        AddressDAO addressDAO = new AddressDAO();
        Address userAddress = addressDAO.findAddressByUserId(currentUser.getId());

        // Gửi sang JSP
        if (userAddress != null) {
            request.setAttribute("userAddress", userAddress);
        }

        request.getRequestDispatcher("/views/pages/account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User currentUser = SessionManage.getCurrentUser(request);

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");

        // Lấy thông tin địa chỉ
        String street = request.getParameter("address"); // Địa chỉ cụ thể
        String city = request.getParameter("city");      // Tỉnh/Thành (ID hoặc Tên)
        String district = request.getParameter("district"); // Quận/Huyện


        try {
            // 1. Cập nhật User (Tên, SĐT)
            UserDAO userDAO = new UserDAO();
            userDAO.updateProfile(currentUser.getId(), fullName, phone);

            // 2. Cập nhật Địa chỉ (Bảng addresses)
            if (street != null || city != null) {
                AddressDAO addressDAO = new AddressDAO();
                addressDAO.saveOrUpdate(currentUser.getId(), street, city, district);
            }

            // 3. Update Session
            currentUser.setUser_name(fullName);
            currentUser.setPhone(phone);
            request.getSession().setAttribute("auth", currentUser);

            request.getSession().setAttribute("successMsg", "Cập nhật hồ sơ thành công!");
            response.sendRedirect(request.getContextPath() + "/account");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/pages/account.jsp").forward(request, response);
        }
    }
}