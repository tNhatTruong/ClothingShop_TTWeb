<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản lý bình luận</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
</head>
<body>

<c:set var="currentPage" value="comment" scope="request"/>
<!-- ===== HEADER ===== -->
<%@ include file="/admin/layout/Layoutadmin.jsp" %>
<main class="admin-content">
    <!-- Page Header -->
    <div class="page-header mb-5">
        <div>
            <h1 class="page-title">Quản lý Bình Luận</h1>
        </div>
        <div class="page-actions">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                <i class="fas fa-plus"></i> Thêm Tài Khoản
            </button>
        </div>
    </div>
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label class="form-label">Tìm Kiếm</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Tên tài khoản"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Ngày Bình luận</label>
                    <select class="form-select" id="categoryFilter">
                        <option value="">Tất Cả các ngày</option>
                        <option value="admin">Bình luận cũ nhất</option>
                        <option value="usr">Bình luận mới nhất</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="tab-pane">
            <div class="card shadow-sm">
                <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Danh Sách Bình Luận</h6>
                    <span class="text-muted small">Tổng cộng: <strong>1</strong> Người dùng</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Tên khách hàng</th>
                                <th>Ngày bình luận</th>
                                <th>Ảnh bình luận</th>
                                <th>Màu</th>
                                <th>Size</th>
                                <th>Lời bình luận</th>
                                <th>Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>#3</td>
                                <td>T***h</td>
                                <td>2025-20-11</td>
                                <td><img src="" alt="no picture"></td>
                                <td>Xanh</td>
                                <td>L</td>
                                <td>0904899626</td>
                                <td>
                                    <button class="btn btn-sm btn-danger" title="Xóa">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
