<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản lý liên hệ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>
<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="contact" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

<main class="admin-content">
<div class="page-header mb-5">
    <div>
        <h1 class="page-title">Quản lý Liên Hệ</h1>
    </div>
</div>
<div class="card shadow-sm mb-4">
    <div class="card-body">
        <div class="row g-3 align-items-end">
            <div class="col-md-6">
                <label class="form-label">Tìm Kiếm</label>
                <input type="text" class="form-control" id="searchInput" placeholder="Tên tài khoản"/>
            </div>
        </div>
    </div>
</div>
<div>
    <div class="tab-pane">
        <div class="card shadow-sm">
            <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                <h6 class="mb-0">Danh Sách Liên hệ</h6>
                <span class="text-muted small">Tổng cộng: <strong>${contactList.size()}</strong></span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                        <tr class="text-center align-middle">
                            <th>ID</th>
                            <th>Tên người Gửi</th>
                            <th>Email gửi</th>
                            <th>Nội dung tin nhắn</th>
                            <th>Ngày gửi</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty contactList}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">
                                        <i class="fas fa-inbox fa-2x"></i><br/>
                                        Chưa có liên hệ nào
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${contactList}" var="c">
                                    <tr class="text-center align-middle">
                                        <td>#${c.id}</td>
                                        <td>${c.send_name}</td>
                                        <td>${c.send_email}</td>
                                        <td> <strong>${c.content}</strong> </td>
                                        <td>${c.send_at}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
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
