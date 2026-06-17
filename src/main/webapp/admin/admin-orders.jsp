<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản Lý Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css?v=1.2"/>
    <link rel="stylesheet" href="${root}/admin/css/admin_order.css?v=1.2"/>
</head>

<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="orders" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

        <!-- ===== CONTENT ===== -->
        <main class="admin-content">
            <!-- Flash messages -->
            <c:if test="${param.success eq 'updated'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Cập nhật trạng thái đơn hàng thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.error eq 'invalid'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>Yêu cầu không hợp lệ!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Page Header -->
            <div class="page-header mb-5 d-flex justify-content-between align-items-center w-100">
                <h1 class="page-title mb-0">Quản Lý Đơn Hàng</h1>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#adminCreateOrderModal">
                    <i class="fas fa-plus me-1"></i> Tạo Đơn Hàng
                </button>
            </div>

            <!-- Tính toán các trạng thái đơn hàng theo 6 nhóm Macro hợp lý -->
            <c:set var="pendingConfirm" value="0" />
            <c:set var="pendingShip" value="0" />
            <c:set var="shipping" value="0" />
            <c:set var="delivered" value="0" />
            <c:set var="returns" value="0" />
            <c:set var="cancelled" value="0" />

            <c:forEach items="${orders}" var="o">
                <c:set var="st" value="${fn:toLowerCase(o.status)}" />
                <c:choose>
                    <c:when test="${o.status eq 'Chờ duyệt' || o.status eq 'Chờ thanh toán'}">
                        <c:set var="pendingConfirm" value="${pendingConfirm + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đã Thanh Toán' || o.status eq 'ADMIN_CONFIRMED' || o.status eq 'Chờ vận chuyển' || o.status eq 'PAID_AT_COUNTER'}">
                        <c:set var="pendingShip" value="${pendingShip + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đang vận chuyển'}">
                        <c:set var="shipping" value="${shipping + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đã Giao'}">
                        <c:set var="delivered" value="${delivered + 1}" />
                    </c:when>
                    <c:when test="${fn:contains(st, 'trả hàng') || fn:contains(st, 'hoàn tiền')}">
                        <c:set var="returns" value="${returns + 1}" />
                    </c:when>
                    <c:when test="${fn:contains(st, 'hủy') || fn:contains(st, 'thất bại')}">
                        <c:set var="cancelled" value="${cancelled + 1}" />
                    </c:when>
                    <c:otherwise>
                        <!-- Dự phòng cho các trạng thái không xác định -->
                        <c:set var="pendingConfirm" value="${pendingConfirm + 1}" />
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- Stats (6 nhóm) -->
            <div class="row mb-4 g-2">
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-secondary border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-secondary">${pendingConfirm}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Chờ Xác Nhận</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-info border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-info">${pendingShip}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Chờ Giao Hàng</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-warning border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-warning">${shipping}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Đang Vận Chuyển</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-success border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-success">${delivered}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Đã Giao</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-primary border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-primary">${returns}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Đổi Trả / Hoàn Tiền</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="card text-center shadow-sm border-danger border-bottom border-3 h-100">
                        <div class="card-body p-2 d-flex flex-column justify-content-center">
                            <h4 class="mb-1 text-danger">${cancelled}</h4>
                            <p class="text-muted small mb-0" style="font-size: 12px;">Hủy / Thất Bại</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label">Tìm Kiếm Đơn Hàng</label>
                            <input type="text" class="form-control" id="searchOrderInput" placeholder="Mã đơn hàng, tên hoặc email khách hàng..."/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Trạng Thái</label>
                            <select class="form-select" id="statusOrderFilter">
                                <option value="">Tất Cả Trạng Thái</option>
                                <optgroup label="Chờ Xác Nhận">
                                    <option value="Chờ duyệt">Chờ duyệt</option>
                                    <option value="Chờ thanh toán">Chờ thanh toán</option>
                                </optgroup>
                                <optgroup label="Chờ Giao Hàng">
                                    <option value="Đã Thanh Toán">Đã Thanh Toán</option>
                                    <option value="ADMIN_CONFIRMED">Đã Xác Nhận (Admin)</option>
                                    <option value="Chờ vận chuyển">Chờ vận chuyển</option>
                                    <option value="PAID_AT_COUNTER">Tại Quầy (Chờ chốt)</option>
                                </optgroup>
                                <optgroup label="Vận Chuyển & Giao Hàng">
                                    <option value="Đang vận chuyển">Đang vận chuyển</option>
                                    <option value="Đã Giao">Đã Giao</option>
                                </optgroup>
                                <optgroup label="Đổi Trả / Hoàn Tiền">
                                    <option value="Yêu cầu trả hàng">Yêu cầu trả hàng</option>
                                    <option value="Đang xử lý trả hàng">Đang xử lý trả hàng</option>
                                    <option value="Đã hoàn tiền">Đã hoàn tiền</option>
                                    <option value="Từ chối trả hàng">Từ chối trả hàng</option>
                                </optgroup>
                                <optgroup label="Hủy / Thất Bại">
                                    <option value="Đã hủy">Đã hủy</option>
                                    <option value="Hủy (Bởi người dùng)">Hủy (Bởi người dùng)</option>
                                    <option value="Hủy (Quá hạn thanh toán)">Hủy (Quá hạn thanh toán)</option>
                                    <option value="Hủy (Lỗi Thanh Toán)">Hủy (Lỗi Thanh Toán)</option>
                                    <option value="Giao thất bại">Giao thất bại</option>
                                </optgroup>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Danh Sách Đơn Hàng</h6>
                    <span class="text-muted small">Tổng cộng: <strong>${orders.size()}</strong> đơn hàng</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr class="text-center align-middle">
                                <th>Mã ĐH</th>
                                <th>Khách Hàng</th>
                                <th>Email</th>
                                <th>Ngày Đặt</th>
                                <th>Tổng Tiền</th>
                                <th>Trạng Thái</th>
                                <th style="width: 120px">Hành Động</th>
                            </tr>
                            </thead>
                            <tbody id="ordersTableBody">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr class="no-orders-row">
                                        <td colspan="7" class="text-center py-4">
                                            <i class="fas fa-inbox" style="font-size: 48px; color: #ccc;"></i>
                                            <p class="mt-2 text-muted">Không tìm thấy đơn hàng nào trong hệ thống</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${orders}" var="o">
                                        <c:set var="rowSt" value="${fn:toLowerCase(o.status)}" />
                                        <c:set var="rowMacro" value="Chờ Xác Nhận" />
                                        <c:choose>
                                            <c:when test="${o.status eq 'Chờ duyệt' || o.status eq 'Chờ thanh toán'}">
                                                <c:set var="rowMacro" value="Chờ Xác Nhận" />
                                            </c:when>
                                            <c:when test="${o.status eq 'Đã Thanh Toán' || o.status eq 'ADMIN_CONFIRMED' || o.status eq 'Chờ vận chuyển' || o.status eq 'PAID_AT_COUNTER'}">
                                                <c:set var="rowMacro" value="Chờ Giao Hàng" />
                                            </c:when>
                                            <c:when test="${o.status eq 'Đang vận chuyển'}">
                                                <c:set var="rowMacro" value="Đang Vận Chuyển" />
                                            </c:when>
                                            <c:when test="${o.status eq 'Đã Giao'}">
                                                <c:set var="rowMacro" value="Đã Giao" />
                                            </c:when>
                                            <c:when test="${fn:contains(rowSt, 'trả hàng') || fn:contains(rowSt, 'hoàn tiền')}">
                                                <c:set var="rowMacro" value="Đổi Trả / Hoàn Tiền" />
                                            </c:when>
                                            <c:when test="${fn:contains(rowSt, 'hủy') || fn:contains(rowSt, 'thất bại')}">
                                                <c:set var="rowMacro" value="Hủy / Thất Bại" />
                                            </c:when>
                                        </c:choose>
                                        
                                        <tr class="text-center align-middle" data-macro-status="${rowMacro}" data-exact-status="${o.status}">
                                            <td><strong>#${o.id}</strong></td>
                                            <td>${not empty o.shippingName ? o.shippingName : o.userName}</td>
                                            <td>${o.email}</td>
                                            <td><strong>${o.formattedCreatedAt}</strong></td>
                                            <td>
                                                <strong><fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></strong>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status eq 'Chờ vận chuyển'}">
                                                        <span class="badge bg-info">${o.status}</span>
                                                    </c:when>
                                                    <c:when test="${o.status eq 'Đang vận chuyển'}">
                                                        <span class="badge bg-warning text-dark">${o.status}</span>
                                                    </c:when>
                                                    <c:when test="${o.status eq 'Đã Giao'}">
                                                        <span class="badge bg-success">${o.status}</span>
                                                    </c:when>
                                                    <c:when test="${fn:contains(fn:toLowerCase(o.status), 'hủy')}">
                                                        <span class="badge bg-danger">${o.status}</span>
                                                    </c:when>
                                                    <c:when test="${o.status eq 'ADMIN_CONFIRMED'}">
                                                        <span class="badge bg-primary">Đã Xác Nhận (Admin)</span>
                                                    </c:when>
                                                    <c:when test="${o.status eq 'PAID_AT_COUNTER'}">
                                                        <span class="badge bg-success">Tại Quầy (Chờ chốt)</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${o.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <!-- Ô Action được thiết kế lại: Dùng Icon Edit mở ra Dropdown Menu -->
                                                <div class="d-flex gap-1 justify-content-center align-items-center flex-wrap">
                                                    <!-- Chỉ hiển thị nút Edit nếu có hành động tiếp theo hợp lệ -->
                                                    <c:set var="canEdit" value="false" />
                                                    <c:if test="${o.status eq 'Chờ duyệt' || o.status eq 'Đã Thanh Toán' || o.status eq 'ADMIN_CONFIRMED' || o.status eq 'Chờ thanh toán' || o.status eq 'Chờ vận chuyển' || o.status eq 'Đang vận chuyển' || o.status eq 'PAID_AT_COUNTER' || o.status eq 'Yêu cầu trả hàng' || o.status eq 'Đang xử lý trả hàng'}">
                                                        <c:set var="canEdit" value="true" />
                                                    </c:if>

                                                    <c:if test="${canEdit}">
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-outline-warning dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" title="Cập nhật trạng thái">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-menu-end shadow" style="font-size: 14px;">
                                                                <li><h6 class="dropdown-header">Cập nhật trạng thái</h6></li>
                                                                
                                                                <c:if test="${o.status eq 'Chờ duyệt' || o.status eq 'Đã Thanh Toán' || o.status eq 'ADMIN_CONFIRMED'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Bạn muốn chuyển sang: Chờ vận chuyển?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Chờ vận chuyển">
                                                                            <button type="submit" class="dropdown-item"><i class="fas fa-box me-2 text-secondary"></i>Chờ vận chuyển</button>
                                                                        </form>
                                                                    </li>
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Bạn có chắc chắn muốn Hủy đơn hàng này?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đã hủy">
                                                                            <button type="submit" class="dropdown-item text-danger"><i class="fas fa-times me-2"></i>Đã hủy</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>
                                                                
                                                                <c:if test="${o.status eq 'Chờ thanh toán'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Bạn có chắc chắn muốn Hủy đơn hàng này?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đã hủy">
                                                                            <button type="submit" class="dropdown-item text-danger"><i class="fas fa-times me-2"></i>Đã hủy</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>

                                                                <c:if test="${o.status eq 'Chờ vận chuyển'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Bạn muốn chuyển sang: Đang vận chuyển?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đang vận chuyển">
                                                                            <button type="submit" class="dropdown-item"><i class="fas fa-truck me-2 text-primary"></i>Đang vận chuyển</button>
                                                                        </form>
                                                                    </li>
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Bạn có chắc chắn muốn Hủy đơn hàng này?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đã hủy">
                                                                            <button type="submit" class="dropdown-item text-danger"><i class="fas fa-times me-2"></i>Đã hủy</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>
                                                                
                                                                <c:if test="${o.status eq 'Đang vận chuyển' || o.status eq 'PAID_AT_COUNTER'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Xác nhận: Giao hàng thành công?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đã Giao">
                                                                            <button type="submit" class="dropdown-item text-success"><i class="fas fa-check-circle me-2"></i>Đã Giao (Hoàn thành)</button>
                                                                        </form>
                                                                    </li>
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Xác nhận: Giao hàng thất bại?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Giao thất bại">
                                                                            <button type="submit" class="dropdown-item text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Giao thất bại</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>
                                                                
                                                                <c:if test="${o.status eq 'Yêu cầu trả hàng'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Chấp nhận yêu cầu trả hàng?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đang xử lý trả hàng">
                                                                            <button type="submit" class="dropdown-item text-warning"><i class="fas fa-box-open me-2"></i>Duyệt: Đang xử lý</button>
                                                                        </form>
                                                                    </li>
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Từ chối yêu cầu trả hàng?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Từ chối trả hàng">
                                                                            <button type="submit" class="dropdown-item text-danger"><i class="fas fa-ban me-2"></i>Từ chối yêu cầu</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>
                                                                
                                                                <c:if test="${o.status eq 'Đang xử lý trả hàng'}">
                                                                    <li>
                                                                        <form action="${root}/admin-update-order-status" method="post" class="m-0 p-0" onsubmit="return confirm('Xác nhận đã hoàn tiền cho khách?');">
                                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                                            <input type="hidden" name="status" value="Đã hoàn tiền">
                                                                            <button type="submit" class="dropdown-item text-success"><i class="fas fa-money-bill-wave me-2"></i>Đã hoàn tiền</button>
                                                                        </form>
                                                                    </li>
                                                                </c:if>
                                                            </ul>
                                                        </div>
                                                    </c:if>
                                                    <button type="button" class="btn btn-sm btn-outline-info" onclick="viewOrder('${root}', '${o.id}')" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="card-footer bg-light">
                    <nav aria-label="Page navigation">
                        <ul class="pagination mb-0 justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Trước</a>
                            </li>
                            <li class="page-item active">
                                <a class="page-link" href="#">1</a>
                            </li>

                            <li class="page-item">
                                <a class="page-link" href="#">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Admin Create Order Modal -->
<div class="modal fade" id="adminCreateOrderModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tạo Đơn Hàng Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Cột 1: Tìm kiếm & Chọn sản phẩm (Trái - Lớn) -->
                    <div class="col-lg-7 border-end">
                        <h6 class="text-muted mb-3"><i class="fas fa-box-open me-2"></i>Chọn Sản Phẩm</h6>
                        
                        <!-- Thanh tìm kiếm -->
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" id="createOrderSearchInput" class="form-control" placeholder="Tìm kiếm áo thun, kích cỡ, màu sắc..." autocomplete="off">
                        </div>
                        
                        <!-- Kết quả tìm kiếm (Dropdown/List) -->
                        <div id="searchProductResults" class="list-group mb-3 shadow-sm" style="max-height: 250px; overflow-y: auto; display: none; position: absolute; z-index: 1050; width: 95%;">
                            <!-- Dữ liệu render bằng JS -->
                        </div>
                        
                        <!-- Giỏ hàng nội bộ -->
                        <div class="table-responsive">
                            <table class="table table-sm align-middle text-center">
                                <thead class="table-light">
                                    <tr>
                                        <th class="text-start">Sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th style="width: 120px;">Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody id="createOrderCartBody">
                                    <!-- Giỏ hàng JS -->
                                    <tr id="emptyCartRow"><td colspan="5" class="text-muted py-3">Chưa có sản phẩm nào</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Cột 2: Thông tin Khách Hàng & Thanh toán (Phải - Nhỏ) -->
                    <div class="col-lg-5">
                        <h6 class="text-muted mb-3"><i class="fas fa-user me-2"></i>Thông Tin Khách Hàng</h6>
                        <form id="adminCreateOrderForm">
                            <div class="row mb-2">
                                <div class="col-md-6">
                                    <label class="form-label small">Họ Tên *</label>
                                    <input type="text" class="form-control form-control-sm" id="co_customerName" name="customerName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small">Điện thoại *</label>
                                    <input type="text" class="form-control form-control-sm" id="co_customerPhone" name="customerPhone" pattern="^(0|\+84)[35789][0-9]{8}$" required>
                                </div>
                            </div>
                            
                            <!-- GHN Dropdowns -->
                            <div class="row mb-2">
                                <div class="col-md-6">
                                    <label class="form-label small">Tỉnh / Thành *</label>
                                    <select id="co_province" name="province_id" class="form-select form-select-sm" required>
                                        <option value="">-- Chọn --</option>
                                    </select>
                                    <input type="hidden" name="province_name" id="co_provinceName">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small">Quận / Huyện *</label>
                                    <select id="co_district" name="district_id" class="form-select form-select-sm" disabled required>
                                        <option value="">-- Chọn --</option>
                                    </select>
                                    <input type="hidden" name="district_name" id="co_districtName">
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-md-12">
                                    <label class="form-label small">Phường / Xã *</label>
                                    <select id="co_ward" name="ward_code" class="form-select form-select-sm" disabled required>
                                        <option value="">-- Chọn --</option>
                                    </select>
                                    <input type="hidden" name="ward_name" id="co_wardName">
                                </div>
                            </div>
                            <div class="mb-2">
                                <label class="form-label small">Địa chỉ chi tiết (Số nhà, đường) *</label>
                                <input type="text" class="form-control form-control-sm" id="co_street" name="street" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small">Ghi chú (Tùy chọn)</label>
                                <textarea class="form-control form-control-sm" id="co_note" name="note" rows="2"></textarea>
                            </div>
                            
                            <hr>
                            
                            <!-- Payment & Total -->
                            <div class="d-flex justify-content-between mb-1 small">
                                <span>Tạm tính:</span>
                                <strong id="co_subTotalDisplay" data-value="0">0đ</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2 small">
                                <span>Phí vận chuyển:</span>
                                <strong id="co_shippingFeeDisplay" data-value="0">0đ</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="fw-bold fs-6">Tổng cộng:</span>
                                <strong class="text-danger fs-5" id="co_totalDisplay" data-value="0">0đ</strong>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label small">Trạng thái tạo đơn</label>
                                <select class="form-select form-select-sm" id="co_orderStatus" name="orderStatus" required>
                                    <option value="ADMIN_CONFIRMED">Đã Xác Nhận (Bởi Admin) - Giao Hàng</option>
                                    <option value="PAID_AT_COUNTER">Thanh Toán Tại Quầy</option>
                                </select>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary" id="btnSubmitCreateOrder">
                                    <i class="fas fa-check-circle me-1"></i> Chốt Đơn Hàng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Order Detail Modal -->
<div class="modal fade" id="orderDetailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi Tiết Đơn Hàng</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                ></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <h6 class="text-muted">Thông Tin Khách Hàng</h6>
                        <p class="mb-1"><strong id="modalCustomerName">Nguyễn Văn A</strong></p>
                        <p class="mb-1 small text-muted" id="modalCustomerEmail">nguyenvana@email.com</p>
                        <p class="small text-muted" id="modalCustomerPhone">0912345678</p>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-muted">Địa Chỉ Giao Hàng</h6>
                        <p class="small mb-1" id="modalShippingAddress">123 Đường ABC, Quận 1, TP. HCM</p>
                        <p class="small text-muted mb-0" id="modalOrderNote"></p>
                    </div>
                </div>

                <hr/>

                <h6 class="text-muted mb-3">Chi Tiết Sản Phẩm</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-sm align-middle">
                        <thead class="table-light">
                        <tr class="text-center">
                            <th>Hình Ảnh</th>
                            <th class="text-start">Sản Phẩm</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                        </thead>
                        <tbody id="modalItemsTbody">
                        <!-- Items rendered by JS -->
                        </tbody>
                    </table>
                </div>

                <hr/>

                <div class="row text-end">
                    <div class="col-md-8"></div>
                    <div class="col-md-4">
                        <p class="mb-1">Tạm tính: <strong id="modalSubtotal">500,000đ</strong></p>
                        <p class="mb-1">Phí vận chuyển: <strong id="modalFeeDelivery">0đ</strong></p>
                        <p class="mb-0 fw-bold">Tổng Cộng: <span class="text-danger fs-5" id="modalTotalPrice">500,000đ</span></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script>var contextPath = "${root}";</script>
<script src="${root}/admin/js/admin-common.js"></script>
<script src="${root}/admin/js/admin_Orders.js?v=<%= System.currentTimeMillis() %>"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("searchOrderInput");
    const statusFilter = document.getElementById("statusOrderFilter");
    const tableRows = document.querySelectorAll("#ordersTableBody tr");

    function filterOrders() {
        const searchVal = searchInput.value.toLowerCase().trim();
        const statusVal = statusFilter.value;

        tableRows.forEach(row => {
            if (row.classList.contains("no-orders-row")) return;
            
            const orderIdText = row.cells[0].textContent.toLowerCase();
            const customerText = row.cells[1].textContent.toLowerCase();
            const emailText = row.cells[2].textContent.toLowerCase();
            const exactStatus = row.getAttribute("data-exact-status");

            const matchesSearch = orderIdText.includes(searchVal) || customerText.includes(searchVal) || emailText.includes(searchVal);
            const matchesStatus = !statusVal || exactStatus === statusVal;

            if (matchesSearch && matchesStatus) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    if (searchInput) searchInput.addEventListener("input", filterOrders);
    if (statusFilter) statusFilter.addEventListener("change", filterOrders);
});
</script>
</body>
</html>
