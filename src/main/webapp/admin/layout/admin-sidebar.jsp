<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                <a href="${root}/admin-orders"
                   class="menu-link ${currentPage == 'orders' ? 'active' : ''}">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Quản lý Đơn Hàng</span>
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
                <a href="${root}/admin-reviews"
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
    <div class="sidebar-footer">
        <button class="btn-logout" onclick="logout('${root}')">
            <i class="fas fa-sign-out-alt"></i>
            <span>Đăng Xuất</span>
        </button>
        <div class="container-fluid text-center">
            <p class="mb-0">&copy; 2025 StyleEra Admin. All rights reserved.</p>
        </div>
    </div>
</aside>
