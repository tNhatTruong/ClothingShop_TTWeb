package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.User;
import com.clothingshop.styleera.service.ReviewService;
import com.clothingshop.styleera.util.SessionManage;
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

        // Lấy user đang đăng nhập từ Session (Hỗ trợ cả Google Login)
        User user = SessionManage.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy dữ liệu từ thẻ input hidden và textarea trong form JSP
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            String isEdit = request.getParameter("isEdit");

            // Lấy ID của người dùng đang đăng nhập
            int userId = user.getId();

            if ("true".equals(isEdit)) {
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                reviewService.updateReviewByUser(reviewId, rating, comment);
            } else {
                // Kiểm tra lại lần nữa phòng trường hợp F5 gửi đúp form
                if (reviewService.checkIfReviewed(orderId, productId, userId) == null) {
                    reviewService.insertReview(orderId, productId, userId, rating, comment);
                }
            }

            if ("true".equals(request.getParameter("ajax"))) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Đánh giá của bạn đã được ghi nhận!\"}");
                return;
            }

            // Redirect về trang chi tiết sản phẩm kèm thông báo
            session.setAttribute("successMessage", "Đánh giá của bạn đã được ghi nhận!");
            response.sendRedirect(request.getContextPath() + "/order_status?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(request.getParameter("ajax"))) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Đã xảy ra lỗi khi lưu đánh giá.\"}");
                return;
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi lưu đánh giá.");
        }
    }
}