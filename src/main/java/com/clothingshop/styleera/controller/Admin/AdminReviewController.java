package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ReviewDAO;
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
}