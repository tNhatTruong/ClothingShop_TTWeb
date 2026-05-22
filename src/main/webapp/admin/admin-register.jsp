<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Đăng Ký Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin_login.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin_register.css"/>
</head>

<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-logo">
                <i class="fas fa-tshirt"></i>
            </div>
            <h1 class="login-title">Đăng ký Admin</h1>
            <p class="login-subtitle">Tạo tài khoản quản trị mới</p>
        </div>

        <div id="alertBox" class="alert d-none mx-3" role="alert"></div>

        <form class="login-form" id="registerForm" novalidate>
            <input type="hidden" id="contextPath" value="${root}"/>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" class="form-control" id="fullName" name="fullName"
                       placeholder="Họ tên" required />
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="email" class="form-control" id="email" name="email"
                       placeholder="admin@styleera.com" required />
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                <input type="tel" class="form-control" id="phone" name="phone"
                       placeholder="0912345678" />
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Mật khẩu" required />
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                       placeholder="Xác nhận mật khẩu" required />
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="agreeTerms" required />
                <label class="form-check-label" for="agreeTerms">
                    Tôi đồng ý với <a href="#">điều khoản sử dụng</a>
                </label>
            </div>

            <button type="submit" class="btn btn-login mb-3" id="submitBtn">Đăng Ký</button>
        </form>

        <div class="login-footer">Đã có tài khoản? <a href="admin-login.jsp">Đăng nhập</a></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/admin/js/admin_Register.js"></script>
</body>
</html>
