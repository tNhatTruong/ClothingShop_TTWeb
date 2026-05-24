<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang | StyleEra</title>
    <!-- Thư viện Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="${root}/css/style.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/404.css">
</head>
<body>

<!-- HEADER -->
<jsp:include page="/views/layout/header.jsp"/>

<!-- MAIN CONTENT -->
<main class="error-page-container">
    <div class="error-content">
        <h1>404</h1>
        <h2>Oops! Trang này không tồn tại</h2>
        <p>Có vẻ như liên kết bạn vừa truy cập bị hỏng, hoặc trang đã bị xóa. Đừng lo lắng, hãy quay lại trang chủ để tiếp tục mua sắm những bộ sưu tập mới nhất từ StyleEra.</p>
        <a href="${root}/home" class="btn-home">
            <i class="fas fa-home"></i> Quay Lại Trang Chủ
        </a>
    </div>
</main>

<!-- FOOTER -->
<jsp:include page="/views/layout/footer.jsp"/>

</body>
</html>
