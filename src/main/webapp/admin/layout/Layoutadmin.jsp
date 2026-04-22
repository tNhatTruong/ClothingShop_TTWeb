<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty root}">
    <c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>
</c:if>

<div class="admin-container">
    <!-- ===== SIDEBAR ===== -->
    <aside class="admin-sidebar">
        <div class="sidebar-header">
            <div class="brand-logo">
                <i class="fas fa-tshirt" style="font-size: 28px"></i>
            </div>
            <h2 class="brand-name">StyleEra Admin</h2>
        </div>

        <nav class="sidebar-menu">
            <div class="menu-label">MENU</div>
            <ul class="menu-list">
                <li class="menu-item">
                    <a href="${root}/AdminDashboard"
                       class="menu-link ${currentPage == 'dashboard' ? 'active' : ''}">
                        <i class="fas fa-chart-line"></i>
                        <span>Bảng Điều Khiển</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin-products"
                       class="menu-link ${currentPage == 'products' ? 'active' : ''}">
                        <i class="fas fa-box"></i>
                        <span>Quản lý Sản Phẩm</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin-category"
                       class="menu-link ${currentPage == 'category' ? 'active' : ''}">
                        <i class="fa-solid fa-list"></i>
                        <span>Quản lý Danh Mục</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin/admin-orders.jsp"
                       class="menu-link ${currentPage == 'orders' ? 'active' : ''}">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Quản lý Đơn Hàng</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin/admin-profile.jsp"
                       class="menu-link ${currentPage == 'profile' ? 'active' : ''}">
                        <i class="fa-solid fa-user"></i>
                        <span>Quản Trị Viên</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin-user"
                       class="menu-link ${currentPage == 'customer' ? 'active' : ''}">
                        <i class="fas fa-users"></i>
                        <span>Quản lý Người Dùng</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin/admin-user-comment.jsp"
                       class="menu-link ${currentPage == 'comment' ? 'active' : ''}">
                        <i class="fa-solid fa-comment"></i>
                        <span>Quản lý Bình Luận</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="${root}/admin-contact"
                       class="menu-link ${currentPage == 'contact' ? 'active' : ''}">
                        <i class="fa-solid fa-address-card"></i>
                        <span>Quản lý Liên Hệ</span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- ===== FOOTER ===== -->
        <div class="sidebar-footer">
            <button class="btn-logout" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng Xuất</span>
            </button>
            <div class="container-fluid text-center">
                <p class="mb-0">&copy; 2025 StyleEra Admin. All rights reserved.</p>
            </div>
        </div>
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <div class="admin-main">
        <!-- ===== HEADER ===== -->
        <header class="admin-header">
            <div class="header-left">
                <button class="icon-btn d-lg-none" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="header-search">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder=" Tìm kiếm..."/>
                    </div>
                </div>
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
                        <div class="profile-name">Quản Trị Viên</div>
                        <div class="profile-role">Admin</div>
                    </div>
                    <button class="icon-btn profile-dropdown" type="button" data-bs-toggle="dropdown">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="${root}/admin/admin-profile.jsp">Hồ Sơ</a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${root}/admin/admin-profile.jsp">Cài Đặt</a>
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

<%--        <main class="admin-content">    --%>