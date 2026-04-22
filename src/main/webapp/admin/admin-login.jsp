<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Đăng Nhập Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin_login.css"/>
</head>

<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-logo">
                <i class="fas fa-tshirt"></i>
            </div>
            <h1 class="login-title">Đăng nhập Admin</h1>
            <p class="login-subtitle">Đăng nhập vào tài khoản quản trị</p>
        </div>

        <form class="login-form" id="loginForm" onsubmit="return handleLogin(event)">
            <div class="mb-3">
                <label class="form-label fw-bold">Email</label>
                <input type="email" class="form-control" id="emailInput"
                       placeholder="admin@styleera.com" required/>
            </div>

            <div class="mb-2">
                <label class="form-label fw-bold">Mật Khẩu</label>
                <input type="password" class="form-control" id="passwordInput"
                       placeholder="Nhập mật khẩu" required/>
            </div>

            <button type="submit" class="btn btn-login mb-3">Đăng Nhập</button>
        </form>

        <div class="login-footer">Chưa có tài khoản?
            <a href="admin-register.jsp">Đăng ký</a></div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function handleLogin(event) {
        event.preventDefault();

        const email = document.getElementById('emailInput').value;
        const password = document.getElementById('passwordInput').value;

        if (email && password) {
            alert("Đã Đăng nhập thành công vào Admin!");
            window.location.href = "${root}/AdminDashboard";
            return false;
        } else {
            alert("Vui lòng điền đầy đủ thông tin!");
            return false;
        }
    }
</script>

</body>
</html>