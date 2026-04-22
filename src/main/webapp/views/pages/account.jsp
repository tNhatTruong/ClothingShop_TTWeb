<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Tài khoản</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/account.css">
</head>

<body>
<jsp:include page="/views/layout/header.jsp" />

<main>
    <div class="container">
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.successMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
        </c:if>

        <div class="row mt-4">
            <div class="col-md-3">
                <div class="sidebar">
                    <h4>TÀI KHOẢN</h4>
                    <a href="${root}/account" class="active">Thông tin tài khoản</a>
                    <a href="${root}/reset-password">Đổi mật khẩu</a>
                    <a href="${root}/order-history">Xem lịch sử mua hàng</a>
                    <a href="${root}/logout" id="logoutBtn">Đăng xuất</a>
                </div>
            </div>

            <div class="col-md-9">
                <div class="content">
                    <h4 class="mb-4" style="border-bottom: 2px solid #D4AF37; padding-bottom: 10px;">
                        CẬP NHẬT THÔNG TIN TÀI KHOẢN
                    </h4>

                    <form action="${root}/account" method="post" id="accountInfoForm">

                        <div class="form-group mb-3">
                            <label class="form-label fw-bold">Email đăng nhập:</label>
                            <input type="email" class="form-control" value="${sessionScope.auth.email}" disabled
                                   style="background-color: #e9ecef;">
                        </div>

                        <div class="form-group mb-3">
                            <label class="form-label fw-bold">Họ và tên:</label>
                            <input type="text" class="form-control" name="fullname"
                                   value="${sessionScope.auth.user_name}" required>
                        </div>

                        <div class="form-group mb-3">
                            <label class="form-label fw-bold">Điện thoại:</label>
                            <input type="text" class="form-control" name="phone"
                                   value="${sessionScope.auth.phone}" placeholder="Nhập số điện thoại">
                        </div>

                        <hr class="my-4">
                        <h5 class="mb-3">Địa chỉ giao hàng mặc định</h5>

                        <div class="form-group mb-3">
                            <label class="form-label">Địa chỉ cụ thể:</label>
                            <input type="text" class="form-control" name="address"
                                   value="${userAddress.street}" placeholder="Số nhà, tên đường...">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tỉnh / Thành phố</label>
                                <select id="input-shipping-zone" class="form-select" data-selected="${userAddress.province}">
                                    <option value="0">Vui lòng chọn tỉnh/thành phố</option>
                                    <option value="43">TP.Hồ Chí Minh - Nội thành</option>
                                    <option value="44">TP.Hồ Chí Minh - Ngoại thành</option>
                                </select>
                                <input type="hidden" name="city" id="hidden-city-name" value="${userAddress.province}">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Quận / Huyện</label>
                                <select id="input-shipping-custom-field-30" class="form-select" data-selected="${userAddress.district}">
                                    <option value="0">Vui lòng chọn quận/huyện</option>
                                </select>
                                <input type="hidden" name="district" id="hidden-district-name" value="${userAddress.district}">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-save mt-3" id="save-btn">
                            <i class="fas fa-save me-2"></i> Lưu Thay Đổi
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/views/layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/js/main.js"></script>
<script src="${root}/js/checkout.js"></script>
</body>
</html>