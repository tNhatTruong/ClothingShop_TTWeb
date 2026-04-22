<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Đăng ký</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/auth.css">
</head>

<body>
<!-- ===== HEADER ===== -->
<jsp:include page="/views/layout/header.jsp" />

<!-- ===== MAIN CONTENT ===== -->
<main class="main-content">
    <div class="auth-container">
        <div class="auth-wrapper">
            <!-- ===== REGISTER PAGE ===== -->
            <div id="registerPage" class="page-content">
                <div class="auth-card">
                    <div class="auth-header">
                        <h1>Đăng Ký</h1>
                        <p>Tạo tài khoản mới để bắt đầu</p>
                    </div>

                    <div class="auth-body">
                        <form id="registerForm" action="${root}/register" method="post">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger text-center mb-3">${error}</div>
                            </c:if>

                            <div class="form-group">
                                <label class="form-label">Họ và tên <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-user form-control-icon"></i>
                                    <input type="text" class="auth-input" name="name" id="registerName" placeholder="Nguyễn Văn A" required value="${name}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Email <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-envelope form-control-icon"></i>
                                    <input type="email" class="auth-input" name="email" id="registerEmail" placeholder="example@email.com" required value="${email}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Số điện thoại <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-phone form-control-icon"></i>
                                    <input type="tel" class="auth-input" name="phone" id="registerPhone" placeholder="0123456789" required value="${phone}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Mật khẩu <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-lock form-control-icon"></i>

                                    <input type="password" class="auth-input" name="password" id="registerPassword"
                                           placeholder="Nhập mật khẩu" required oninput="checkPasswordStrength(this.value, 'register')">

                                    <button type="button" class="password-toggle" onclick="togglePassword('registerPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>

                                <div class="password-strength">
                                    <div class="strength-bar"><div class="strength-bar-fill" id="registerStrengthBar"></div></div>
                                    <div class="strength-text" id="registerStrengthText"></div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Xác nhận mật khẩu <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-lock form-control-icon"></i>

                                    <input type="password" class="auth-input" name="confirmPassword" id="registerConfirmPassword"
                                           placeholder="Nhập lại mật khẩu" required>

                                    <button type="button" class="password-toggle" onclick="togglePassword('registerConfirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="submit" class="auth-btn">Đăng Ký</button>
                        </form>
                    </div>

                    <div class="auth-footer">
                        Đã có tài khoản? <a href="login" onclick="showPage('login'); return false;">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ===== FOOTER ===== -->
<jsp:include page="/views/layout/footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script src="../../js/main.js"></script>
<script src="${root}/js/password-utils.js"></script>
</body>
</html>