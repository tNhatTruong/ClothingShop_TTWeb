<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Thanh toán</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/checkout.css">
</head>

<body>

<jsp:include page="/views/layout/header.jsp"/>

<div id="checkout-checkout" class="container">
    <div class="row">
        <div id="content" class="col mt-5">
            <div class="row">
                <div class="col-md-7">
                    <div id="ckh_step_1">
                        <div id="checkout-shipping-address">
                            <fieldset>
                                <legend>Thông tin người dùng</legend>
                                <div id="shipping-existing" style="display: none;">
                                    <select name="address_id" id="input-shipping-address" class="form-select">
                                        <option>--- Vui lòng chọn ---</option>
                                    </select>
                                </div>
                                                              <div id="shipping-new">
                                    <form action="${root}/place-order" method="POST" autocomplete="off" id="form-shipping-address" class="section-shipping-address needs-validation" novalidate>
                                        <!-- Hidden parameters to retain checkout state upon validation failure -->
                                        <input type="hidden" name="isCartCheckout" value="${isCartCheckout}" />
                                        <input type="hidden" name="isBuyNow" value="${isBuyNow}" />
                                        <input type="hidden" name="variants" value="${param.variants}" />
                                        <input type="hidden" name="productName" value="${cName}" />
                                        <input type="hidden" name="productImage" value="${cImage}" />
                                        <input type="hidden" name="selectedSize" value="${cSize}" />
                                        <input type="hidden" name="selectedColor" value="${cColor}" />
                                        <input type="hidden" name="variantId" value="${cVariantId}" />
                                        <input type="hidden" name="productPrice" value="${cPrice}" />
                                        <input type="hidden" name="quantity" value="${cQty}" />
                                        <input type="hidden" name="payment_method" id="hidden-payment-method" value="vnpay" />

                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger mb-3" role="alert">
                                                ${errorMessage}
                                            </div>
                                        </c:if>

                                        <div class="row row-cols-1 row-cols-md-2">

                                            <div class="col mb-3 required order-1">
                                                <label for="input-shipping-firstname" class="form-label">Họ tên</label>
                                                <input type="text"
                                                       name="fullname"
                                                       value="${not empty fullname ? fullname : sessionScope.auth.user_name}"
                                                       placeholder="Họ tên" id="input-shipping-firstname"
                                                       class="form-control" required/>
                                                <div id="error-shipping-firstname" class="invalid-feedback">Vui lòng điền họ tên.</div>
                                            </div>

                                            <div class="col col-md-12 mb-3 required order-3">
                                                <label for="input-shipping-address-1" class="form-label">Địa chỉ</label>
                                                <input type="text"
                                                       name="address"
                                                       value="${not empty address ? address : (not empty userAddress ? userAddress.street : '')}"
                                                       placeholder="Địa chỉ" id="input-shipping-address-1"
                                                       class="form-control" required/>
                                                <div id="error-shipping-address-1" class="invalid-feedback">Vui lòng điền địa chỉ giao hàng.</div>
                                            </div>

                                            <div class="col mb-3 required d-none"></div>

                                            <div class="col mb-3 custom-field custom-field-29">
                                                <label for="input-shipping-custom-field-29" class="form-label">Điện thoại</label>
                                                <input type="text" autocomplete="off"
                                                       name="phone"
                                                       value="${not empty phone ? phone : sessionScope.auth.phone}"
                                                       placeholder="Điện thoại" id="input-shipping-custom-field-29"
                                                       class="form-control"
                                                       required
                                                       pattern="^(0|\+?84)[3|5|7|8|9][0-9]{8}$"
                                                       oninput="this.value = this.value.replace(/[^0-9+]/g, '');"/>
                                                <div id="error-shipping-custom-field-29" class="invalid-feedback">Số điện thoại không hợp lệ (Bắt đầu bằng 0 hoặc 84, theo sau là 9 chữ số).</div>
                                            </div>

                                            <div class="col col-md-12 mb-3 order-4"> <div class="row">
                                                <div class="col mb-3 required">
                                                    <label class="form-label" for="province">Tỉnh / thành phố</label>
                                                    <select id="province" name="city" class="form-select">
                                                        <option value="">-- Chọn Tỉnh / Thành phố --</option>
                                                    </select>
                                                    <div id="error-shipping-zone" class="invalid-feedback"></div>
                                                </div>

                                                <div class="col mb-3 custom-field custom-field-30 required">
                                                    <label class="form-label" for="district">Quận / Huyện</label>
                                                    <select id="district" name="district" class="form-select" disabled>
                                                        <option value="">-- Chọn Quận / Huyện --</option>
                                                    </select>
                                                    <div id="error-shipping-custom-field-30" class="invalid-feedback"></div>
                                                </div>

                                                <div class="col mb-3 custom-field required">
                                                    <label class="form-label" for="ward">Phường / Xã</label>
                                                    <select id="ward" name="ward" class="form-select" disabled>
                                                        <option value="">-- Chọn Phường / Xã --</option>
                                                    </select>
                                                </div>
                                            </div>
                                            </div>

                                            <div class="col mb-3 custom-field custom-field-31">
                                                <label for="input-shipping-custom-field-31" class="form-label">Ngày đặt hàng</label>
                                                <div class="input-group">
                                                    <input type="text" name="order_date" value="" placeholder="Ngày đặt hàng"
                                                           id="input-shipping-custom-field-31" class="form-control date"/>
                                                    <div class="input-group-text">
                                                        <i class="fa-regular fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col mb-3 custom-field custom-field-32">
                                                <label for="input-shipping-custom-field-32" class="form-label">Thời gian dự kiến</label>
                                                <select name="delivery_time" id="input-shipping-custom-field-32" class="form-select">
                                                    <option value="120">Từ 8:00 - 12:00</option>
                                                    <option value="121">Từ 12:00 - 20:00</option>
                                                    <option value="122">Từ 8:00 - 20:00</option>
                                                </select>
                                            </div>

                                            <div class="col col-md-12 mb-3 custom-field custom-field-33">
                                                <label for="input-shipping-custom-field-33" class="form-label">Ghi chú [Cho shop]</label>
                                                <textarea name="note" rows="2" placeholder="" id="input-shipping-custom-field-33"
                                                           class="form-control"></textarea>
                                            </div>

                                            <div class="col col-md-12 mb-3 custom-field custom-field-34">
                                                <label for="input-shipping-custom-field-34" class="form-label">Yêu cầu, lưu ý [cho shop]</label>
                                                <textarea name="request" rows="2" placeholder="" id="input-shipping-custom-field-34"
                                                           class="form-control"></textarea>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div id="checkout-confirm">
                        <legend>Chi tiết đơn hàng</legend>
                        <div class="order-summary">

                            <c:choose>
                                <%-- TRƯỜNG HỢP 1: THANH TOÁN TỪ GIỎ HÀNG (GET) --%>
                                <c:when test="${isCartCheckout}">
                                    <%-- Đã sửa thành .item theo đúng chuẩn của Cart.java --%>
                                    <c:forEach var="item" items="${checkoutItems}">
                                        <div class="d-flex align-items-center mb-3">
                                                <%-- Đã sửa lại đường dẫn lấy Ảnh --%>
                                            <img src="${pageContext.request.contextPath}${item.variant.product.safeThumbnail}"
                                                 alt="${item.variant.product.product_name}"
                                                 style="width: 80px; height: 100px; object-fit: cover;"
                                                 class="me-3 border">
                                            <div class="flex-grow-1">
                                                    <%-- Đã sửa lại đường dẫn lấy Tên --%>
                                                <h5 class="mb-0">${item.variant.product.product_name}</h5>

                                                    <%-- LƯU Ý: Chỗ size và màu này mình đang đoán tên biến.
                                                         Nếu trong class Variant của bạn thuộc tính tên khác (ví dụ: size_name, color_name),
                                                         hãy sửa lại cho đúng nhé! --%>
                                                <small class="text-muted">Size: ${item.variant.size} | Màu: ${item.variant.color}</small><br>

                                                <small class="text-muted">Số lượng: ${item.quantity}</small>
                                            </div>
                                            <div class="text-end">
                                                <strong>
                                                        <%-- Đã sửa lại đường dẫn lấy Giá tiền --%>
                                                    <fmt:formatNumber value="${item.variant.product.price * item.quantity}" type="number" groupingUsed="true"/>₫
                                                </strong>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <%-- TRƯỜNG HỢP 2: MUA NGAY 1 SẢN PHẨM (POST) --%>
                                <c:when test="${isBuyNow}">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="${pageContext.request.contextPath}${cImage}"
                                             alt="${cName}"
                                             style="width: 80px; height: 100px; object-fit: cover;"
                                             class="me-3 border">
                                        <div class="flex-grow-1">
                                            <h5 class="mb-0">${cName}</h5>
                                            <small class="text-muted">Size: ${cSize} | Màu: ${cColor}</small><br>
                                            <small class="text-muted">Số lượng: ${cQty}</small>
                                        </div>
                                        <div class="text-end">
                                            <strong>
                                                <fmt:formatNumber value="${cSubTotal}" type="number" groupingUsed="true"/>₫
                                            </strong>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>

                            <hr>
                            <div class="d-flex justify-content-between">
                                <span>Tạm tính</span>
                                <span id="sub-total-display" data-value="${cSubTotal}">
                                    <fmt:formatNumber value="${cSubTotal}" type="number" groupingUsed="true"/>₫
                                </span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Phí vận chuyển</span>
                                <span id="shipping-fee-display">
                                    <fmt:formatNumber value="${cShipping}" type="number" groupingUsed="true"/>₫
                                </span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center">
                                <h4 class="text-danger">Tổng cộng</h4>
                                <h3 class="text-primary" id="total-price-display">
                                    <fmt:formatNumber value="${cTotal}" type="number" groupingUsed="true"/>₫
                                </h3>
                            </div>

                            <div id="checkout-payment-method" class="mb-4">
                                <h4 class="payment-title">Phương thức thanh toán</h4>
                                <form id="form-payment-method">
                                    <fieldset>
                                        <div class="input-group">
                                            <div class="input-payment-method-group">

                                                <div class="form-check">
                                                    <input type="radio" name="payment_method" value="vnpay"
                                                           id="input-payment-method-vnpay"
                                                           class="form-check-input input-payment-method" checked="">
                                                    <label for="input-payment-method-vnpay" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/vnpay.png"> Thanh toán qua VNPay
                                                        <span class="payment-brand-icon-vnpay"></span>
                                                    </label>
                                                </div>

                                                <div class="form-check">
                                                    <input type="radio" name="payment_method" value="cod"
                                                           id="input-payment-method-cod"
                                                           class="form-check-input input-payment-method">
                                                    <label for="input-payment-method-cod" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/logothanhtoan.png"> Thanh toán khi giao hàng (COD)
                                                        <span class="payment-brand-icon-cod"></span>
                                                    </label>
                                                </div>

                                            </div>
                                            <button type="button" id="button-payment-method" class="btn btn-light d-none"><i class="fa-solid fa-rotate"></i></button>
                                        </div>
                                    </fieldset>
                                </form>

                                <div class="mb-2 mt-3">
                                    <div class="form-check text-end">
                                        <input type="checkbox" name="agree" value="1" id="input-agree" class="form-check-input" checked="">
                                        <label for="input-agree" class="form-check-label">Tôi đã đọc và đồng ý với
                                            <a href="#" class="modal-link"><b> Điều khoản &amp; Điều kiện </b></a>
                                        </label>
                                    </div>
                                </div>
                                <hr>
                                <div class="text-end">
                                    <button  type="button" id="validate_order" class="btn btn-primary">Xác nhận đơn hàng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp"/>

<script src="${root}/js/checkout.js"></script>
<script src="${root}/js/main.js"></script>
<script>
    var contextPath = "${root}";
</script>
<script>
    document.getElementById("validate_order").addEventListener("click", function () {
        const form = document.getElementById("form-shipping-address");
        if (form) {
            // Update hidden payment_method value before submitting
            const selectedPayment = document.querySelector('input[name="payment_method"]:checked');
            const hiddenPayment = document.getElementById("hidden-payment-method");
            if (selectedPayment && hiddenPayment) {
                hiddenPayment.value = selectedPayment.value;
            }

            if (form.checkValidity() === false) {
                form.classList.add('was-validated');
                // Scroll to the first invalid element
                const firstInvalid = form.querySelector(':invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            } else {
                form.submit();
            }
        }
    });
</script>
</body>
</html>