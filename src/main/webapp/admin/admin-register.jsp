<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Đăng Ký Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
    <link rel="stylesheet" href="css/admin_register.css"/>
</head>

<body>
<div class="register-container">
    <div class="register-card">
        <div class="register-header">
            <div class="register-logo">
                <i class="fas fa-tshirt"></i>
            </div>
            <h1 class="register-title">Đăng ký Admin</h1>
            <p class="register-subtitle">Tạo tài khoản quản trị mới</p>
        </div>

        <form class="register-form" id="registerForm">
            <div class="mb-3">
                <label class="form-label fw-bold">Họ Tên</label>
                <input type="text" class="form-control" placeholder="Nhập họ tên" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Email</label>
                <input type="email" class="form-control" placeholder="admin@styleera.com" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Số Điện Thoại</label>
                <input type="tel" class="form-control" placeholder="0912345678" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Mật Khẩu</label>
                <input type="password" class="form-control" placeholder="Nhập mật khẩu" required/>
                <small class="text-muted">Tối thiểu 8 ký tự, chứa chữ hoa, chữ thường, số</small>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Xác Nhận Mật Khẩu</label>
                <input type="password" class="form-control" placeholder="Xác nhận mật khẩu" required/>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="agreeTerms" required/>
                <label class="form-check-label" for="agreeTerms">
                    Tôi đồng ý với <a href="#">điều khoản sử dụng</a>
                </label>
            </div>

            <button type="submit" class="btn btn-register mb-3">Đăng Ký</button>
        </form>

        <div class="register-footer">Đã có tài khoản? <a href="admin-login.jsp">Đăng nhập</a></div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="js/admin_Register.js"></script>
</body>
</html>
