<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Người Dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
</head>
<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="customer" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>
<div class="admin-container">
        <!-- ===== CONTENT ===== -->
    <main class="admin-content">
        <!-- Page Header -->
        <div class="page-header mb-5">
            <div>
                <h1 class="page-title" id="pageTitle">Chỉnh sửa Tài Khoản</h1>
            </div>
        </div>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="adminProfile">
                <div class="row">
                    <!-- Left Column - Form -->
                    <div class="col-lg-8">
                        <form id="customerForm" class="needs-validation" novalidate>
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Thông Tin Cá Nhân</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <label class="form-label fw-bold">Họ Tên</label>
                                            <input type="text" class="form-control" placeholder="Nhập họ tên" required/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Số Điện Thoại</label>
                                            <input type="tel" class="form-control" placeholder="Nhập số điện thoại" required/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Trạng Thái</label>
                                            <select class="form-select" id="categoryFilter">
                                                <option value="usr">Hoạt Động</option>
                                                <option value="admin">Không Hoạt Động</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Email</label>
                                            <input type="email" class="form-control" placeholder="Nhập email" required/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Vai Trò</label>
                                            <select class="form-select" id="categoryFilter">
                                                <option value="usr">User</option>
                                                <option value="admin">Admin</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Right Column - Actions & Info -->
                    <div class="col-lg-4">
                        <!-- Action Buttons -->
                        <div class="d-flex gap-2">
                            <button type="submit" form="customerForm" class="btn btn-primary btn-lg flex-grow-1">
                                <i class="fas fa-save"></i> Cập Nhật
                            </button>
                            <a href="${root}/admin-user" class="btn btn-outline-secondary btn-lg flex-grow-1"  style="background-color: red; color: white">
                                <i class="fas fa-times"></i> Hủy
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<%--<script src="js/admin-common.js"></script>--%>
<%--<script src="js/admin_customer.js"></script>--%>
</body>
</html>
