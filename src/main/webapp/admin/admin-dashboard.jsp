<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
<c:if test="${empty dashboardLoaded}">
    <c:redirect url="${root}/AdminDashboard"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Bảng Điều Khiển Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css?v=1.2"/>

</head>
<body>

<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="dashboard" scope="request"/>

    <%@ include file="/admin/layout/Layoutadmin.jsp" %>


    <!-- ===== CONTENT ===== -->
        <main class="admin-content">
            <!-- Page Header -->
            <div class="page-header mb-5">
                <div>
                    <h1 class="page-title">Bảng Điều Khiển</h1>
                </div>
            </div>

            <!-- Stat Cards -->
            <div class="row mb-5 g-4">
                <!-- Customers -->
                <div class="col-md-6 col-lg-3">
                    <div class="card stat-card shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div>
                                    <p class="text-muted small mb-1">Tổng số Người dùng</p>
                                    <h3 class="mb-0">${totalUser} người dùng</h3>
                                </div>
                                <div class="stat-icon bg-primary text-white rounded-circle p-3">
                                    <i class="fas fa-users fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Orders -->
                <div class="col-md-6 col-lg-3">
                    <div class="card stat-card shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div>
                                    <p class="text-muted small mb-1">Tổng số Đơn Hàng</p>
                                    <h3 class="mb-0">${totalOrders} đơn hàng</h3>
                                </div>
                                <div class="stat-icon bg-success text-white rounded-circle p-3">
                                    <i class="fas fa-shopping-cart fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Revenue -->
                <div class="col-md-6 col-lg-3">
                    <div class="card stat-card shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div>
                                    <p class="text-muted small mb-1">Doanh Thu (Đã Giao)</p>
                                    <h3 class="mb-0"><fmt:formatNumber value="${totalRevenue}" pattern="#,### VNĐ"/></h3>
                                </div>
                                <div class="stat-icon bg-warning text-white rounded-circle p-3">
                                    <i class="fas fa-coins fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products -->
                <div class="col-md-6 col-lg-3">
                    <div class="card stat-card shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div>
                                    <p class="text-muted small mb-1">Tổng Sản Phẩm</p>
                                    <h3 class="mb-0">${totalProducts} sản phẩm</h3>
                                </div>
                                <div class="stat-icon bg-danger text-white rounded-circle p-3">
                                    <i class="fas fa-box fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Revenue Chart -->
                <div class="col-lg-8 col-md-12">
                    <div class="card shadow-sm h-100">
                        <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                            <h6 class="mb-0">Thống Kê Doanh Thu</h6>
                            <div class="btn-group btn-group-sm" role="group" aria-label="Lựa chọn biểu đồ">
                                <input type="radio" class="btn-check" name="chartToggle" id="btnMonthly" autocomplete="off" checked>
                                <label class="btn btn-outline-primary" for="btnMonthly">Theo Tháng (Năm nay)</label>

                                <input type="radio" class="btn-check" name="chartToggle" id="btnDaily" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btnDaily">Theo Ngày (Tháng này)</label>
                            </div>
                        </div>
                        <div class="card-body p-3">
                            <div class="chart-container">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Urgent Tasks -->
                <div class="col-lg-4 col-md-12">
                    <div class="card shadow-sm h-100 border-warning">
                        <div class="card-header bg-warning text-dark border-bottom">
                            <h6 class="mb-0"><i class="fas fa-bell me-2"></i>Việc Cần Làm Ngay</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="accordion accordion-flush" id="urgentTasksAccordion">
                                
                                <!-- Đơn hàng chờ duyệt -->
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button <c:if test='${pendingApprovalCount == 0}'>collapsed</c:if>" type="button" data-bs-toggle="collapse" data-bs-target="#collapsePending" aria-expanded="<c:out value='${pendingApprovalCount > 0}'/>" aria-controls="collapsePending">
                                            <span>
                                                <i class="fas fa-file-invoice me-2 text-primary"></i>
                                                <c:choose>
                                                    <c:when test="${pendingApprovalCount > 0}">Có <strong>${pendingApprovalCount}</strong> đơn hàng chờ duyệt</c:when>
                                                    <c:otherwise>Không có đơn hàng chờ duyệt</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:if test="${pendingApprovalCount > 0}">
                                                <span class="badge bg-danger rounded-pill ms-auto me-2">Xử lý ngay</span>
                                            </c:if>
                                        </button>
                                    </h2>
                                    <div id="collapsePending" class="accordion-collapse collapse <c:if test='${pendingApprovalCount > 0}'>show</c:if>" data-bs-parent="#urgentTasksAccordion">
                                        <div class="accordion-body p-0">
                                            <div class="list-group list-group-flush">
                                                <c:forEach items="${pendingOrders}" var="o">
                                                    <div class="list-group-item d-flex justify-content-between align-items-center bg-light">
                                                        <div>
                                                            <small class="fw-bold">Mã ĐH: #${o.id}</small><br>
                                                            <small class="text-muted"><fmt:formatNumber value="${o.totalPrice}" pattern="#,### VNĐ"/></small>
                                                        </div>
                                                        <a href="${root}/admin-orders" class="btn btn-sm btn-outline-primary">Xem</a>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${pendingApprovalCount > 3}">
                                                    <a href="${root}/admin-orders" class="list-group-item text-center text-primary py-2 small fw-bold">Xem tất cả ${pendingApprovalCount} đơn...</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Yêu cầu trả hàng -->
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseReturn" aria-expanded="false" aria-controls="collapseReturn">
                                            <span>
                                                <i class="fas fa-undo-alt me-2 text-danger"></i>
                                                <c:choose>
                                                    <c:when test="${returnRequestedCount > 0}">Có <strong>${returnRequestedCount}</strong> yêu cầu trả hàng</c:when>
                                                    <c:otherwise>Không có yêu cầu trả hàng</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:if test="${returnRequestedCount > 0}">
                                                <span class="badge bg-danger rounded-pill ms-auto me-2">Xử lý ngay</span>
                                            </c:if>
                                        </button>
                                    </h2>
                                    <div id="collapseReturn" class="accordion-collapse collapse" data-bs-parent="#urgentTasksAccordion">
                                        <div class="accordion-body p-0">
                                            <div class="list-group list-group-flush">
                                                <c:forEach items="${returnOrders}" var="o">
                                                    <div class="list-group-item d-flex justify-content-between align-items-center bg-light">
                                                        <div>
                                                            <small class="fw-bold">Mã ĐH: #${o.id}</small><br>
                                                            <small class="text-muted"><fmt:formatNumber value="${o.totalPrice}" pattern="#,### VNĐ"/></small>
                                                        </div>
                                                        <a href="${root}/admin-orders" class="btn btn-sm btn-outline-danger">Xem</a>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${returnRequestedCount > 3}">
                                                    <a href="${root}/admin-orders" class="list-group-item text-center text-danger py-2 small fw-bold">Xem tất cả ${returnRequestedCount} yêu cầu...</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sản phẩm sắp hết hàng -->
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLowStock" aria-expanded="false" aria-controls="collapseLowStock">
                                            <span>
                                                <i class="fas fa-exclamation-triangle me-2 text-warning"></i>
                                                <c:choose>
                                                    <c:when test="${lowStockCount > 0}">Có <strong>${lowStockCount}</strong> sản phẩm sắp hết</c:when>
                                                    <c:otherwise>Tồn kho ổn định</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:if test="${lowStockCount > 0}">
                                                <span class="badge bg-warning text-dark rounded-pill ms-auto me-2">Nhập hàng</span>
                                            </c:if>
                                        </button>
                                    </h2>
                                    <div id="collapseLowStock" class="accordion-collapse collapse" data-bs-parent="#urgentTasksAccordion">
                                        <div class="accordion-body p-0">
                                            <div class="list-group list-group-flush">
                                                <c:forEach items="${lowStockVariantsList}" var="v">
                                                    <div class="list-group-item d-flex justify-content-between align-items-center bg-light">
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty v.product.thumbnail}">
                                                                <img src="${root}${v.product.thumbnail}" style="width: 32px; height: 32px; object-fit: cover; border-radius: 4px;" class="me-2" alt="">
                                                            </c:if>
                                                            <div>
                                                                <small class="fw-bold text-truncate" style="max-width: 140px; display: inline-block;" title="${v.product.product_name}">${v.product.product_name}</small><br>
                                                                <small class="text-muted">Màu ${v.color} - Size ${v.size} (Còn: <span class="text-danger fw-bold">${v.quantity}</span>)</small>
                                                            </div>
                                                        </div>
                                                        <a href="${root}/admin-products" class="btn btn-sm btn-outline-warning text-dark">Xem</a>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${lowStockCount > 3}">
                                                    <a href="${root}/admin-products" class="list-group-item text-center text-warning text-dark py-2 small fw-bold">Xem tất cả ${lowStockCount} sản phẩm...</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <!-- Recent Orders -->
                <div class="col-lg-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                            <h6 class="mb-0">Đơn Hàng Gần Đây</h6>
                            <a href="${root}/admin-orders" class="btn btn-sm btn-primary">Xem tất cả</a>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                    <tr class="text-center align-middle">
                                        <th>Mã ĐH</th>
                                        <th>Ngày Đặt</th>
                                        <th>Tổng Tiền</th>
                                        <th>Trạng Thái</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="order" items="${latestOrders}">
                                        <tr class="text-center align-middle">
                                            <td>#${order.id}</td>
                                            <td> <strong>${order.formattedCreatedAt}</strong></td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalPrice}" pattern="#,### VNĐ"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'Chờ vận chuyển'}">
                                                        <span class="badge bg-info">${order.status}</span>
                                                    </c:when>

                                                    <c:when test="${order.status == 'Đang vận chuyển'}">
                                                        <span class="badge bg-warning text-dark">${order.status}</span>
                                                    </c:when>

                                                    <c:when test="${order.status == 'Đã hủy'}">
                                                        <span class="badge bg-danger">${order.status}</span>
                                                    </c:when>

                                                    <c:when test="${order.status == 'Đã Giao'}">
                                                        <span class="badge bg-success">${order.status}</span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top 5 Products bán chạy nhất -->
                <div class="col-lg-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-light border-bottom">
                            <h6 class="mb-0">Top 5 Sản Phẩm Bán Chạy</h6>
                        </div>
                        <div class="card-body p-0">
                            <ol class="list-group list-group-flush">
                                <c:forEach items="${bestSellers}" var="p" varStatus="st">
                                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-light px-3 py-2">

                                        <div class="ps-2">
                                            <strong class="me-1">${st.index + 1}.</strong>
                                            <span class="fw-medium">${p.product_name}</span>
                                            <div class="text-success small mt-1"> 
                                                <i class="fas fa-shopping-cart me-1"></i>Tổng số lượng đã bán: <strong>${p.sold_quantity}</strong>
                                            </div>
                                        </div>

                                        <c:if test="${not empty p.thumbnail}">
                                            <div class="product-img-wrapper">
                                                <img src="${pageContext.request.contextPath}${p.thumbnail}"
                                                     alt="${p.product_name}"
                                                     style="width: 48px; height: 48px; object-fit: cover; border-radius: 6px; border: 1px solid #dee2e6;"
                                                     class="product-img"/>
                                            </div>
                                        </c:if>

                                    </li>
                                </c:forEach>
                            </ol>

                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

<script>
    window.dashboardChartData = {
        labels: [
            <c:forEach items="${monthlyLabels}" var="label" varStatus="s">
            "${label}"<c:if test="${!s.last}">,</c:if>
            </c:forEach>
        ],
        data: [
            <c:forEach items="${monthlyData}" var="amount" varStatus="s">
            ${amount}<c:if test="${!s.last}">,</c:if>
            </c:forEach>
        ]
    };

    window.monthlyLabels = window.dashboardChartData.labels;
    window.monthlyData = window.dashboardChartData.data;
    
    window.dailyLabels = [
        <c:forEach items="${dailyLabels}" var="label" varStatus="s">
        "${label}"<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
    window.dailyData = [
        <c:forEach items="${dailyData}" var="amount" varStatus="s">
        ${amount}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
</script>

<!-- Custom JS -->
<script src="${root}/admin/js/admin-common.js?v=2"></script>
<script src="${root}/admin/js/admin-dashboard.js?v=2"></script>
</body>
</html>
