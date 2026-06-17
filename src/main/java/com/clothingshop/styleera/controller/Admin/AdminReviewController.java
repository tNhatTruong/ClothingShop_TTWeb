package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.Review;
import com.clothingshop.styleera.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminReviewController", urlPatterns = "/admin-reviews")
public class AdminReviewController extends HttpServlet {

    private ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ratingFilter = request.getParameter("ratingFilter");
        String dateSort = request.getParameter("dateSort");

        List<Review> list = reviewService.getFilteredReviews(ratingFilter, dateSort);

        request.setAttribute("reviewList", list);
        request.setAttribute("totalReviews", list.size());

        // Forward sang JSP
        request.getRequestDispatcher("/admin/admin-user-comment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            String adminReply = request.getParameter("adminReply");

            reviewService.updateAdminReply(reviewId, adminReply);

            if ("true".equals(request.getParameter("ajax"))) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Đã gửi phản hồi thành công!\"}");
                return;
            }

            request.getSession().setAttribute("successMessage", "Đã gửi phản hồi thành công!");
            response.sendRedirect(request.getContextPath() + "/admin-reviews");
        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(request.getParameter("ajax"))) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Có lỗi xảy ra khi gửi phản hồi.\"}");
                return;
            }
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi gửi phản hồi.");
            response.sendRedirect(request.getContextPath() + "/admin-reviews");
        }
    }
}