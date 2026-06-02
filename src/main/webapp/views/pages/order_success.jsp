<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
                <div class="order-id" id="orderId">Mã đơn hàng: #${order.id}</div>
                <div class="note">Ngày đặt: 
                    <span id="orderDate">
                        <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                        <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${parsedDate}" />
                    </span>
                </div>
            </div>
            <div class="order-actions">
                <button class="btn" id="viewOrderBtn">
                    <a href="${root}/order-status" style="color:white; text-decoration:none;">Xem lịch sử đơn</a>
                </button>
            </div>
        </div>

        <section class="section">
            <h4>Thông tin giao hàng</h4>
            <div class="info-grid">
                <div class="info-box">
                    <div class="info-label">Tên người nhận</div>
                    <div class="info-val" id="shipName">${order.shippingName}</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Số điện thoại</div>
                    <div class="info-val" id="shipPhone">${order.shippingPhone}</div>
                </div>
                <div class="info-box" style="grid-column:1 / -1;">
                    <div class="info-label">Địa chỉ</div>
                    <div class="info-val" id="shipAddress">${order.shippingAddress}</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Trạng thái thanh toán</div>
                    <div class="info-val" style="color: #ff6f61; font-weight: bold;">
                        ${order.status}
                    </div>
                </div>
                <div class="info-box">
                    <div class="info-label">Phương thức thanh toán</div>
                    <div class="info-val" id="payMethod">
                        <c:choose>
                            <c:when test="${order.status == 'Đã Thanh Toán'}">
                                Thanh toán qua VNPAY
                            </c:when>
                            <c:otherwise>
                                Thanh toán khi nhận hàng (COD)
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <h4>Ghi chú từ khách hàng</h4>
            <div class="info-box" style="min-height:64px">${not empty order.note ? order.note : "Không có ghi chú"}</div>
        </section>

    </main>

    <aside class="summary-card" aria-labelledby="summaryTitle">
        <div class="summary-title" id="summaryTitle">Chi tiết đơn hàng</div>

        <c:forEach var="item" items="${details}">
            <c:set var="variant" value="${variantMap[item.variant_id]}" />
            <div class="product-row">
                <img src="${root}${variant.product.thumbnail}" alt="${variant.product.product_name}">
                <div style="flex:1">
                    <div class="prod-name">${variant.product.product_name}</div>
                    <div class="prod-meta">Size ${variant.size} • Màu: ${variant.color}</div>
                </div>
                <div style="text-align:right">
                    <div style="font-weight:600"><fmt:formatNumber value="${item.price}" type="number" maxFractionDigits="0"/>đ</div>
                    <div class="prod-meta">SL: ${item.quantity}</div>
                </div>
            </div>
        </c:forEach>
        
        <hr>
        <div class="price-row">
            <div>Tạm tính</div>
            <div><fmt:formatNumber value="${order.price}" type="number" maxFractionDigits="0"/>đ</div>
        </div>
        <div class="price-row">
            <div>Phí vận chuyển</div>
            <div><fmt:formatNumber value="${order.feeDelivery}" type="number" maxFractionDigits="0"/>đ</div>
        </div>
        <hr>
        <div class="total">
            <div style="font-weight:800;font-size: 20px; color: #ff6f61;">Tổng cộng</div>
            <div class="num"><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0"/>đ</div>
        </div>

        <div style="display:flex;gap:10px;margin-top:14px;flex-direction: row-reverse;">
            <button class="btn" onclick="location.href='${root}/home'">Tiếp tục mua sắm</button>
        </div>

    </aside>

</div>

<jsp:include page="/views/layout/footer.jsp" />

<script src="../../js/checkout.js"></script>
<script src="../../js/main.js"></script>
</body>

</html>