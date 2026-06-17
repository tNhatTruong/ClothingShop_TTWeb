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
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
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
    </div>
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form action="${root}/admin-reviews" method="GET" class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label class="form-label">Tìm Kiếm</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Tên tài khoản"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Phân loại đánh giá</label>
                    <select class="form-select" name="ratingFilter" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <option value="good" ${param.ratingFilter == 'good' ? 'selected' : ''}>Tốt (4 - 5 sao)</option>
                        <option value="average" ${param.ratingFilter == 'average' ? 'selected' : ''}>Trung bình (3 - 4 sao)</option>
                        <option value="bad" ${param.ratingFilter == 'bad' ? 'selected' : ''}>Tệ (1 - 3 sao)</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Ngày Bình luận</label>
                    <select class="form-select" name="dateSort" onchange="this.form.submit()">
                        <option value="newest" ${param.dateSort == 'newest' ? 'selected' : ''}>Bình luận mới nhất</option>
                        <option value="oldest" ${param.dateSort == 'oldest' ? 'selected' : ''}>Bình luận cũ nhất</option>
                    </select>
                </div>
            </form>
        </div>
    </div>
    <div>
        <div class="tab-pane">
            <div class="card shadow-sm">
                <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Danh Sách Bình Luận</h6>
                    <span class="text-muted small">Tổng cộng: <strong>${totalReviews}</strong> Bình luận</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Sản phẩm</th>
                                <th>Người dùng</th>
                                <th>Đánh giá</th>
                                <th>Nội dung</th>
                                <th>Ngày tạo</th>
                                <th>Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${reviewList}">
                                <tr>
                                    <td>#${item.id}</td>

                                    <td>Mã SP: ${item.productId}</td>

                                    <td><strong>${item.fullName}</strong></td>

                                    <td>
                                        <div class="text-warning">
                                            <c:forEach begin="1" end="${item.rating}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${item.rating + 1}" end="5">
                                                <i class="far fa-star"></i>
                                            </c:forEach>
                                        </div>
                                    </td>

                                    <td style="max-width: 250px;" class="text-truncate" title="${item.comment}">
                                            ${item.comment}
                                    </td>

                                    <td>
                                        <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>

                                    <td>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
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
