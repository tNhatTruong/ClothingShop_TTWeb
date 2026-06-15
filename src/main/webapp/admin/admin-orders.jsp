<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
            <div class="page-header mb-5">
                <div>
                    <h1 class="page-title">Quản Lý Đơn Hàng</h1>
                </div>
            </div>

            <!-- Tính toán các trạng thái đơn hàng -->
            <c:set var="pendingCount" value="0" />
            <c:set var="shippingCount" value="0" />
            <c:set var="deliveredCount" value="0" />
            <c:set var="cancelledCount" value="0" />
            <c:forEach items="${orders}" var="o">
                <c:choose>
                    <c:when test="${o.status eq 'Chờ vận chuyển'}">
                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đang vận chuyển'}">
                        <c:set var="shippingCount" value="${shippingCount + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đã Giao'}">
                        <c:set var="deliveredCount" value="${deliveredCount + 1}" />
                    </c:when>
                    <c:when test="${o.status eq 'Đã hủy'}">
                        <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                    </c:when>
                </c:choose>
            </c:forEach>

            <!-- Stats -->
            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-info">${pendingCount}</h3>
                            <p class="text-muted small mb-0">Chờ Vận chuyển</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-warning">${shippingCount}</h3>
                            <p class="text-muted small mb-0">Đang Vận chuyển</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-success">${deliveredCount}</h3>
                            <p class="text-muted small mb-0">Đã Giao</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-danger">${cancelledCount}</h3>
                            <p class="text-muted small mb-0">Đã Hủy</p>
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
                                <option value="Chờ vận chuyển">Chờ vận chuyển</option>
                                <option value="Đang vận chuyển">Đang vận chuyển</option>
                                <option value="Đã Giao">Đã Giao</option>
                                <option value="Đã hủy">Đã hủy</option>
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
                                        <tr class="text-center align-middle">
                                            <td><strong>#${o.id}</strong></td>
                                            <td>${o.userName}</td>
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
                                                    <c:when test="${o.status eq 'Đã hủy'}">
                                                        <span class="badge bg-danger">${o.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${o.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <!-- Dropdown đổi trạng thái -->
                                                <div class="d-flex gap-1 justify-content-center flex-wrap">
                                                    <form action="${root}/admin-update-order-status" method="post" class="d-flex gap-1">
                                                        <input type="hidden" name="orderId" value="${o.id}">
                                                        <select name="status" class="form-select form-select-sm" style="width:160px; font-size:12px;"
                                                                onchange="this.form.submit()" title="Đổi trạng thái">
                                                            <option value="Chờ vận chuyển"  ${o.status eq 'Chờ vận chuyển'  ? 'selected' : ''}>Chờ vận chuyển</option>
                                                            <option value="Đang vận chuyển" ${o.status eq 'Đang vận chuyển' ? 'selected' : ''}>Đang vận chuyển</option>
                                                            <option value="Đã Giao"         ${o.status eq 'Đã Giao'         ? 'selected' : ''}>Đã Giao</option>
                                                            <option value="Đã hủy"          ${o.status eq 'Đã hủy'          ? 'selected' : ''}>Đã hủy</option>
                                                        </select>
                                                    </form>
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
                        <p class="mb-1"><strong>Nguyễn Văn A</strong></p>
                        <p class="mb-1 small text-muted">nguyenvana@email.com</p>
                        <p class="small text-muted">0912345678</p>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-muted">Địa Chỉ Giao Hàng</h6>
                        <p class="small mb-0">123 Đường ABC, Quận 1, TP. HCM</p>
                    </div>
                </div>

                <hr/>

                <h6 class="text-muted mb-3">Chi Tiết Sản Phẩm</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-sm">
                        <thead class="table-light">
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Áo Khoác Nam</td>
                            <td>1</td>
                            <td>500,000đ</td>
                            <td>500,000đ</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <hr/>

                <div class="row text-end">
                    <div class="col-md-8"></div>
                    <div class="col-md-4">
                        <p class="mb-1">Tổng: <strong>500,000đ</strong></p>
                        <p class="mb-1">Phí vận chuyển: <strong>0đ</strong></p>
                        <p class="mb-0 fw-bold">Tổng Cộng: 500,000đ</p>
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
<script src="${root}/admin/js/admin-common.js"></script>
<script src="${root}/admin/js/admin_Orders.js"></script>
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
            const statusText = row.cells[5].textContent.trim();

            const matchesSearch = orderIdText.includes(searchVal) || customerText.includes(searchVal) || emailText.includes(searchVal);
            const matchesStatus = !statusVal || statusText === statusVal;

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
