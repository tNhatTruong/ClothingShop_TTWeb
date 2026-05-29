package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "SubmitReviewController", urlPatterns = {"/submit_review"})
public class SubmitReviewController extends HttpServlet {

    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        this.reviewService = new ReviewService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        // Lấy user đang đăng nhập từ Session.
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy dữ liệu từ thẻ input hidden và textarea trong form JSP
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            // Lấy ID của người dùng đang đăng nhập
            int userId = user.getId();

            // Gọi service lưu xuống Database
            reviewService.insertReview(productId, userId, rating, comment);

            response.sendRedirect(request.getContextPath() + "/product_detail?id=" + productId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi lưu đánh giá.");
        }
    }
}