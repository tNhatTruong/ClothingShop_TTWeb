<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="admin-header">
    <div class="header-left">
        <button class="icon-btn d-lg-none" id="sidebarToggle">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <div class="header-right">
        <div class="header-icons">
            <button class="icon-btn" title="Notifications">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">0</span>
            </button>
        </div>

        <div class="admin-profile">
            <img src="${root}/admin/images/logoadm.png" alt="Admin" class="profile-img"/>
            <div class="profile-info">
                <div class="profile-name">
                    <c:choose>
                        <c:when test="${not empty sessionScope.auth}">
                            ${sessionScope.auth.user_name}
                        </c:when>
                        <c:otherwise>Quản Trị Viên</c:otherwise>
                    </c:choose>
                </div>
                <div class="profile-role">
                    <c:choose>
                        <c:when test="${sessionScope.auth != null && 'qutoan23@gmail.com'.equalsIgnoreCase(sessionScope.auth.email)}">
                            Admin Gốc
                        </c:when>
                        <c:when test="${not empty sessionScope.auth}">
                            Admin
                        </c:when>
                        <c:otherwise>Admin</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <button class="icon-btn profile-dropdown" type="button" data-bs-toggle="dropdown">
                <i class="fas fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li>
                    <a class="dropdown-item" href="${root}/">Trang chủ</a>
                </li>
                <li>
                    <a class="dropdown-item" href="${root}/admin-profile">Hồ Sơ</a>
                </li>
                <li>
                    <a class="dropdown-item" href="${root}/admin-profile?tab=settings">Cài Đặt</a>
                </li>
                <li>
                    <hr class="dropdown-divider"/>
                </li>
                <li>
                    <a class="dropdown-item" href="${root}/logout">Đăng Xuất</a>
                </li>
            </ul>
        </div>
    </div>
</header>
