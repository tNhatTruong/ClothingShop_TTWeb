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
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>
<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="customer" scope="request"/>
<c:set var="isRoot" value="${sessionScope.auth != null && 'Admin'.equalsIgnoreCase(sessionScope.auth.role) && 'Admin@styleera.com'.equalsIgnoreCase(sessionScope.auth.email)}" />
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
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="adminProfile">
                <div class="row">
                    <!-- Left Column - Form -->
                    <div class="col-lg-8">
                        <form id="customerForm" action="${root}/AdminEditUser" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="${userToEdit.id}" />
                            
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-light border-bottom">
                                    <h6 class="mb-0">Thông Tin Cá Nhân</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <label class="form-label fw-bold">Họ Tên</label>
                                            <input type="text" class="form-control" name="user_name" placeholder="Nhập họ tên" value="${userToEdit.user_name}" required/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Số Điện Thoại</label>
                                            <input type="tel" class="form-control" name="phone" placeholder="Nhập số điện thoại" value="${userToEdit.phone}" required/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Trạng Thái</label>
                                            <select class="form-select" name="status" required>
                                                <option value="Hoạt Động" ${userToEdit.status eq 'Hoạt Động' ? 'selected' : ''}>Hoạt Động</option>
                                                <option value="Không Hoạt Động" ${userToEdit.status eq 'Không Hoạt Động' ? 'selected' : ''}>Không Hoạt Động</option>
                                                <option value="BANNED" ${userToEdit.status eq 'BANNED' ? 'selected' : ''}>Bị Khóa (BANNED)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Email</label>
                                            <input type="email" class="form-control" name="email" placeholder="Nhập email" value="${userToEdit.email}" required/>
                                        </div>
                                         <div class="col-md-6 mb-3">
                                             <label class="form-label fw-bold">Vai Trò</label>
                                             <select class="form-select" name="role" required>
                                                 <c:choose>
                                                     <c:when test="${isRoot}">
                                                         <%-- Admin gốc toàn quyền --%>
                                                         <option value="User" ${userToEdit.role eq 'User' ? 'selected' : ''}>User</option>
                                                         <option value="Admin" ${userToEdit.role eq 'Admin' ? 'selected' : ''}>Admin</option>
                                                     </c:when>
                                                     <c:otherwise>
                                                         <%-- Admin thường chỉ được thăng cấp chứ không được hạ cấp --%>
                                                         <option value="User" ${userToEdit.role eq 'User' ? 'selected' : ''} ${userToEdit.role eq 'Admin' ? 'disabled' : ''}>User</option>
                                                         <option value="Admin" ${userToEdit.role eq 'Admin' ? 'selected' : ''}>Admin</option>
                                                     </c:otherwise>
                                                 </c:choose>
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
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-light border-bottom">
                                <h6 class="mb-0">Hành động</h6>
                            </div>
                            <div class="card-body d-flex flex-column gap-2">
                                <button type="submit" form="customerForm" class="btn btn-primary btn-lg w-100">
                                    <i class="fas fa-save"></i> Cập Nhật
                                </button>
                                <a href="${root}/admin-user" class="btn btn-secondary btn-lg w-100" style="background-color: #6c757d; color: white">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </div>
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
