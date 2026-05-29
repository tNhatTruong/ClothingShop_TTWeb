package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.ReviewDAO;
import com.clothingshop.styleera.model.Review;
import java.util.List;

public class ReviewService {

    private ReviewDAO reviewDao;

    public ReviewService() {
        this.reviewDao = new ReviewDAO();
    }

    // Hàm lấy danh sách đánh giá
    public List<Review> getReviewsByProductId(int productId) {
        return reviewDao.findByProductId(productId);
    }

    public void insertReview(int productId, int userId, int rating, String comment) {
        reviewDao.insertReview(productId, userId, rating, comment);
    }
}