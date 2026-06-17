<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Lịch sử</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/account.css">
</head>

<body>
<!-- ===== HEADER ===== -->
<jsp:include page="/views/layout/header.jsp" />

<!-- ===== MAIN CONTENT ===== -->
<main>
    <div class="container">
        <div class="row mt-4">
            <!-- Sidebar Navigation -->
            <div class="col-md-3">
                <div class="sidebar">
                    <h4>TÀI KHOẢN</h4>
                    <a href="${root}/account">Thông tin tài khoản</a>
                    <c:choose>
                        <c:when test="${empty sessionScope.auth.password_hash}">
                            <a href="${root}/set-password">Thiết lập mật khẩu</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${root}/change-password">Đổi mật khẩu</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="${root}/order-history" class="active">Xem lịch sử mua hàng</a>
                    <a href="${root}/logout" id="logoutBtn">Đăng xuất</a>
                </div>
            </div>

            <!-- Orders Content -->
            <div class="col-md-9">
                <div class="content">
                    <h4 class="mb-4" style="border-bottom: 2px solid #D4AF37; padding-bottom: 10px;">LỊCH SỬ ĐƠN HÀNG</h4>
                    
                    <c:choose>
                        <c:when test="${not empty ordersList}">
                            <div class="order-list">
                                <c:forEach var="order" items="${ordersList}">
                                    <c:set var="firstDetail" value="${firstDetailMap[order.id]}" />
                                    <c:set var="variant" value="${variantMap[firstDetail.variant_id]}" />
                                    <c:set var="detailCount" value="${detailCountMap[order.id]}" />
                                    
                                    <div class="card mb-4 border-0 shadow-sm order-card">
                                        <div class="card-header bg-light d-flex justify-content-between align-items-center border-bottom-0 pt-3 pb-3">
                                            <div>
                                                <span class="fw-bold me-3">Mã đơn: #${order.id}</span>
                                                <span class="text-muted" style="font-size: 0.9rem;">
                                                    <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                    <i class="far fa-clock me-1"></i><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${parsedDate}" />
                                                </span>
                                            </div>
                                            <div>
                                                <c:set var="statusLC" value="${fn:toLowerCase(order.status)}" />
                                                <c:choose>
                                                    <c:when test="${statusLC == 'chờ duyệt' || statusLC == 'chờ thanh toán'}">
                                                        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill"><i class="fas fa-hourglass-half me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${statusLC == 'đã thanh toán' || statusLC == 'chờ vận chuyển' || statusLC == 'chờ lấy hàng' || statusLC == 'admin_confirmed'}">
                                                        <span class="badge bg-info text-dark px-3 py-2 rounded-pill"><i class="fas fa-box me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${statusLC == 'đang vận chuyển'}">
                                                        <span class="badge bg-primary px-3 py-2 rounded-pill"><i class="fas fa-truck me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${statusLC == 'đã giao'}">
                                                        <span class="badge bg-success px-3 py-2 rounded-pill"><i class="fas fa-check-circle me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${fn:contains(statusLC, 'hủy') || fn:contains(statusLC, 'thất bại') || fn:contains(statusLC, 'từ chối')}">
                                                        <span class="badge bg-danger px-3 py-2 rounded-pill"><i class="fas fa-times-circle me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${fn:contains(statusLC, 'trả hàng') || fn:contains(statusLC, 'hoàn tiền')}">
                                                        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill"><i class="fas fa-undo me-1"></i>${order.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary px-3 py-2 rounded-pill">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="product-img-wrapper me-4 border rounded p-1" style="width: 100px; height: 100px; flex-shrink: 0;">
                                                    <c:if test="${not empty variant}">
                                                        <img src="${root}${variant.product.safeThumbnail}" alt="${variant.product.product_name}" class="img-fluid w-100 h-100" style="object-fit: cover;">
                                                    </c:if>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <h6 class="fw-bold mb-1" style="font-size: 1.1rem;">${variant.product.product_name}</h6>
                                                    <p class="text-muted mb-2 mb-0" style="font-size: 0.95rem;">Phân loại: ${variant.color}, Size ${variant.size}</p>
                                                    <p class="mb-0 fw-medium">x${firstDetail.quantity}</p>
                                                </div>
                                            </div>
                                            <c:if test="${detailCount > 1}">
                                                <div class="mt-3 text-center py-2" style="background-color: #f8f9fa; border-radius: 8px; border: 1px dashed #dee2e6;">
                                                    <span class="text-muted" style="font-size: 0.9rem;"><i class="fas fa-box-open me-2"></i>...và ${detailCount - 1} sản phẩm khác</span>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="card-footer bg-white border-top-0 pt-0 pb-3 d-flex justify-content-between align-items-end">
                                            <div>
                                                <span class="text-muted d-block" style="font-size: 0.9rem;">Tổng thanh toán</span>
                                                <span class="fw-bold text-danger" style="font-size: 1.25rem;"><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0"/>đ</span>
                                            </div>
                                            <div>
                                                <a href="${root}/order-status?orderId=${order.id}" class="btn px-4 py-2 text-white fw-medium shadow-sm" style="background-color: #D4AF37; border-radius: 6px;">Xem chi tiết</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <img src="${root}/images/empty-cart.png" alt="No orders" class="img-fluid mb-3" style="max-width: 150px; opacity: 0.5;">
                                <p class="text-muted fs-5">Bạn chưa có đơn hàng nào.</p>
                                <a href="${root}/home" class="btn btn-dark mt-3 px-4 py-2">Tiếp tục mua sắm</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
</body>
</html>