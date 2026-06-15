<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản lý tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css?v=1.2"/>

</head>

<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="customer" scope="request"/>
<c:set var="isRoot" value="${sessionScope.auth != null && 'Admin'.equalsIgnoreCase(sessionScope.auth.role) && 'qutoan23@gmail.com'.equalsIgnoreCase(sessionScope.auth.email)}" />
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

        <!-- ===== CONTENT ===== -->
        <main class="admin-content">
            <!-- Alert Notifications -->
            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <!-- Page Header -->
            <div class="page-header mb-5">
                <div>
                    <h1 class="page-title">Quản lý Tài Khoản</h1>
                </div>
<%--                <div class="page-actions">--%>
<%--                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">--%>
<%--                        <i class="fas fa-plus"></i> Thêm Tài Khoản--%>
<%--                    </button>--%>
<%--                </div>--%>
            </div>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Tìm Kiếm</label>
                            <input type="text" class="form-control" id="searchInput" placeholder="Tìm theo Tên, Email hoặc Số điện thoại..."/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Vai Trò</label>
                            <select class="form-select" id="categoryFilter">
                                <option value="">Tất Cả Vai Trò</option>
                                <option value="admin">Admin</option>
                                <option value="user">User</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class="tab-pane">
                    <div class="card shadow-sm">
                        <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 fw-bold">Danh Sách Khách Hàng</h6>
                            <span class="text-muted small">Tổng cộng: <strong>${users.size()}</strong> Người dùng</span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover table-sm mb-0" style="font-size: 0.88rem;">
                                    <thead class="table-light text-secondary">
                                    <tr class="text-center align-middle" style="font-size: 0.82rem; text-transform: uppercase; letter-spacing: 0.5px;">
                                        <th style="width: 60px;">ID</th>
                                        <th style="width: 140px;">Họ Tên</th>
                                        <th style="width: 110px;">Điện thoại</th>
                                        <th>Địa Chỉ</th>
                                        <th style="width: 180px;">Email</th>
                                        <th style="width: 120px;">Vai trò</th>
                                        <th style="width: 115px;">Trạng Thái</th>
                                        <th style="width: 125px;">Hành Động</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${empty users}">
                                            <tr>
                                                <td colspan="8" class="text-center text-muted py-4">
                                                    <i class="fas fa-inbox fa-2x"></i>
                                                    <p class="mb-0">Chưa có người dùng</p>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                             <c:forEach items="${users}" var="u">
                                                 <c:set var="uIsRoot" value="${u.role eq 'Admin' && 'qutoan23@gmail.com'.equalsIgnoreCase(u.email)}" />
                                                 <c:set var="uIsAdmin" value="${u.role eq 'Admin'}" />
                                                 <tr class="text-center align-middle">
                                                     <td>#${u.id}</td>
                                                     <td style="max-width: 140px; word-break: break-word;"> <strong>${u.user_name}</strong> </td>
                                                     <td style="font-size: 0.85rem;">${u.phone}</td>
                                                     <td style="max-width: 200px; font-size: 0.8rem; word-break: break-word; line-height: 1.25; text-align: left;">
                                                         <c:choose>
                                                             <c:when test="${not empty u.addresses}">
                                                                 ${u.addresses[0].street}, ${u.addresses[0].district}, ${u.addresses[0].province}
                                                             </c:when>
                                                             <c:otherwise>—</c:otherwise>
                                                         </c:choose>
                                                     </td>
                                                     <td style="max-width: 170px; font-size: 0.8rem; word-break: break-all;">${u.email}</td>
                                                     <td>
                                                         <c:choose>
                                                             <c:when test="${uIsRoot}">
                                                                 <span class="badge bg-danger fw-bold"><i class="fas fa-crown text-warning me-1"></i>Admin Gốc</span>
                                                             </c:when>
                                                             <c:when test="${uIsAdmin}">
                                                                 <span class="badge bg-warning fw-bold"><i class="fas fa-user-shield me-1"></i>Admin</span>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <span class="badge bg-info fw-bold">${u.role}</span>
                                                             </c:otherwise>
                                                         </c:choose>
                                                     </td>
                                                     <td>
                                                         <c:choose>
                                                             <c:when test="${u.status eq 'Hoạt Động'}">
                                                                 <span class="badge bg-success fw-bold status-badge" data-user-id="${u.id}">${u.status}</span>
                                                             </c:when>
                                                             <c:when test="${u.status eq 'BANNED'}">
                                                                 <span class="badge bg-dark fw-bold status-badge" data-user-id="${u.id}">Bị Khóa</span>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <span class="badge bg-danger fw-bold status-badge" data-user-id="${u.id}">${u.status}</span>
                                                             </c:otherwise>
                                                         </c:choose>
                                                     </td>
                                                     <td>
                                                         <!-- 1. Nút Chỉnh Sửa -->
                                                         <c:choose>
                                                             <c:when test="${uIsRoot}">
                                                                 <c:choose>
                                                                     <c:when test="${isRoot}">
                                                                         <a href="${root}/AdminEditUser?id=${u.id}" class="btn btn-sm btn-warning" title="Chỉnh sửa">
                                                                             <i class="fas fa-edit"></i>
                                                                         </a>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                         <button class="btn btn-sm btn-secondary" disabled title="Không có quyền chỉnh sửa Admin Gốc">
                                                                             <i class="fas fa-edit"></i>
                                                                         </button>
                                                                     </c:otherwise>
                                                                 </c:choose>
                                                             </c:when>
                                                             <c:when test="${uIsAdmin}">
                                                                 <c:choose>
                                                                     <c:when test="${isRoot}">
                                                                         <a href="${root}/AdminEditUser?id=${u.id}" class="btn btn-sm btn-warning" title="Chỉnh sửa">
                                                                             <i class="fas fa-edit"></i>
                                                                         </a>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                         <button class="btn btn-sm btn-secondary" disabled title="Chỉ Admin gốc mới có quyền sửa Admin khác">
                                                                             <i class="fas fa-edit"></i>
                                                                         </button>
                                                                     </c:otherwise>
                                                                 </c:choose>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <a href="${root}/AdminEditUser?id=${u.id}" class="btn btn-sm btn-warning" title="Chỉnh sửa">
                                                                     <i class="fas fa-edit"></i>
                                                                 </a>
                                                             </c:otherwise>
                                                         </c:choose>

                                                         <!-- 2. Nút Khóa / Mở Khóa (Ban/Unban) -->
                                                         <c:choose>
                                                             <c:when test="${uIsRoot}">
                                                                 <button class="btn btn-sm btn-secondary ms-1" disabled title="Không thể khóa Admin gốc">
                                                                     <i class="fas fa-user-shield"></i>
                                                                 </button>
                                                             </c:when>
                                                             <c:when test="${uIsAdmin}">
                                                                 <c:choose>
                                                                     <c:when test="${isRoot}">
                                                                         <c:choose>
                                                                             <c:when test="${u.status eq 'BANNED'}">
                                                                                 <button class="btn btn-sm btn-success ms-1 btn-toggle-ban" data-user-id="${u.id}" data-action="unban" title="Mở khóa tài khoản">
                                                                                     <i class="fas fa-unlock"></i>
                                                                                 </button>
                                                                             </c:when>
                                                                             <c:otherwise>
                                                                                 <button class="btn btn-sm btn-danger ms-1 btn-toggle-ban" data-user-id="${u.id}" data-action="ban" title="Khóa tài khoản">
                                                                                     <i class="fas fa-ban"></i>
                                                                                 </button>
                                                                             </c:otherwise>
                                                                         </c:choose>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                         <button class="btn btn-sm btn-secondary ms-1" disabled title="Chỉ Admin gốc mới có quyền khóa Admin khác">
                                                                             <i class="fas fa-user-shield"></i>
                                                                         </button>
                                                                     </c:otherwise>
                                                                 </c:choose>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <c:choose>
                                                                     <c:when test="${u.status eq 'BANNED'}">
                                                                         <button class="btn btn-sm btn-success ms-1 btn-toggle-ban" data-user-id="${u.id}" data-action="unban" title="Mở khóa tài khoản">
                                                                             <i class="fas fa-unlock"></i>
                                                                         </button>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                         <button class="btn btn-sm btn-danger ms-1 btn-toggle-ban" data-user-id="${u.id}" data-action="ban" title="Khóa tài khoản">
                                                                             <i class="fas fa-ban"></i>
                                                                         </button>
                                                                     </c:otherwise>
                                                                 </c:choose>
                                                             </c:otherwise>
                                                         </c:choose>

                                                         <!-- 3. Nút Xóa Cứng (Delete) -->
                                                         <c:choose>
                                                             <c:when test="${uIsRoot}">
                                                                 <button class="btn btn-sm btn-secondary ms-1" disabled title="Không thể xóa Admin gốc">
                                                                     <i class="fas fa-trash"></i>
                                                                 </button>
                                                             </c:when>
                                                             <c:when test="${uIsAdmin}">
                                                                 <c:choose>
                                                                     <c:when test="${isRoot}">
                                                                         <a href="javascript:void(0);" data-id="${u.id}" data-name="${u.user_name}" onclick="confirmDelete(this.getAttribute('data-id'), this.getAttribute('data-name'))" class="btn btn-sm btn-danger ms-1" title="Xóa vĩnh viễn tài khoản">
                                                                             <i class="fas fa-trash"></i>
                                                                         </a>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                         <button class="btn btn-sm btn-secondary ms-1" disabled title="Chỉ Admin gốc mới có quyền xóa Admin khác">
                                                                             <i class="fas fa-trash"></i>
                                                                         </button>
                                                                     </c:otherwise>
                                                                 </c:choose>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <a href="javascript:void(0);" data-id="${u.id}" data-name="${u.user_name}" onclick="confirmDelete(this.getAttribute('data-id'), this.getAttribute('data-name'))" class="btn btn-sm btn-danger ms-1" title="Xóa vĩnh viễn tài khoản">
                                                                     <i class="fas fa-trash"></i>
                                                                 </a>
                                                             </c:otherwise>
                                                         </c:choose>
                                                     </td>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const contextPath = '${root}';

    // Bộ lọc Tìm kiếm và Vai trò (Client-side instant filtering)
    const searchInput = document.getElementById("searchInput");
    const categoryFilter = document.getElementById("categoryFilter");
    
    function filterTable() {
        const searchText = searchInput.value.toLowerCase().trim();
        const filterRole = categoryFilter.value.toLowerCase().trim();
        const tableRows = document.querySelectorAll("tbody tr.align-middle"); // Đọc lại danh sách tr

        tableRows.forEach(row => {
            const cells = row.getElementsByTagName("td");
            if (cells.length < 6) return;

            const name = cells[1].textContent.toLowerCase();
            const phone = cells[2].textContent.toLowerCase();
            const email = cells[4].textContent.toLowerCase();
            
            // Vai trò: có thể là Admin Gốc, Admin, hoặc User
            const roleText = cells[5].textContent.toLowerCase();

            // Kiểm tra khớp từ khóa tìm kiếm (theo Tên, Email hoặc SĐT)
            const matchesSearch = name.includes(searchText) || email.includes(searchText) || phone.includes(searchText);

            // Kiểm tra khớp bộ lọc vai trò
            let matchesRole = true;
            if (filterRole === "admin") {
                matchesRole = roleText.includes("admin");
            } else if (filterRole === "user") {
                matchesRole = roleText.includes("user");
            }

            if (matchesSearch && matchesRole) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    if (searchInput) searchInput.addEventListener("input", filterTable);
    if (categoryFilter) categoryFilter.addEventListener("change", filterTable);

    // Thao tác Khóa / Mở khóa động bằng AJAX Fetch
    // Dùng Event Delegation để bắt các sự kiện click động (phòng trường hợp render động sau này)
    document.addEventListener("click", function(e) {
        const btn = e.target.closest(".btn-toggle-ban");
        if (!btn) return;

        e.preventDefault();
        const userId = btn.getAttribute("data-user-id");
        const action = btn.getAttribute("data-action");
        const actionText = action === "ban" ? "KHÓA" : "MỞ KHÓA";

        if (!confirm("Bạn có chắc chắn muốn " + actionText + " tài khoản này?")) {
            return;
        }

        // Gửi AJAX POST yêu cầu cập nhật trạng thái
        fetch(contextPath + "/admin/ban-user", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "user_id=" + encodeURIComponent(userId) + "&action=" + encodeURIComponent(action)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().then(err => { throw new Error(err.message || "Lỗi hệ thống"); });
            }
            return response.json();
        })
        .then(data => {
            if (data.status === "success") {
                showAppToast(data.message, "success");
                
                // 1. Cập nhật Badge Trạng Thái
                const statusBadge = document.querySelector(".status-badge[data-user-id='" + userId + "']");
                if (statusBadge) {
                    if (data.newStatus === "BANNED") {
                        statusBadge.className = "badge bg-dark fw-bold status-badge";
                        statusBadge.textContent = "Bị Khóa";
                    } else {
                        statusBadge.className = "badge bg-success fw-bold status-badge";
                        statusBadge.textContent = "Hoạt Động";
                    }
                }

                // 2. Cập nhật Nút Hành Động
                if (data.newStatus === "BANNED") {
                    btn.className = "btn btn-sm btn-success ms-1 btn-toggle-ban";
                    btn.setAttribute("data-action", "unban");
                    btn.setAttribute("title", "Mở khóa tài khoản");
                    btn.innerHTML = '<i class="fas fa-unlock"></i>';
                } else {
                    btn.className = "btn btn-sm btn-danger ms-1 btn-toggle-ban";
                    btn.setAttribute("data-action", "ban");
                    btn.setAttribute("title", "Khóa tài khoản");
                    btn.innerHTML = '<i class="fas fa-ban"></i>';
                }
            } else {
                showAppToast(data.message || "Có lỗi xảy ra, vui lòng thử lại!", "error");
            }
        })
        .catch(error => {
            showAppToast("Lỗi: " + error.message, "error");
        });
    });
});

function confirmDelete(userId, userName) {
    if (confirm("Bạn có chắc chắn muốn XÓA VĨNH VIỄN tài khoản '" + userName + "' ra khỏi hệ thống?\nLưu ý: Mọi dữ liệu liên quan đến tài khoản này (đơn hàng, giỏ hàng, liên hệ, địa chỉ) sẽ bị XÓA SẠCH VÀ KHÔNG THỂ KHÔI PHỤC!")) {
        window.location.href = "${root}/AdminDeleteUser?id=" + userId;
    }
}
</script>
</body>
</html>
