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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>
<body>
<c:set var="currentPage" value="category" scope="request"/>
<!-- ===== HEADER ===== -->
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

<main class="admin-content">
    <div class="page-header mb-5">
        <div>
            <h1 class="page-title">Quản Lý Danh Mục</h1>
        </div>
        <div class="page-actions">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
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
                                        <td>
                                            <form action="${root}/AdminDeleteCategory"
                                                  method="post"
                                                  onsubmit="return confirm('Bạn chắc chắn muốn xoá danh mục này?')">

                                                <input type="hidden" name="id" value="${s.id}">

                                                <button type="submit" class="btn btn-sm btn-danger" title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
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
<script src="${root}/admin/js/admin-category.js"></script>
</body>
</html>
