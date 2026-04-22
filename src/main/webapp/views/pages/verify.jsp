<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP - StyleEra</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${root}/css/verify.css">
</head>
<body>
<div class="container">
    <div class="otp-container bg-white">
        <h3 class="text-center mb-4">Xác Thực Tài Khoản</h3>

        <p class="text-center text-muted">
            Chúng tôi đã gửi mã xác thực 6 số đến email:<br>
            <strong>${email}</strong>
        </p>

        <form action="${root}/verify" method="post">
            <input type="hidden" name="email" value="${email}">

            <div class="mb-4">
                <input type="text" name="otp" class="form-control otp-input"
                       placeholder="######" maxlength="6" required autofocus>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger text-center">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <button type="submit" class="btn btn-dark w-100 py-2">XÁC THỰC</button>
        </form>

        <div class="text-center mt-3">
            <small>Chưa nhận được mã? <a href="#">Gửi lại</a></small>
        </div>
    </div>
</div>
</body>
</html>