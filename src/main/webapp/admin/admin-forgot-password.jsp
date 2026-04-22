<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quên Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
    <link rel="stylesheet" href="css/admin_forgot.css"/>
</head>

<body>
<div class="forgot-container">
    <div class="forgot-card">
        <div class="forgot-header">
            <div class="forgot-logo">
                <i class="fas fa-tshirt"></i>
            </div>
            <h1 class="forgot-title">Quên Mật Khẩu</h1>
            <p class="forgot-subtitle">
                Nhập email để nhận liên kết đặt lại mật khẩu
            </p>
        </div>

        <form class="forgot-form" id="forgotForm">
            <div class="info-box">
                <i class="fas fa-info-circle"></i>
                Chúng tôi sẽ gửi liên kết đặt lại mật khẩu đến email của bạn
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Email</label>
                <input type="email" class="form-control" placeholder="admin@styleera.com" required/>
            </div>

            <button type="submit" class="btn btn-forgot mb-3">Gửi Liên Kết</button>
        </form>

        <div class="forgot-footer">
            <a href="admin-login.jsp"><i class="fas fa-arrow-left"></i> Quay lại đăng nhập</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="js/admin_Forgot.js"></script>
</body>
</html>
