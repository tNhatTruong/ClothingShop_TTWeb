<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Đánh giá sản phẩm</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/review.css">
</head>
<body>
<jsp:include page="/views/layout/header.jsp" />

<div class="review-container">
    <h2>Đánh giá sản phẩm</h2>

    <!-- Chọn sao -->
    <div class="rating-section">
        <label>Chất lượng sản phẩm</label>
        <div class="stars">
            <span class="star" data-value="1">&#9733;</span>
            <span class="star" data-value="2">&#9733;</span>
            <span class="star" data-value="3">&#9733;</span>
            <span class="star" data-value="4">&#9733;</span>
            <span class="star" data-value="5">&#9733;</span>
        </div>
    </div>

    <!-- Màu sắc -->
    <div class="input-group">
        <label>Màu sắc</label>
        <select id="color">
            <option value="Đen">Đen</option>
            <option value="Trắng">Trắng</option>
            <option value="Xám">Đỏ</option>
            <option value="Xanh Navy">Xanh</option>
        </select>
    </div>

    <!-- Size -->
    <div class="input-group">
        <label>Size</label>
        <select id="size">
            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
            <option value="XL">XXL</option>
        </select>
    </div>

    <!-- Ghi chú -->
    <div class="input-group">
        <label>Ghi chú</label>
        <textarea id="note" placeholder="Hãy chia sẻ cảm nhận của bạn..."></textarea>
    </div>

    <!-- Tải ảnh -->
    <div class="input-group">
        <label>Ảnh sản phẩm</label>
        <input type="file" id="images" multiple accept="image/*">
        <div id="preview"></div>
    </div>

    <!-- Submit -->
    <button class="btn-submit">Gửi đánh giá</button>
    <!-- Popup thông báo thành công -->
    <div class="success-popup" id="successPopup">
        <div class="popup-box">
            <h3>Gửi đánh giá thành công!</h3>
            <p>Cảm ơn bạn đã chia sẻ trải nghiệm.</p>
            <button id="closePopup" onclick="location.href='index.html'">Đóng</button>

        </div>
    </div>

</div>

<jsp:include page="/views/layout/footer.jsp" />

<script src="${root}/js/review.js"></script>
</body>
</html>
