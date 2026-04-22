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
                                <br/>
                                <div id="shipping-new">
                                    <form autocomplete="off" id="form-shipping-address" class="section-shipping-address">
                                        <div class="row row-cols-1 row-cols-md-2">

                                            <div class="col mb-3 required order-1">
                                                <label for="input-shipping-firstname" class="form-label">Họ tên</label>
                                                <input type="text"
                                                       name="fullname"
                                                       value="${sessionScope.auth.user_name}"
                                                       placeholder="Họ tên" id="input-shipping-firstname"
                                                       class="form-control"/>
                                                <div id="error-shipping-firstname" class="invalid-feedback"></div>
                                            </div>

                                            <div class="col col-md-12 mb-3 required order-3">
                                                <label for="input-shipping-address-1" class="form-label">Địa chỉ</label>
                                                <input type="text"
                                                       name="address"
                                                       value="${userAddress.street}"
                                                       placeholder="Địa chỉ" id="input-shipping-address-1"
                                                       class="form-control"/>
                                                <div id="error-shipping-address-1" class="invalid-feedback"></div>
                                            </div>

                                            <div class="col mb-3 required d-none"></div>

                                            <div class="col mb-3 required">
                                                <label class="form-label">Tỉnh / thành phố</label>
                                                <select id="input-shipping-zone" class="form-select" data-selected="${userAddress.province}">
                                                    <option value="0">Vui lòng chọn tỉnh/thành phố</option>
                                                    <option value="43">TP.Hồ Chí Minh - Nội thành</option>
                                                    <option value="44">TP.Hồ Chí Minh - Ngoại thành</option>
                                                </select>
                                                <input type="hidden" name="city" id="hidden-city-name" value="${userAddress.province}">
                                                <div id="error-shipping-zone" class="invalid-feedback"></div>
                                            </div>

                                            <div class="col mb-3 custom-field custom-field-29">
                                                <label for="input-shipping-custom-field-29" class="form-label">Điện thoại</label>
                                                <input type="text" autocomplete="off"
                                                       name="phone"
                                                       value="${sessionScope.auth.phone}"
                                                       placeholder="Điện thoại" id="input-shipping-custom-field-29"
                                                       class="form-control"/>
                                                <div id="error-shipping-custom-field-29" class="invalid-feedback"></div>
                                            </div>

                                            <div class="col mb-3 custom-field custom-field-30">
                                                <label class="form-label">Quận / Huyện</label>
                                                <select id="input-shipping-custom-field-30" class="form-select" data-selected="${userAddress.district}">
                                                    <option value="0">Vui lòng chọn quận/huyện</option>
                                                </select>
                                                <input type="hidden" name="district" id="hidden-district-name" value="${userAddress.district}">
                                                <div id="error-shipping-custom-field-30" class="invalid-feedback"></div>
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
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span>Tạm tính</span>
                                <span><fmt:formatNumber value="${cSubTotal}" type="number" groupingUsed="true"/>₫</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Phí vận chuyển</span>
                                <span><fmt:formatNumber value="${cShipping}" type="number" groupingUsed="true"/>₫</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center">
                                <h4 class="text-danger">Tổng cộng</h4>
                                <h3 class="text-primary">
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
                                                    <input type="radio" name="payment_method" value="bank_transfer"
                                                           id="input-payment-method-bank_transfer"
                                                           class="form-check-input input-payment-method">
                                                    <label for="input-payment-method-bank_transfer" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/logoNH.png">Chuyển khoản ngân hàng
                                                        <span class="payment-brand-icon-bank_transfer"></span>
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input type="radio" name="payment_method" value="cheque"
                                                           id="input-payment-method-cheque"
                                                           class="form-check-input input-payment-method">
                                                    <label for="input-payment-method-cheque" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/momo.png">Ví điện tử Momo
                                                        <span class="payment-brand-icon-cheque"></span>
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input type="radio" name="payment_method" value="paypal"
                                                           id="input-payment-method-paypal"
                                                           class="form-check-input input-payment-method">
                                                    <label for="input-payment-method-paypal" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/visa.png"> Thẻ Visa
                                                        <span class="payment-brand-icon-paypal"></span>
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input type="radio" name="payment_method" value="cod"
                                                           id="input-payment-method-cod"
                                                           class="form-check-input input-payment-method">
                                                    <label for="input-payment-method-cod" class="form-check-label">
                                                        <img class="payment-method-icon" src="${root}/images/image_product/logothanhtoan.png"> Thanh toán khi giao hàng
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
                                    <button type="button" id="validate_order" class="btn btn-primary">Xác nhận đơn hàng</button>
                                </div>
                                <div class="mt-3" id="paypal-button-container"></div>
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
    document.getElementById("validate_order").addEventListener("click", function () {
        window.location.href = "order_success.jsp";
    });
</script>
</body>
</html>