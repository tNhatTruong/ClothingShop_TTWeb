package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.AddressDAO;
import com.clothingshop.styleera.dao.UserDAO;
import com.clothingshop.styleera.model.Address;
import com.clothingshop.styleera.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminProfileController", urlPatterns = "/admin-profile")
public class AdminProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("auth") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy địa chỉ của Admin từ DB
        AddressDAO addressDAO = new AddressDAO();
        Address userAddress = addressDAO.findAddressByUserId(currentUser.getId());

        // Gửi sang JSP
        if (userAddress != null) {
            request.setAttribute("userAddress", userAddress);
        }

        request.getRequestDispatcher("admin/admin-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("auth") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");

        // Lấy thông tin địa chỉ
        String street = request.getParameter("address"); // Địa chỉ cụ thể
        String city = request.getParameter("city");      // Tỉnh/Thành (Tên tiếng Việt)
        String district = request.getParameter("district"); // Quận/Huyện (Tên tiếng Việt)

        try {
            // 1. Cập nhật User (Tên, SĐT)
            UserDAO userDAO = new UserDAO();
            userDAO.updateProfile(currentUser.getId(), fullName, phone);

            // 2. Cập nhật Địa chỉ (Bảng addresses)
            if (street != null || city != null || district != null) {
                AddressDAO addressDAO = new AddressDAO();
                addressDAO.saveOrUpdate(currentUser.getId(), street != null ? street : "", city != null ? city : "", district != null ? district : "");
            }

            // 3. Cập nhật Session
            currentUser.setUser_name(fullName);
            currentUser.setPhone(phone);
            session.setAttribute("auth", currentUser);

            session.setAttribute("successMsg", "Cập nhật hồ sơ cá nhân thành công!");
            response.sendRedirect(request.getContextPath() + "/admin-profile");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật: " + e.getMessage());
            
            // Tải lại địa chỉ hiện tại để hiển thị lại form nếu có lỗi
            AddressDAO addressDAO = new AddressDAO();
            Address userAddress = addressDAO.findAddressByUserId(currentUser.getId());
            if (userAddress != null) {
                request.setAttribute("userAddress", userAddress);
            }
            
            request.getRequestDispatcher("admin/admin-profile.jsp").forward(request, response);
        }
    }
}
