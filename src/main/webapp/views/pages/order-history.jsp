<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Lịch sử</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/order-history.css">
</head>

<body>
<!-- ===== HEADER ===== -->
<jsp:include page="/views/layout/header.jsp" />

<!-- ===== MAIN CONTENT ===== -->
<main class="orders-history py-5" style="background: #f5f0e6;">
    <div class="container">
        <!-- Page Header -->
        <div class="text-center mb-5">
            <h1 class="fw-bold" style="color: #212121;">Lịch sử đơn hàng</h1>
            <p class="text-muted">Xem lại các đơn hàng bạn đã đặt trước đây</p>
        </div>

        <!-- Orders Table -->
        <div class="table-responsive">
            <table class="orders-table">
                <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Hình ảnh</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <!-- Đơn hàng 1 -->
                <tr class="order-row">
                    <td>ORD12345</td>
                    <td>16/11/2025</td>
                    <td><img src="../../images/category-banner/category/man/ao-thun-nam.png" alt="Áo thun nam"
                             class="order-product-img"></td>
                    <td>Hoàn tất</td>
                    <td>
                        <button class="btn-primary btn-view-details">Xem chi tiết</button>
                        <button class="btn-secondary btn-reorder">Mua lại</button>
                        <button class="btn-secondary btn-reorder" onclick="location.href='review.jsp'">Đánh giá</button>
                    </td>
                </tr>
                <tr class="order-details" style="display: none;">
                    <td colspan="5">
                        <div class="details-content">
                            <p>Sản phẩm: Áo thun nam</p>
                            <p>Số lượng: 2</p>
                            <p>Tổng tiền: 500.000đ</p>
                        </div>
                    </td>
                </tr>

                <!-- Đơn hàng 2 -->
                <tr class="order-row">
                    <td>ORD12346</td>
                    <td>15/11/2025</td>
                    <td><img src="../../images/category-banner/category/man/quan-jean-nam.png" alt="Quần Jean nam"
                             class="order-product-img"></td>
                    <td>Đang giao</td>
                    <td>
                        <button class="btn-primary btn-view-details">Xem chi tiết</button>
                        <button class="btn-secondary btn-reorder">Mua lại</button>
                        <button class="btn-secondary btn-reorder" onclick="location.href='review.jsp'">Đánh giá</button>
                    </td>
                </tr>
                <tr class="order-details" style="display: none;">
                    <td colspan="5">
                        <div class="details-content">
                            <p>Sản phẩm: Quần Jean nam</p>
                            <p>Số lượng: 1</p>
                            <p>Tổng tiền: 350.000đ</p>
                        </div>
                    </td>
                </tr>

                <!-- Đơn hàng 3 -->
                <tr class="order-row">
                    <td>ORD12347</td>
                    <td>12/11/2025</td>
                    <td><img src="../../images/category-banner/category/woman/vay-nu.png" alt="Váy nữ"
                             class="order-product-img"></td>
                    <td>Hoàn tất</td>
                    <td>
                        <button class="btn-primary btn-view-details">Xem chi tiết</button>
                        <button class="btn-secondary btn-reorder">Mua lại</button>
                        <button class="btn-secondary btn-reorder" onclick="location.href='review.jsp'">Đánh giá</button>
                    </td>
                </tr>
                <tr class="order-details" style="display: none;">
                    <td colspan="5">
                        <div class="details-content">
                            <p>Sản phẩm: Váy nữ</p>
                            <p>Số lượng: 1</p>
                            <p>Tổng tiền: 450.000đ</p>
                        </div>
                    </td>
                </tr>

                <!-- Đơn hàng 4 -->
                <tr class="order-row">
                    <td>ORD12348</td>
                    <td>10/11/2025</td>
                    <td><img src="../../images/category-banner/category/man/ao-khoac-nam.png" alt="Áo khoác nam"
                             class="order-product-img"></td>
                    <td>Đang xử lý</td>
                    <td>
                        <button class="btn-primary btn-view-details">Xem chi tiết</button>
                        <button class="btn-secondary btn-reorder">Mua lại</button>
                        <button class="btn-secondary btn-reorder" onclick="location.href='review.jsp'">Đánh giá</button>
                    </td>
                </tr>
                <tr class="order-details" style="display: none;">
                    <td colspan="5">
                        <div class="details-content">
                            <p>Sản phẩm: Áo khoác nam</p>
                            <p>Số lượng: 1</p>
                            <p>Tổng tiền: 600.000đ</p>
                        </div>
                    </td>
                </tr>

                <!-- Đơn hàng 5 -->
                <tr class="order-row">
                    <td>ORD12349</td>
                    <td>08/11/2025</td>
                    <td><img src="../../images/category-banner/category/woman/ao-polo-nu.png" alt="Áo Polo nữ"
                             class="order-product-img"></td>
                    <td>Hoàn tất</td>
                    <td>
                        <button class="btn-primary btn-view-details">Xem chi tiết</button>
                        <button class="btn-secondary btn-reorder">Mua lại</button>
                        <button class="btn-secondary btn-reorder" onclick="location.href='review.jsp'">Đánh giá</button>
                    </td>
                </tr>
                <tr class="order-details" style="display: none;">
                    <td colspan="5">
                        <div class="details-content">
                            <p>Sản phẩm: Áo Polo nữ</p>
                            <p>Số lượng: 2</p>
                            <p>Tổng tiền: 700.000đ</p>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- No Orders Message (if empty) -->
        <div class="text-center mt-5 d-none" id="no-orders-msg">
            <p class="text-muted fs-5">Bạn chưa có đơn hàng nào.</p>
        </div>
    </div>
</main>


<!-- ===== FOOTER ===== -->
<jsp:include page="/views/layout/footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script src="../../js/main.js"></script>
<script src="../../js/order-history.js"></script>
</body>
</html>