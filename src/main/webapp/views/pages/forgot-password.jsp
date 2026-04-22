<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Quên mật khẩu</title>
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
            <div id="forgotPage" class="page-content">
                <div class="auth-card">
                    <div class="auth-header">
                        <h1>Quên Mật Khẩu</h1>
                        <p>Nhập email để khôi phục mật khẩu</p>
                    </div>

                    <div class="auth-body">
                        <form action="${root}/forgot-password" method="post">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger text-center mb-3">
                                        ${error}
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label class="form-label">Email đăng ký <span class="required">*</span></label>
                                <div class="form-control-wrapper">
                                    <i class="fas fa-envelope form-control-icon"></i>
                                    <input type="email" class="auth-input" id="forgotEmail" name="email"
                                           placeholder="example@email.com" required>
                                </div>
                            </div>

                            <div style="background: #e3f2fd; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #2196f3;">
                                <i class="fas fa-info-circle" style="color: #2196f3;"></i>
                                <span style="font-size: 13px; color: #1976d2; margin-left: 8px;">
                                    Chúng tôi sẽ gửi mã OTP đặt lại mật khẩu đến email của bạn
                                </span>
                            </div>

                            <button type="submit" class="auth-btn">Gửi</button>

                            <div style="text-align: center; margin-top: 20px;">
                                <a href="login.jsp" class="forgot-link">
                                    <i class="fas fa-arrow-left"></i> Quay lại đăng nhập
                                </a>
                            </div>
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
</body>
</html>