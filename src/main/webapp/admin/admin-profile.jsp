<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản Lý Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
</head>

<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="profile" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

        <!-- ===== CONTENT ===== -->
        <main class="admin-content">
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
                            <a class="nav-link active" href="#adminProfile" data-bs-toggle="tab">
                                <i class="fas fa-user-circle"></i> Hồ Sơ Admin
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#settings" data-bs-toggle="tab">
                                <i class="fas fa-cog"></i> Cài Đặt
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Tab Content -->
            <div class="tab-content">
                <!-- Admin Profile Tab -->
                <div class="tab-pane fade show active" id="adminProfile">
                    <div class="row">
                        <!-- Profile Info -->
                        <div class="col-lg-4 mb-4">
                            <div class="card shadow-sm text-center">
                                <div class="card-body pt-5">
                                    <img src="images/logoadm.png" alt="Admin" class="rounded-circle mb-3" width="100" height="100"/>
                                    <h4 class="mb-1">Quản Trị Viên</h4>
                                    <p class="text-muted mb-3">Admin</p>
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
                                            <p class="fw-bold">Quản Trị Viên</p>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Email</label>
                                            <p class="fw-bold">admin@styleera.com</p>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted"
                                            >Số Điện Thoại</label
                                            >
                                            <p class="fw-bold">0904899626</p>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Vai Trò</label>
                                            <p class="fw-bold">
                                                <span class="badge bg-primary">Admin</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <label class="form-label text-muted">Địa Chỉ</label>
                                            <p class="fw-bold">
                                                376, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Việt
                                                Nam
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
                <div class="tab-pane fade" id="settings">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card shadow-sm">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Cài Đặt Chung</h6>
                                </div>
                                <div class="card-body">
                                    <form id="settingsForm">
                                        <div class="mb-3">
                                            <label class="form-label">Tên Cửa Hàng</label>
                                            <input type="text" class="form-control" value="StyleEra Fashion Store"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email Liên Hệ</label>
                                            <input type="email" class="form-control" value="contact@styleera.com"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số Điện Thoại</label>
                                            <input type="tel" class="form-control" value="0904899626"/>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Lưu Cài Đặt</button>
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
                        <input type="text" class="form-control" value="Quản Trị Viên"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" value="admin@styleera.com"/>
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
<script src="js/admin-common.js"></script>
<script src="js/admin-dashboard.js"></script>
<script src="js/admin_Profile.js"></script>
</body>
</html>
