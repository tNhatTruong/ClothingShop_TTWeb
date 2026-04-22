<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Đặt lại mật khẩu</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/auth.css">
</head>

<body>
<jsp:include page="/views/layout/header.jsp" />

<main class="main-content">
    <div class="auth-container">
        <div class="auth-wrapper">
            <div id="resetPage" class="page-content">
                <div class="auth-card">
                    <div class="auth-header">
                        <h1>Đặt Lại Mật Khẩu</h1>
                        <p>Tạo mật khẩu mới cho tài khoản</p>
                    </div>

                    <div class="auth-body">
                        <form action="${root}/reset-password" method="post" id="resetForm">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger text-center mb-3">
                                        ${error}
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label class="form-label">Mật khẩu mới <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-lock form-control-icon"></i>
                                    <input type="password" class="auth-input" id="resetPassword" name="password"
                                           placeholder="Nhập mật khẩu mới" required
                                           oninput="checkPasswordStrength(this.value, 'reset')">
                                    <button type="button" class="password-toggle" onclick="togglePassword('resetPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>

                                <div class="password-strength">
                                    <div class="strength-bar">
                                        <div class="strength-bar-fill" id="resetStrengthBar"></div>
                                    </div>
                                    <div class="strength-text" id="resetStrengthText">Độ mạnh mật khẩu: Chưa nhập</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Xác nhận mật khẩu mới <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-lock form-control-icon"></i>
                                    <input type="password" class="auth-input" id="resetConfirmPassword" name="confirmPassword"
                                           placeholder="Nhập lại mật khẩu mới" required>
                                    <button type="button" class="password-toggle" onclick="togglePassword('resetConfirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="submit" class="auth-btn">Đặt Lại Mật Khẩu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/views/layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="${root}/js/main.js"></script>
<script src="${root}/js/password-utils.js"></script>

</body>
</html>