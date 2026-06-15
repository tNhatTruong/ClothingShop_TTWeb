<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>StyleEra - Trạng thái</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/order_status.css">
</head>
<body>
<jsp:include page="/views/layout/header.jsp" />

<main>
    <div class="status-container">
        <div class="order-header">
            <h2>Đơn Hàng của bạn</h2>
        </div>
        <div class="timeline">
            <%-- Bước 1: Chờ vận chuyển --%>
            <c:set var="step1"
                   value="${order.status eq 'Chờ vận chuyển' or order.status eq 'Đang vận chuyển' or order.status eq 'Đã Giao'
                           ? (order.status eq 'Chờ vận chuyển' ? 'active' : 'completed')
                           : (order.status eq 'Đã hủy' ? 'cancelled' : 'pending')}" />
            <div class="timeline-item ${step1}">
                <div class="timeline-icon">
                    <i class="fas ${step1 eq 'completed' ? 'fa-check' : (step1 eq 'cancelled' ? 'fa-times' : 'fa-box')}"></i>
                </div>
                <div class="timeline-content">
                    <div class="timeline-title">
                        <c:choose>
                            <c:when test="${order.status eq 'Đã hủy'}">Đơn Hàng Đã Hủy</c:when>
                            <c:otherwise>Chờ Vận Chuyển</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="timeline-desc">
                        <c:choose>
                            <c:when test="${order.status eq 'Đã hủy'}">Đơn hàng đã bị hủy</c:when>
                            <c:otherwise>Đơn hàng đã được xác nhận và đang chờ lấy hàng</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="timeline-time">${order.createdAt}</div>
                </div>
            </div>

            <%-- Bước 2: Đang vận chuyển --%>
            <c:if test="${order.status ne 'Đã hủy'}">
                <c:set var="step2"
                       value="${order.status eq 'Đang vận chuyển' ? 'active' : (order.status eq 'Đã Giao' ? 'completed' : 'pending')}" />
                <div class="timeline-item ${step2}">
                    <div class="timeline-icon">
                        <i class="fas ${step2 eq 'completed' ? 'fa-check' : 'fa-truck'}"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Đang Vận Chuyển</div>
                        <div class="timeline-desc">Đơn hàng đang trên đường giao đến bạn</div>
                    </div>
                </div>

                <%-- Bước 3: Đã giao --%>
                <c:set var="step3" value="${order.status eq 'Đã Giao' ? 'completed' : 'pending'}" />
                <div class="timeline-item ${step3}">
                    <div class="timeline-icon">
                        <i class="fas ${step3 eq 'completed' ? 'fa-check' : 'fa-home'}"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Đã Giao Hàng</div>
                        <div class="timeline-desc">
                            <c:choose>
                                <c:when test="${order.status eq 'Đã Giao'}">Đơn hàng đã được giao thành công đến địa chỉ của bạn</c:when>
                                <c:otherwise>Đơn hàng sẽ được giao đến địa chỉ của bạn</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        <c:choose>
            <c:when test="${order != null}">
                <div class="box-header">
                    <div class="header">        
                        <h4>Chi tiết đơn hàng</h4>
                    </div>
                    <div class="mt-3 d-flex justify-content-between">
                        <span class="text-gray">Mã đơn hàng:</span>
                        <span>#${order.id}</span>
                    </div>
                    <div class="mt-3 d-flex justify-content-between">
                        <span class="text-gray">Ngày đặt hàng:</span>
                        <span>${order.createdAt}</span>
                    </div>
                    <div class="mt-3 d-flex justify-content-between">
                        <span class="text-gray">Trạng thái đơn hàng:</span>
                        <span class="badge bg-warning text-dark">${order.status}</span>
                    </div>
                    <c:if test="${order.note != null && !order.note.trim().isEmpty()}">
                        <div class="mt-3 d-flex justify-content-between">
                            <span class="text-gray">Ghi chú:</span>
                            <span>${order.note}</span>
                        </div>
                    </c:if>
                </div>
                <div class="box-footer">
                    <div class="header">
                         <h4>Tổng quan đơn hàng</h4>
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <span class="text-gray">Phí tạm tính: </span>
                        <span>${order.price} đ</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span class="text-gray">Phí Vận chuyển: </span>
                        <span>${order.feeDelivery} đ</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <strong>Tổng: </strong>
                        <strong>${order.totalPrice} đ</strong>
                    </div>
                </div>
            </c:when>
            <c:when test="${sessionScope.cart == null || sessionScope.cart.item.size() == 0}">
<%--                Thông báo nếu chưa thanh toán--%>
                <div class="text-center text-muted py-5">
                    <i class="fa-solid fa-receipt fa-2x mb-3"></i>
                    <p>Chưa có đơn hàng nào được thanh toán</p>
                </div>
            </c:when>
            <c:otherwise>
            <div class="box-header">
        <div class="header">        
            <h4>Chi tiết đơn hàng</h4>
        </div>
        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Mã đơn hàng:</span>
            <span>#985106</span>
        </div>
        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Hình ảnh:</span>
            <span> <img src="../../images/product_item_women/6/6-1/trangphuc.png" style="height: 80px;"> </span>
        </div>
        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Tên đơn hàng:</span>
            <span>Đầm nữ</span>
        </div>
        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Ngày đặt hàng:</span>
            <span>14 tháng 11 năm 2025</span>
        </div>

        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Phương thức thanh toán:</span>
            <span>Thanh toán khi nhận hàng</span>
        </div>

        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Ngày vận chuyển:</span>
            <span>15 tháng 11 năm 2025</span>
        </div>

        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Trạng thái đơn hàng:</span>
            <span>Chờ vận chuyển</span>
        </div>

        <div class="mt-3 d-flex justify-content-between">
            <span class="text-gray">Ngày giao hàng dự kiến:</span>
            <span>17 tháng 11 năm 2025</span>
        </div>
       

    </div>
            <div class="box-footer">
            <div class="header">
                 <h4>Tổng quan đơn hàng</h4>
            </div>
        <div class="d-flex justify-content-between mt-3">
            <span class="text-gray">Phí tạm tính: </span>
            <span>130.000 đ</span>
        </div>

        <div class="d-flex justify-content-between mt-2">
            <span class="text-gray">Số lượng: </span>
            <span>1</span>
        </div>

        <div class="d-flex justify-content-between mt-2">
            <span class="text-gray">Phí Vận chuyển: </span>
            <span>0đ</span>
        </div>
        <div class="d-flex justify-content-between mt-2">
            <strong>Tổng: </strong>
            <strong>130.000 đ</strong>
        </div>
    </div>
            </c:otherwise>
        </c:choose>

    <div class="box-btn">
        <a class="btn btn-primary btn-back" href="${root}/cart">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
        <button class="btn btn-primary btn-danger">
             Huỷ Đơn Hàng
        </button>
     </div>
   </div>
 </div>
</main>


<jsp:include page="/views/layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/js/order_status.js"></script>
<script src="${root}/js/main.js"></script>
</body>

<%--Hiển thị thông báo huỷ đơn hàng--%>
<div class="modal fade" id="cancelSuccessModal" tabindex="-1" aria-labelledby="cancelSuccessLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="cancelSuccessLabel">Thông báo</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body text-center">
        <i class="fas fa-check-circle text-success" style="font-size: 48px; margin-bottom: 10px;"></i>
        <p class="mt-2 mb-0"><strong>Bạn đã huỷ đơn hàng thành công!  </strong> </p>
      </div>
      <div class="modal-footer justify-content-center">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

</html>