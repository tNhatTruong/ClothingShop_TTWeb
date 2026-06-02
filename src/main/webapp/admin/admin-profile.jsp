<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản Lý Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>

<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="profile" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>
<script>
    window.contextPath = '${root}';
</script>

        <!-- ===== CONTENT ===== -->
        <main class="admin-content">
            <!-- Alert Notifications -->
            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMsg" scope="session"/>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <!-- Page Header -->
            <div class="page-header mb-5">
                <div>
                    <h1 class="page-title">Quản Trị Viên</h1>
                </div>
            </div>

            <!-- Tabs Navigation -->
            <div class="row mb-4">
                <div class="col-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link ${param.tab != 'settings' ? 'active' : ''}" href="#adminProfile" data-bs-toggle="tab">
                                <i class="fas fa-user-circle"></i> Hồ Sơ Admin
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${param.tab == 'settings' ? 'active' : ''}" href="#settings" data-bs-toggle="tab">
                                <i class="fas fa-cog"></i> Cài Đặt
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Tab Content -->
            <div class="tab-content">
                <!-- Admin Profile Tab -->
                <div class="tab-pane fade ${param.tab != 'settings' ? 'show active' : ''}" id="adminProfile">
                    <div class="row">
                        <!-- Profile Info -->
                        <div class="col-lg-4 mb-4">
                            <div class="card shadow-sm text-center">
                                <div class="card-body pt-5">
                                    <img src="${root}/admin/images/logoadm.png" alt="Admin" class="rounded-circle mb-3" width="100" height="100"/>
                                    <h4 class="mb-1">${not empty sessionScope.auth ? sessionScope.auth.user_name : "Quản Trị Viên"}</h4>
                                    <p class="text-muted mb-3">
                                        <c:choose>
                                            <c:when test="${sessionScope.auth != null && 'qutoan23@gmail.com'.equalsIgnoreCase(sessionScope.auth.email)}">
                                                Admin Gốc
                                            </c:when>
                                            <c:otherwise>Admin</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="small text-muted">Tham gia: 05/01/2025</p>
                                    <button class="btn btn-primary btn-sm w-100" data-bs-toggle="modal" data-bs-target="#editAdminModal">
                                        <i class="fas fa-edit"></i> Chỉnh Sửa
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Profile Details -->
                        <div class="col-lg-8">
                            <div class="card shadow-sm">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Thông Tin Chi Tiết</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Họ Tên</label>
                                            <p class="fw-bold">${not empty sessionScope.auth ? sessionScope.auth.user_name : "Quản Trị Viên"}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Email</label>
                                            <p class="fw-bold">${not empty sessionScope.auth ? sessionScope.auth.email : "admin@styleera.com"}</p>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Số Điện Thoại</label>
                                            <p class="fw-bold">${not empty sessionScope.auth ? sessionScope.auth.phone : "Chưa cập nhật"}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Vai Trò</label>
                                            <p class="fw-bold">
                                                <span class="badge bg-primary">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.auth != null && 'qutoan23@gmail.com'.equalsIgnoreCase(sessionScope.auth.email)}">
                                                            Admin Gốc
                                                        </c:when>
                                                        <c:otherwise>Admin</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <label class="form-label text-muted">Địa Chỉ</label>
                                            <p class="fw-bold">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.auth.addresses}">
                                                        ${sessionScope.auth.addresses[0].street}, ${sessionScope.auth.addresses[0].district}, ${sessionScope.auth.addresses[0].province}
                                                    </c:when>
                                                    <c:otherwise>Chưa cập nhật địa chỉ</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Change Password -->
                            <div class="card shadow-sm mt-4">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Đổi Mật Khẩu</h6>
                                </div>
                                <div class="card-body">
                                    <form id="changePasswordForm">
                                        <div class="mb-3">
                                            <label class="form-label">Mật Khẩu Hiện Tại</label>
                                            <input type="password" class="form-control" placeholder="Nhập mật khẩu hiện tại"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mật Khẩu Mới</label>
                                            <input type="password" class="form-control" placeholder="Nhập mật khẩu mới"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Xác Nhận Mật Khẩu</label>
                                            <input type="password" class="form-control" placeholder="Xác nhận mật khẩu mới"/>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Cập Nhật Mật Khẩu</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Settings Tab -->
                <div class="tab-pane fade ${param.tab == 'settings' ? 'show active' : ''}" id="settings">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card shadow-sm">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Cập Nhật Thông Tin Cá Nhân</h6>
                                </div>
                                <div class="card-body">
                                    <form action="${root}/admin-profile" method="post" id="adminInfoForm">
                                        <div class="mb-3">
                                            <label class="form-label">Email Đăng Nhập</label>
                                            <input type="email" class="form-control" value="${sessionScope.auth.email}" disabled style="background-color: #e9ecef;"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Họ và Tên</label>
                                            <input type="text" class="form-control" name="fullname" value="${sessionScope.auth.user_name}" required/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số Điện Thoại</label>
                                            <input type="text" class="form-control" name="phone" value="${sessionScope.auth.phone}" placeholder="Nhập số điện thoại"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Địa Chỉ Cụ Thể</label>
                                            <input type="text" class="form-control" name="address" value="${userAddress.street}" placeholder="Số nhà, tên đường..."/>
                                        </div>
                                        
                                        <div class="row mb-4">
                                            <div class="col-md-6 mb-3 mb-md-0">
                                                <label class="form-label">Tỉnh / Thành phố</label>
                                                <select id="adminProvince" class="form-select" data-selected="${userAddress.province}">
                                                    <option value="">-- Chọn Tỉnh / Thành phố --</option>
                                                </select>
                                                <input type="hidden" name="city" id="adminCityName" value="${userAddress.province}"/>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Quận / Huyện</label>
                                                <select id="adminDistrict" class="form-select" data-selected="${userAddress.district}" disabled>
                                                    <option value="">-- Chọn Quận / Huyện --</option>
                                                </select>
                                                <input type="hidden" name="district" id="adminDistrictName" value="${userAddress.district}"/>
                                            </div>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i> Lưu Cài Đặt
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Edit Admin Modal -->
<div class="modal fade" id="editAdminModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chỉnh Sửa Hồ Sơ Admin</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editAdminForm">
                    <div class="mb-3">
                        <label class="form-label">Họ Tên</label>
                        <input type="text" class="form-control" value="${not empty sessionScope.auth ? sessionScope.auth.user_name : 'Quản Trị Viên'}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" value="${not empty sessionScope.auth ? sessionScope.auth.email : 'admin@styleera.com'}"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary">Lưu</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/admin/js/admin-common.js"></script>
<script src="${root}/admin/js/admin-dashboard.js"></script>
<script src="${root}/admin/js/admin_Profile.js"></script>
</body>
</html>
