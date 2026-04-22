<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>StyleEra - Thành công</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/oder_success.css">
</head>

<body>
<jsp:include page="/views/layout/header.jsp" />

<div class="page-wrap">
    <main class="success-card" role="main">
        <div class="success-header">
            <div class="tick-wrap" aria-hidden="true">
          <span class="tick">
            <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path d="M4 12l4 4L20 6"></path>
            </svg>
          </span>
            </div>
            <div>
                <h1 class="success-title">Bạn đã đặt hàng thành công!</h1>
                <p class="success-sub">Cảm ơn bạn đã mua sắm tại <strong>StyleEra</strong>. Đơn hàng của bạn đang được
                    xử lý.
                </p>
            </div>
        </div>

        <div class="order-meta">
            <div>
                <div class="order-id" id="orderId">Mã đơn hàng: #985723</div>
                <div class="note">Ngày đặt: <span id="orderDate">14/11/2025</span></div>
            </div>
            <div class="order-actions">
                <button class="btn" id="viewOrderBtn">
                    <a href="order_status.jsp">Xem đơn hàng</a>
                </button>

            </div>
        </div>

        <section class="section">
            <h4>Thông tin giao hàng</h4>
            <div class="info-grid">
                <div class="info-box">
                    <div class="info-label">Tên</div>
                    <div class="info-val" id="shipName">Lê Tấn Thành</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Số điện thoại</div>
                    <div class="info-val" id="shipPhone">0339378036</div>
                </div>
                <div class="info-box" style="grid-column:1 / -1;">
                    <div class="info-label">Địa chỉ</div>
                    <div class="info-val" id="shipAddress">ktx khu B, Đông Hòa, Dĩ An, Bình Dương</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Thời gian dự kiến giao</div>
                    <div class="info-val" id="shipETA">Từ 8:00 - 12:00, 16/11/2025</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Phương thức thanh toán</div>
                    <div class="info-val" id="payMethod">Thanh toán khi giao hàng</div>
                </div>
            </div>
        </section>

        <section class="section">
            <h4>Ghi chú</h4>
            <div class="info-box" style="min-height:64px"></div>
        </section>

    </main>

    <aside class="summary-card" aria-labelledby="summaryTitle">
        <div class="summary-title" id="summaryTitle">Chi tiết đơn hàng</div>

        <div class="product-row">
            <img src="../../images/image_product/quanjeans_checkout.png" alt="Quần jeans nam đen basic">
            <div style="flex:1">
                <div class="prod-name">Quần jeans nam đen basic</div>
                <div class="prod-meta">Size M • Màu: Đen</div>
            </div>
            <div style="text-align:right">
                <div style="font-weight:600">470.000đ</div>
                <div class="prod-meta">SL: 1</div>
            </div>
        </div>
        <hr>
        <div class="price-row">
            <div>Tạm tính</div>
            <div>470.000đ</div>
        </div>
        <div class="price-row">
            <div>Phí vận chuyển</div>
            <div>30.000đ</div>
        </div>
        <hr>
        <div class="total">
            <div style="font-weight:800;font-size: 20px; color: #ff6f61;">Tổng cộng</div>
            <div class="num">500.000đ</div>
        </div>

        <div class="payment-method">
            <h4 style="margin:10px 0 8px 0">Phương thức thanh toán</h4>
            <div class="pm-item"><img src="../../images/image_product/logoNH.png" alt="bank">
                <div>Chuyển khoản ngân hàng</div>
            </div>
            <div class="pm-item"><img src="../../images/image_product/momo.png" alt="momo">
                <div>Ví điện tử Momo</div>
            </div>
            <div class="pm-item"><img src="../../images/image_product/visa.png" alt="visa">
                <div>Thẻ Visa</div>
            </div>
            <div class="pm-item"><img src="../../images/image_product/logothanhtoan.png" alt="cod">
                <div>Thanh toán khi giao hàng</div>
            </div>
        </div>

        <div style="display:flex;gap:10px;margin-top:14px;flex-direction: row-reverse;">
            <button class="btn" onclick="location.href='index.html'">Tiếp tục mua sắm</button>
        </div>

    </aside>

</div>

<jsp:include page="/views/layout/footer.jsp" />

<script src="../../js/checkout.js"></script>
<script src="../../js/main.js"></script>
</body>

</html>