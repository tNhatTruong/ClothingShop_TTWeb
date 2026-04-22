<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Bảng Điều Khiển Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>

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
                                    <h3 class="mb-0">${totalUser.size()} người dùng</h3>
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
                                    <p class="text-muted small mb-1">Tổng giá tiền các sản phẩm</p>
                                    <h3 class="mb-0"><fmt:formatNumber value="${totalProductPrice}" pattern="#,### VNĐ"/></h3>
                                </div>
                                <div class="stat-icon bg-warning text-white rounded-circle p-3">
                                    <i class="fas fa-dollar-sign fa-lg"></i>
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
                                    <p class="text-muted small mb-1">Tổng Sản Phẩm hiện có</p>
                                    <h3 class="mb-0">${totalQuantity} sản phẩm</h3>
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
                        <div class="card-header bg-light border-bottom">
                            <h6 class="mb-0">Doanh Thu Theo Tháng</h6>
                        </div>
                        <div class="card-body p-3">
                            <div class="chart-container">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Category -->
                <div class="col-lg-4 col-md-12">
                    <div class="card shadow-sm h-100">
                        <div class="card-header bg-light border-bottom">
                            <h6 class="mb-0">Thống kê Danh Mục hiện có</h6>
                        </div>
                        <div class="card-body">
                            <div class="category-list">
                                <c:forEach items="${categoryStats}" var="c">
                                    <div class="category-item d-flex justify-content-between align-items-center mb-2">
                                        <span>${c.name}</span>
                                        <span class="badge bg-primary">
                                             ${c.percent}%
                                        </span>
                                    </div>
                                </c:forEach>
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
                            <a href="${root}/admin/admin-orders.jsp" class="btn btn-sm btn-primary">Xem tất cả</a>
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
                                            <td> <strong>${order.createdAt.toString().replace('T', ' ')}</strong></td>
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
                                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-light">

                                        <div>
                                            <strong>${st.index + 1}.</strong>
                                                ${p.product_name}
                                            <div class="text-danger small"> Đánh giá: ${p.medium_rating}
                                            </div>
                                        </div>

                                        <c:if test="${not empty p.thumbnail}">
                                            <div class="product-img-wrapper me-3">
                                                <img src="${pageContext.request.contextPath}${p.thumbnail}"
                                                     alt="${p.product_name}"
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

<!-- Custom JS -->
<script src="${root}/admin/js/admin-common.js"></script>
<script src="${root}/admin/js/admin-dashboard.js"></script>
</body>
</html>
