<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>StyleEra - Chi tiết đơn hàng</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/order_status.css">
    <style>
        .shopee-layout {
            background-color: #f5f5f5;
            padding: 20px 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        .order-card {
            background: #fff;
            border-radius: 4px;
            box-shadow: 0 1px 1px 0 rgba(0,0,0,.05);
            margin-bottom: 12px;
        }
        .order-header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 24px;
            border-bottom: 1px solid #eaeaea;
        }
        .order-header-bar .back-btn {
            color: #555;
            text-decoration: none;
            font-size: 14px;
            text-transform: uppercase;
            font-weight: 500;
        }
        .order-header-bar .back-btn:hover {
            color: #ee4d2d;
        }
        .order-header-bar .status-text {
            color: #ee4d2d;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .order-action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 24px;
            background-color: #fffaf8;
        }
        .btn-shopee-primary {
            background-color: #ee4d2d;
            color: #fff;
            border: 1px solid #ee4d2d;
            padding: 8px 30px;
            border-radius: 2px;
        }
        .btn-shopee-primary:hover {
            background-color: #d73211;
            color: #fff;
        }
        .btn-shopee-outline {
            background-color: #fff;
            color: #555;
            border: 1px solid rgba(0,0,0,.09);
            padding: 8px 30px;
            border-radius: 2px;
        }
        .btn-shopee-outline:hover {
            background-color: #f8f8f8;
            color: #555;
        }
        .envelope-border {
            height: 3px;
            width: 100%;
            background-position-x: -30px;
            background-size: 116px 3px;
            background-image: repeating-linear-gradient(45deg, #6fa6d6, #6fa6d6 33px, transparent 0, transparent 41px, #f18d9b 0, #f18d9b 74px, transparent 0, transparent 82px);
        }
        
        .address-section {
            padding: 24px;
        }
        .address-section h5 {
            font-size: 18px;
            color: #222;
            margin-bottom: 20px;
        }
        
        .product-list-section {
            padding: 0 24px 24px 24px;
        }
        .product-item {
            padding: 12px 0;
            border-bottom: 1px solid #eaeaea;
        }
        .product-item:last-child {
            border-bottom: none;
        }
        
        .payment-summary {
            padding: 24px;
            background: #fffaf8;
            border-top: 1px dashed #eaeaea;
        }
        .payment-row {
            display: flex;
            justify-content: flex-end;
            padding: 8px 0;
            font-size: 14px;
        }
        .payment-row .label {
            color: #929292;
            width: 200px;
            text-align: right;
            padding-right: 20px;
        }
        .payment-row .value {
            color: #222;
            width: 150px;
            text-align: right;
        }
        .payment-row.total .value {
            color: #ee4d2d;
            font-size: 24px;
        }
    </style>
</head>
<body>
<jsp:include page="/views/layout/header.jsp" />

<main class="shopee-layout">
    <div class="container">
        <c:if test="${param.error == 'payment_failed'}">
            <div class="alert alert-danger text-center shadow-sm">
                <i class="fas fa-exclamation-circle"></i> Thanh toán VNPay không thành công hoặc đã bị hủy. Vui lòng thanh toán lại!
            </div>
        </c:if>

        <c:choose>
            <c:when test="${order != null}">
                
                <div class="order-card">
                    <!-- HEADER BAR -->
                    <div class="order-header-bar">
                        <a href="${root}/order-history" class="back-btn"><i class="fas fa-chevron-left me-2"></i> TRỞ LẠI</a>
                        <div>
                            <span class="text-secondary me-2">MÃ ĐƠN HÀNG. ${order.id} |</span>
                            <span class="status-text">${fn:toUpperCase(order.status)}</span>
                        </div>
                    </div>

                    <!-- TIMELINE -->
                    <c:set var="statusLC" value="${fn:toLowerCase(order.status)}" />
                    <c:set var="step" value="0" />
                    <c:choose>
                        <%-- Step 0: Chờ thanh toán, Chờ duyệt --%>
                        <c:when test="${statusLC == 'chờ thanh toán' || statusLC == 'chờ duyệt'}">
                            <c:set var="step" value="0" />
                        </c:when>
                        <%-- Step 1: Đã thanh toán, Đã xác nhận, Chờ lấy hàng, Chờ vận chuyển --%>
                        <c:when test="${statusLC == 'đã thanh toán' || fn:contains(statusLC, 'xác nhận') || statusLC == 'admin_confirmed' || statusLC == 'chờ lấy hàng' || statusLC == 'chờ vận chuyển' || statusLC == 'chờ đơn vị vận chuyển lấy hàng'}">
                            <c:set var="step" value="1" />
                        </c:when>
                        <%-- Step 2: Đang vận chuyển, Đang giao --%>
                        <c:when test="${statusLC == 'đang vận chuyển' || statusLC == 'đang giao'}">
                            <c:set var="step" value="2" />
                        </c:when>
                        <%-- Step 3: Đã giao --%>
                        <c:when test="${statusLC == 'đã giao' || statusLC == 'đã giao hàng' || fn:contains(statusLC, 'tại quầy') || statusLC == 'paid_at_counter'}">
                            <c:set var="step" value="3" />
                        </c:when>
                        <%-- Step 4: Đang trả hàng --%>
                        <c:when test="${statusLC == 'yêu cầu trả hàng' || statusLC == 'đang xử lý trả hàng'}">
                            <c:set var="step" value="4" />
                        </c:when>
                        <%-- Step -1: Đóng (Hủy, Thất bại, Từ chối, Hoàn tiền) --%>
                        <c:when test="${fn:contains(statusLC, 'hủy') || statusLC == 'đã hủy' || statusLC == 'giao thất bại' || statusLC == 'đã hoàn tiền' || statusLC == 'từ chối trả hàng'}">
                            <c:set var="step" value="-1" />
                        </c:when>
                    </c:choose>

                    <div class="p-4 border-bottom">
                        <c:if test="${step >= 0}">
                            <div class="timeline">
                                <div class="timeline-item ${step >= 1 ? 'completed' : 'active'}">
                                    <div class="timeline-icon"><i class="fas fa-file-invoice"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">Đơn Hàng Đã Đặt</div>
                                        <div class="timeline-desc">
                                            <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate pattern="HH:mm dd-MM-yyyy" value="${parsedDate}" />
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item ${step >= 2 ? 'completed' : (step == 1 ? 'active' : 'pending')}">
                                    <div class="timeline-icon"><i class="fas fa-box"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">Chờ Lấy Hàng</div>
                                    </div>
                                </div>
                                <div class="timeline-item ${step >= 3 ? 'completed' : (step == 2 ? 'active' : 'pending')}">
                                    <div class="timeline-icon"><i class="fas fa-truck"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">Đang Vận Chuyển</div>
                                    </div>
                                </div>
                                <div class="timeline-item ${step >= 3 ? 'completed' : 'pending'}">
                                    <div class="timeline-icon"><i class="fas fa-star"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">Đã Giao Hàng</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${step == -1}">
                            <div class="timeline">
                                <div class="timeline-item completed" style="border-left-color: #ee4d2d;">
                                    <div class="timeline-icon" style="background-color: #ee4d2d; color: white;"><i class="fas fa-times"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title" style="color: #ee4d2d;">Đơn Hàng Đã Đóng</div>
                                        <div class="timeline-desc">${order.status}</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${step == 4}">
                            <div class="timeline">
                                <div class="timeline-item completed" style="border-left-color: #ffc107;">
                                    <div class="timeline-icon" style="background-color: #ffc107; color: white;"><i class="fas fa-undo"></i></div>
                                    <div class="timeline-content">
                                        <div class="timeline-title" style="color: #ffc107;">Tiến Trình Trả Hàng</div>
                                        <div class="timeline-desc">${order.status}</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- ACTION BAR -->
                    <div class="order-action-bar">
                        <div class="text-muted small">
                            <c:if test="${order.status == 'Chờ thanh toán'}">
                                <i class="fas fa-info-circle text-warning"></i> Đơn hàng sẽ tự động hủy sau 30 phút nếu chưa thanh toán.
                            </c:if>
                            <c:if test="${order.status != 'Chờ thanh toán'}">
                                Cảm ơn bạn đã mua sắm tại StyleEra!
                            </c:if>
                        </div>
                        <div>
                            <c:if test="${order.status == 'Chờ thanh toán'}">
                                <a href="${root}/retry-payment?orderId=${order.id}" class="btn btn-shopee-primary">Thanh Toán Ngay</a>
                            </c:if>
                            
                            <%-- Hủy Đơn Hàng: hiển thị nếu Chờ duyệt --%>
                            <c:if test="${statusLC == 'chờ duyệt'}">
                                <button type="button" class="btn btn-shopee-outline ms-2" data-bs-toggle="modal" data-bs-target="#cancelModal">Hủy Đơn Hàng</button>
                            </c:if>
                            
                            <%-- Chờ vận chuyển: Ẩn nút hủy, hiển thị text --%>
                            <c:if test="${statusLC == 'chờ vận chuyển' || statusLC == 'chờ lấy hàng' || statusLC == 'đang chuẩn bị hàng'}">
                                <span class="text-danger small ms-2"><i class="fas fa-info-circle"></i> Đơn hàng đang được chuẩn bị. Muốn hủy vui lòng liên hệ CSKH.</span>
                            </c:if>
                            
                            <%-- Đã giao: Trả hàng --%>
                            <c:if test="${statusLC == 'đã giao'}">
                                <form action="${root}/user-request-return" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn Yêu cầu trả hàng / khiếu nại?');">
                                    <input type="hidden" name="orderId" value="${order.id}">
                                    <button type="submit" class="btn btn-shopee-outline ms-2">Yêu cầu trả hàng</button>
                                </form>
                            </c:if>
                            
                            <%-- Trả hàng logic buttons --%>
                            <c:if test="${statusLC == 'yêu cầu trả hàng'}">
                                <span class="text-info small ms-2"><i class="fas fa-clock"></i> Đang chờ Admin xét duyệt yêu cầu trả hàng.</span>
                            </c:if>
                            <c:if test="${statusLC == 'đang xử lý trả hàng'}">
                                <span class="text-info small ms-2"><i class="fas fa-box-open"></i> Hướng dẫn đóng gói & Gửi về địa chỉ kho: 123 Đường ABC, Quận X, TP.HCM</span>
                            </c:if>
                            <c:if test="${statusLC == 'giao thất bại'}">
                                <button type="button" class="btn btn-shopee-outline ms-2" onclick="alert('Vui lòng gọi hotline 1900-xxxx để được hỗ trợ nhận lại hàng.')">Liên hệ hỗ trợ</button>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="envelope-border"></div>

                    <!-- ADDRESS -->
                    <div class="address-section">
                        <h5>Địa Chỉ Nhận Hàng</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="fw-bold mb-2">${order.shippingName}</div>
                                <div class="text-muted small mb-1">(+84) ${fn:replace(order.shippingPhone, '^0', '')}</div>
                                <div class="text-muted small">${order.shippingAddress}</div>
                                <c:if test="${not empty order.note}">
                                    <div class="mt-2 small text-secondary"><em>Ghi chú: ${order.note}</em></div>
                                </c:if>
                            </div>
                            <div class="col-md-6 border-start px-4">
                                <!-- Giả lập phần logs vận chuyển để layout cân đối như Shopee -->
                                <c:choose>
                                    <c:when test="${step == 3}">
                                        <c:choose>
                                            <c:when test="${statusLC == 'paid_at_counter'}">
                                                <div class="text-success small mb-1"><i class="fas fa-store me-2"></i><strong>Nhận tại quầy</strong></div>
                                                <div class="text-muted small ps-4">Đơn hàng đã được thanh toán và nhận tại quầy</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-success small mb-1"><i class="fas fa-check-circle me-2"></i><strong>Đã giao</strong></div>
                                                <div class="text-muted small ps-4">Giao hàng thành công</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${step == 2}">
                                        <div class="text-primary small mb-1"><i class="fas fa-truck me-2"></i><strong>Đang vận chuyển</strong></div>
                                        <div class="text-muted small ps-4">Mã vận đơn: #${order.id}</div>
                                    </c:when>
                                    <c:when test="${step == 1}">
                                        <c:choose>
                                            <c:when test="${statusLC == 'đã thanh toán'}">
                                                <div class="text-success small mb-1"><i class="fas fa-check-circle me-2"></i><strong>Đã thanh toán</strong></div>
                                                <div class="text-muted small ps-4">Đơn hàng đã được thanh toán, chờ lấy hàng</div>
                                            </c:when>
                                            <c:when test="${statusLC == 'chờ lấy hàng' || statusLC == 'chờ vận chuyển'}">
                                                <div class="text-secondary small mb-1"><i class="fas fa-box me-2"></i><strong>Chờ lấy hàng</strong></div>
                                                <div class="text-muted small ps-4">Người bán đang chuẩn bị hàng</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-secondary small mb-1"><i class="fas fa-file-invoice me-2"></i><strong>Đã xác nhận</strong></div>
                                                <div class="text-muted small ps-4">Đơn hàng đã được xác nhận</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${step == 0}">
                                        <c:choose>
                                            <c:when test="${statusLC == 'chờ duyệt'}">
                                                <div class="text-secondary small mb-1"><i class="fas fa-hourglass-half me-2"></i><strong>Chờ duyệt</strong></div>
                                                <div class="text-muted small ps-4">Đơn hàng đang chờ xác nhận</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-warning small mb-1"><i class="fas fa-wallet me-2"></i><strong>Chờ thanh toán</strong></div>
                                                <div class="text-muted small ps-4">Vui lòng thanh toán để hoàn tất đơn hàng</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${step == 4}">
                                        <c:choose>
                                            <c:when test="${statusLC == 'đang xử lý trả hàng'}">
                                                <div class="text-warning small mb-1"><i class="fas fa-box-open me-2"></i><strong>Đang xử lý trả hàng</strong></div>
                                                <div class="text-muted small ps-4">Yêu cầu trả hàng đã được duyệt, chờ nhận lại hàng</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-warning small mb-1"><i class="fas fa-undo me-2"></i><strong>Yêu cầu trả hàng</strong></div>
                                                <div class="text-muted small ps-4">Đang chờ Admin duyệt yêu cầu trả hàng của bạn</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${step == -1}">
                                        <c:choose>
                                            <c:when test="${statusLC == 'giao thất bại'}">
                                                <div class="text-danger small mb-1"><i class="fas fa-exclamation-triangle me-2"></i><strong>Giao thất bại</strong></div>
                                                <div class="text-muted small ps-4">Bưu tá không thể liên lạc hoặc bị từ chối nhận hàng</div>
                                            </c:when>
                                            <c:when test="${statusLC == 'đã hoàn tiền'}">
                                                <div class="text-success small mb-1"><i class="fas fa-money-bill-wave me-2"></i><strong>Đã hoàn tiền</strong></div>
                                                <div class="text-muted small ps-4">Yêu cầu trả hàng hoàn tất, tiền đã được hoàn lại</div>
                                            </c:when>
                                            <c:when test="${statusLC == 'từ chối trả hàng'}">
                                                <div class="text-danger small mb-1"><i class="fas fa-ban me-2"></i><strong>Từ chối trả hàng</strong></div>
                                                <div class="text-muted small ps-4">Yêu cầu trả hàng của bạn không hợp lệ và bị từ chối</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-danger small mb-1"><i class="fas fa-times-circle me-2"></i><strong>Đã hủy</strong></div>
                                                <div class="text-muted small ps-4">Đơn hàng đã bị hủy</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- PRODUCTS -->
                    <div class="product-list-section border-top pt-3 mt-2">
                        
                        <c:forEach var="detail" items="${orderDetails}">
                            <c:set var="variant" value="${variantMap[detail.variant_id]}" />
                            <div class="product-item d-flex align-items-center">
                                <img src="${root}${variant.product.safeThumbnail}" alt="Product" class="border" style="width: 80px; height: 80px; object-fit: cover;">
                                <div class="ms-3 flex-grow-1">
                                    <a href="${root}/product_detail?id=${variant.product.product_id}" class="text-decoration-none">
                                        <div class="fs-6 text-dark mb-1 fw-medium">${variant.product.product_name}</div>
                                    </a>
                                    <div class="text-muted small mb-1">Phân loại hàng: ${variant.color}, Size ${variant.size}</div>
                                    <div class="text-dark small">x${detail.quantity}</div>
                                </div>
                                <div class="text-end d-flex flex-column align-items-end justify-content-center">
                                    <div class="text-danger fw-medium mb-2"><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></div>
                                    <c:if test="${statusLC == 'đã giao'}">
                                        <div class="d-flex flex-row gap-2 mt-2 justify-content-end" id="review-container-${variant.product.product_id}">
                                            <c:set var="userReview" value="${reviewMap[variant.product.product_id]}" />
                                            <c:choose>
                                                <c:when test="${empty userReview}">
                                                    <button type="button" class="btn btn-sm btn-outline-danger" style="padding: 4px 12px; font-size: 13px;"
                                                            onclick="openReviewModal('${order.id}', '${variant.product.product_id}', false, '', '', '')">Đánh giá</button>
                                                </c:when>
                                                <c:when test="${userReview.editCount == 0}">
                                                    <button type="button" class="btn btn-sm btn-outline-warning" style="padding: 4px 12px; font-size: 13px;"
                                                            onclick="openReviewModal('${order.id}', '${variant.product.product_id}', true, '${userReview.id}', '${userReview.rating}', '${fn:escapeXml(userReview.comment)}')">Sửa đánh giá</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary d-flex align-items-center" style="font-size: 12px;">Đã đánh giá</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${root}/product_detail?id=${variant.product.product_id}" class="btn btn-sm text-white" style="background-color: #ee4d2d; padding: 4px 12px; font-size: 13px;">Mua Lại</a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- SUMMARY -->
                    <div class="payment-summary">
                        <div class="payment-row">
                            <div class="label">Tổng tiền hàng</div>
                            <div class="value"><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></div>
                        </div>
                        <div class="payment-row">
                            <div class="label">Phí vận chuyển</div>
                            <div class="value"><fmt:formatNumber value="${order.feeDelivery}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></div>
                        </div>
                        <div class="payment-row total border-top pt-3 mt-2">
                            <div class="label pt-1">Thành tiền</div>
                            <div class="value"><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></div>
                        </div>
                    </div>

                </div>
            </c:when>
            
            <c:otherwise>
                <div class="text-center text-muted py-5 my-5 bg-white shadow-sm rounded">
                    <i class="fa-solid fa-box-open fa-3x mb-3 text-secondary"></i>
                    <h4>Không tìm thấy đơn hàng</h4>
                    <p>Thông tin đơn hàng không tồn tại hoặc bạn không có quyền truy cập.</p>
                    <a href="${root}/order-history" class="btn btn-shopee-primary mt-2">Xem lịch sử đơn hàng</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<c:if test="${order != null && (order.status == 'Chờ duyệt' || order.status == 'Chờ thanh toán' || order.status == 'Đã Thanh Toán' || order.status == 'Chờ lấy hàng' || order.status == 'Chờ đơn vị vận chuyển lấy hàng')}">
    <!-- Cancel Order Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-danger text-white border-0">
                    <h5 class="modal-title" id="cancelModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận hủy đơn hàng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="mb-3">Bạn có chắc chắn muốn hủy đơn hàng <strong>#${order.id}</strong> không?</p>
                    <p class="text-muted small mb-0"><i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn tác. Nếu bạn đã thanh toán, tiền sẽ được hoàn lại theo quy định của StyleEra.</p>
                </div>
                <div class="modal-footer border-0 pt-0 flex-nowrap">
                    <button type="button" class="btn btn-light px-3 text-nowrap" data-bs-dismiss="modal">Không, giữ lại</button>
                    <form action="${root}/cancel-order" method="POST" class="m-0">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <button type="submit" class="btn btn-danger px-3 fw-bold text-nowrap">Có, hủy đơn hàng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="/views/layout/footer.jsp" />

<!-- Review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 12px; overflow: hidden;">
            <div class="modal-header border-bottom-0 pb-0 pt-4 px-4 text-center d-block position-relative">
                <h5 class="modal-title fw-bold" id="reviewModalLabel" style="color: #ee4d2d; font-size: 1.25rem;">
                    <i class="fas fa-star me-2"></i>Đánh giá sản phẩm
                </h5>
                <button type="button" class="btn-close position-absolute" style="top: 1rem; right: 1rem;" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form onsubmit="submitReviewForm(event)">
                <div class="modal-body px-4 pt-3 pb-4">
                    <input type="hidden" name="orderId" id="reviewOrderId">
                    <input type="hidden" name="productId" id="reviewProductId">
                    <input type="hidden" name="isEdit" id="reviewIsEdit">
                    <input type="hidden" name="reviewId" id="reviewId">
                    <input type="hidden" name="rating" id="reviewRatingInput" value="5">

                    <div class="mb-4 text-center">
                        <label class="form-label d-block mb-2 text-muted" style="font-size: 0.95rem;">Chất lượng sản phẩm</label>
                        <div class="star-rating-form" style="font-size: 2.5rem; cursor: pointer;">
                            <i class="fas fa-star text-warning" onclick="setReviewRating(1)"></i>
                            <i class="fas fa-star text-warning" onclick="setReviewRating(2)"></i>
                            <i class="fas fa-star text-warning" onclick="setReviewRating(3)"></i>
                            <i class="fas fa-star text-warning" onclick="setReviewRating(4)"></i>
                            <i class="fas fa-star text-warning" onclick="setReviewRating(5)"></i>
                        </div>
                    </div>

                    <div class="mb-2">
                        <label for="reviewCommentText" class="form-label fw-medium text-dark" style="font-size: 0.95rem;">Mô tả trải nghiệm của bạn</label>
                        <textarea class="form-control bg-light border-0" name="comment" id="reviewCommentText" rows="4" placeholder="Hãy chia sẻ cảm nhận chi tiết của bạn về sản phẩm này nhé..." required style="border-radius: 8px; padding: 12px; box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);"></textarea>
                    </div>
                </div>
                <div class="modal-footer border-top-0 px-4 pb-4 pt-0 justify-content-center gap-2">
                    <button type="button" class="btn btn-light px-4 py-2" data-bs-dismiss="modal" style="border-radius: 8px; font-weight: 500;">Trở lại</button>
                    <button type="submit" class="btn px-4 py-2 text-white" id="reviewSubmitBtn" style="background-color: #ee4d2d; border-radius: 8px; font-weight: 500; border: none; box-shadow: 0 4px 6px rgba(238,77,45,0.2);">Hoàn thành</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100; margin-top: 60px;">
    <div id="liveToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body fw-medium" id="toastMessage">
                <i class="fas fa-check-circle me-2"></i> Thành công!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/js/main.js"></script>
<script>
    function setReviewRating(rating) {
        document.getElementById('reviewRatingInput').value = rating;
        const stars = document.querySelectorAll('.star-rating-form .fa-star');
        stars.forEach((star, index) => {
            if (index < rating) {
                star.classList.add('text-warning');
                star.classList.remove('text-muted');
            } else {
                star.classList.remove('text-warning');
                star.classList.add('text-muted');
            }
        });
    }

    function openReviewModal(orderId, productId, isEdit, reviewId, rating, comment) {
        document.getElementById('reviewOrderId').value = orderId;
        document.getElementById('reviewProductId').value = productId;
        document.getElementById('reviewIsEdit').value = isEdit ? 'true' : 'false';
        document.getElementById('reviewId').value = reviewId || '';
        
        let initialRating = isEdit && rating ? parseInt(rating) : 5;
        setReviewRating(initialRating);
        
        document.getElementById('reviewCommentText').value = isEdit && comment ? comment : '';
        
        document.getElementById('reviewModalLabel').innerHTML = isEdit ? '<i class="fas fa-edit me-2"></i>Sửa đánh giá sản phẩm' : '<i class="fas fa-star me-2"></i>Đánh giá sản phẩm';
        document.getElementById('reviewSubmitBtn').innerText = isEdit ? 'Cập nhật' : 'Gửi đánh giá';

        const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
        modal.show();
    }

    function submitReviewForm(event) {
        event.preventDefault();
        const form = event.target;
        const submitBtn = document.getElementById('reviewSubmitBtn');
        const originalText = submitBtn.innerText;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang xử lý...';
        submitBtn.disabled = true;

        const formData = new FormData(form);
        formData.append("ajax", "true");
        
        fetch('${root}/submit_review', {
            method: 'POST',
            body: new URLSearchParams(formData)
        })
        .then(res => res.json())
        .then(data => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            
            if(data.status === 'success') {
                const modal = bootstrap.Modal.getInstance(document.getElementById('reviewModal'));
                modal.hide();
                
                // Hiển thị toast
                document.getElementById('toastMessage').innerHTML = '<i class="fas fa-check-circle me-2"></i> ' + data.message;
                const toast = new bootstrap.Toast(document.getElementById('liveToast'));
                toast.show();
                
                // Cập nhật DOM để không khựng trang
                const productId = document.getElementById('reviewProductId').value;
                const isEdit = document.getElementById('reviewIsEdit').value === 'true';
                const container = document.getElementById('review-container-' + productId);
                
                if (container) {
                    if (isEdit) {
                        container.innerHTML = '<span class="badge bg-secondary">Đã đánh giá</span><a href="${root}/product_detail?id=' + productId + '" class="btn btn-sm text-white" style="background-color: #ee4d2d; padding: 4px 12px; font-size: 13px; margin-left: 8px;">Mua Lại</a>';
                    } else {
                        // Thể hiện đã đánh giá tạm thời, nếu muốn sửa thì họ phải reload trang
                        container.innerHTML = '<span class="badge bg-success">Vừa đánh giá</span><a href="${root}/product_detail?id=' + productId + '" class="btn btn-sm text-white" style="background-color: #ee4d2d; padding: 4px 12px; font-size: 13px; margin-left: 8px;">Mua Lại</a>';
                    }
                }
            } else {
                alert(data.message);
            }
        }).catch(err => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            alert("Có lỗi kết nối xảy ra!");
        });
    }
</script>
</body>
</html>