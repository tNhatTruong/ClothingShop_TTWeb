<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản Lý Danh Mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin_category.css"/>
</head>
<body>
<c:set var="currentPage" value="category" scope="request"/>
<!-- ===== HEADER ===== -->
<%@ include file="/admin/layout/Layoutadmin.jsp" %>
<c:if test="${not empty sessionScope.toastMessage}">
    <div class="toast-container position-fixed top-0 end-0 p-4" style="z-index: 1055; margin-top: 60px;">

        <div id="successToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
            <div class="d-flex">
                <div class="toast-body fw-semibold" style="font-size: 0.95rem;">
                    <i class="fas fa-check-circle me-2 fs-5 align-middle"></i>
                        ${sessionScope.toastMessage}
                </div>
                <button type="button" class="btn-close btn-close-white me-3 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <c:remove var="toastMessage" scope="session" />

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var toastEl = document.getElementById('successToast');
            if(toastEl) {
                var toast = new bootstrap.Toast(toastEl);
                toast.show();
            }
        });
    </script>
</c:if>
<main class="admin-content">
    <div class="page-header mb-5">
        <div>
            <h1 class="page-title">Quản Lý Danh Mục</h1>
        </div>
        <div class="page-actions">
            <button class="btn btn-primary" onclick="openCategoryModal()" >
                <i class="fas fa-plus"></i> Thêm Danh Mục
            </button>
        </div>
    </div>

    <!-- Filters & Search -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form method="GET" action="${root}/admin-category" class="filter-form">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label">Tìm Kiếm</label>
                        <input type="text" class="form-control" name="search" id="searchInput" placeholder="Tên sản phẩm..." value="${searchValue}"/>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Danh mục</label>
                        <select class="form-select" name="parentCategory" id="parentCategoryFilter">
                            <option value="">Tất Cả Danh Mục</option>
                            <c:forEach items="${parentCategoryList}" var="p">
                                <option value="${p.name}" <c:if test="${p.name eq parentCategoryValue}">selected</c:if>>${p.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Phân Loại</label>
                        <select class="form-select" name="subCategory" id="subCategoryFilter">
                            <option value="">Các Phân Loại</option>
                            <c:forEach items="${parentCategoryList}" var="p">
                                <c:forEach items="${p.subCategories}" var="s">
                                    <option value="${s.name}" data-parent="${p.name}" <c:if test="${s.name eq subCategoryValue}">selected</c:if>>${s.name}</option>
                                </c:forEach>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="card shadow-sm">
        <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
            <h6 class="mb-0">Danh Sách Các Danh Mục Sản Phẩm</h6>
            <span class="text-muted small">Tổng cộng:
            <strong>
                <c:set var="total" value="0"/>
                <c:forEach items="${filteredCategoryList}" var="p">
                    <c:set var="total" value="${total + p.subCategories.size()}"/>
                </c:forEach>
                ${total}
            </strong>
        </span>

        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="productsTable">
                    <thead class="table-light">
                    <tr class="text-center align-middle">
                        <th>ID</th>
                        <th>Ảnh Danh Mục</th>
                        <th>Tên Danh Mục</th>
                        <th>Phân Loại</th>
                        <th style="min-width: 250px">Mô Tả</th>
                        <th style="width: 150px">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty filteredCategoryList}">
                            <tr>
                                <td colspan="6" class="text-center">
                                    <i class="fas fa-inbox fa-2x"></i>
                                    <p>Chưa có danh mục nào</p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>

                            <c:forEach items="${filteredCategoryList}" var="p">
                                <c:forEach items="${p.subCategories}" var="s">
                                    <tr class="text-center align-middle">
                                        <td>${s.id}</td>
                                        <td>
                                            <c:if test ="${not empty s.image}">
                                                <img src="${root}${s.image}" width="80" height="80"
                                                     style="object-fit:cover;border-radius:4px">
                                            </c:if>
                                            <c:if test="${empty s.image}">
                                                <img src="https://via.placeholder.com/60" alt="No image" width="60" height="60">
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.name eq 'Nam'}">
                                                    <span class="badge bg-primary">${p.name}</span>
                                                </c:when>
                                                <c:when test="${p.name eq 'Nữ'}">
                                                    <span class="badge bg-danger">${p.name}</span>
                                                </c:when>
                                                <c:when test="${p.name eq 'Đồ Đôi'}">
                                                    <span class="badge bg-dark">${p.name}</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td> <strong>${s.name}</strong> </td>

                                        <td>${empty s.description ? "—" : s.description}</td>
                                        <td class="text-center align-middle">
                                            <div class="d-flex justify-content-center align-items-center gap-2">
                                                <button type="button" class="btn btn-sm btn-warning" title="Sửa"
                                                        data-id="${s.id}"
                                                        data-parent-id="${p.id}"
                                                        data-name="${s.name}"
                                                        data-desc="${s.description}"
                                                        data-img="${not empty s.image ? root.concat(s.image) : ''}"
                                                        onclick="openCategoryModal(this)">
                                                    <i class="fas fa-edit"></i>
                                                </button>

                                                <form action="${root}/AdminDeleteCategory"
                                                      method="post"
                                                      class="m-0"
                                                      onsubmit="return confirm('Bạn chắc chắn muốn xoá danh mục này?')">

                                                    <input type="hidden" name="id" value="${s.id}">

                                                    <button type="submit" class="btn btn-sm btn-danger" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
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
<div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="categoryForm" action="${root}/AdminCategoryAction" method="POST" enctype="multipart/form-data">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold" id="categoryModalLabel">Thêm Danh Mục Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="subCategoryId" id="subCategoryId" value="">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Danh Mục Gốc <span class="text-danger">*</span></label>
                        <select class="form-select" name="parentId" id="parentId" required>
                            <option value="">-- Chọn danh mục gốc --</option>
                            <c:forEach items="${parentCategoryList}" var="parent">
                                <option value="${parent.id}">${parent.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên Phân Loại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="subCategoryName" id="subCategoryName"
                               placeholder="VD: Áo Khoác, Quần Jean..." required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô Tả</label>
                        <textarea class="form-control" name="description" id="categoryDesc" rows="3"
                                  placeholder="Nhập mô tả ngắn gọn..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Ảnh Danh Mục</label>
                        <input type="file" class="form-control" name="imageFile" id="categoryImage" accept="image/*">

                        <div class="mt-3" id="imagePreviewContainer" style="display: none;">
                            <p class="text-muted small mb-1">Ảnh hiện tại:</p>
                            <div class="position-relative d-inline-block">
                                <img id="imagePreview" src="" alt="Preview" width="90" height="90"
                                     style="border-radius: 8px; object-fit: cover; border: 1px solid #ddd;">

                                <button type="button" id="btnDeletePreview"
                                        class="btn btn-danger btn-sm position-absolute rounded-circle p-0 d-flex align-items-center justify-content-center"
                                        style="top: -8px; right: -8px; width: 22px; height: 22px; font-size: 11px; z-index: 10; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>

                        <input type="hidden" name="isImageDeleted" id="isImageDeleted" value="false">
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy Bỏ</button>
                    <button type="submit" class="btn btn-primary" id="btnSubmitCategory">
                        <i class="fas fa-save"></i> <span>Lưu Danh Mục</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${root}/admin/js/admin-category.js"></script>
</body>
</html>
