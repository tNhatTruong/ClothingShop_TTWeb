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

        <!-- Alert box for client-side validation errors -->
        <div id="errorAlert" class="alert alert-danger mx-3 d-none" role="alert"></div>

        <!-- Alert box for server-side validation errors -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger mx-3" role="alert">
                ${errorMsg}
            </div>
        </c:if>

        <form class="login-form needs-validation" id="loginForm" action="${root}/admin-login" method="POST" novalidate>
            <div class="mb-3">
                <label class="form-label fw-bold" for="emailInput">Email</label>
                <input type="email" name="email" class="form-control" id="emailInput"
                       value="${not empty email ? email : ''}"
                       placeholder="admin@styleera.com" required/>
                <div class="invalid-feedback">Vui lòng nhập đúng định dạng email.</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold" for="passwordInput">Mật Khẩu</label>
                <input type="password" name="password" class="form-control" id="passwordInput"
                       placeholder="Nhập mật khẩu" required/>
                <div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
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
    document.getElementById("loginForm").addEventListener("submit", function (e) {
        const emailInput = document.getElementById("emailInput");
        const passwordInput = document.getElementById("passwordInput");
        const errorAlert = document.getElementById("errorAlert");

        const email = emailInput.value.trim();
        const password = passwordInput.value;

        let isValid = true;
        let errMsg = "";

        // Regex định dạng email chuẩn quốc tế
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!email) {
            isValid = false;
            errMsg = "Email không được để trống!";
        } else if (!emailRegex.test(email)) {
            isValid = false;
            errMsg = "Email không đúng định dạng!";
        } else if (!password) {
            isValid = false;
            errMsg = "Mật khẩu không được để trống!";
        }

        if (!isValid) {
            e.preventDefault();
            errorAlert.textContent = errMsg;
            errorAlert.classList.remove("d-none");
            this.classList.add("was-validated");
        } else {
            errorAlert.classList.add("d-none");
        }
    });
</script>

</body>
</html>