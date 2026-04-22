// Toggle mobile menu
function toggleMobileMenu() {
    const nav = document.getElementById('mainNavigation');
    nav.classList.toggle('active');

    // Prevent body scroll when menu is open
    if (nav.classList.contains('active')) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
}

// Close mobile menu when clicking outside
document.addEventListener('click', function (event) {
    const nav = document.getElementById('mainNavigation');
    const menuToggle = document.querySelector('.mobile-menu-toggle');

    if (nav && nav.classList.contains('active') &&
        !nav.contains(event.target) &&
        !menuToggle.contains(event.target)) {
        toggleMobileMenu();
    }
});

// Mobile submenu toggle
document.querySelectorAll('.nav-item').forEach(item => {
    item.addEventListener('click', function (e) {
        if (window.innerWidth <= 991) {
            const submenu = this.querySelector('.submenu-container');
            if (submenu) {
                e.preventDefault();
                this.classList.toggle('active');
            }
        }
    });
});

// Chức năng giỏ hàng
window.setCartBadgeCount = function (count) {
    const qty = Number.parseInt(String(count ?? "0"), 10) || 0;

    document.querySelectorAll('.cart-badge').forEach((badge) => {
        badge.textContent = String(qty);
        badge.style.display = qty > 0 ? 'flex' : 'none';
    });
};

document.addEventListener("DOMContentLoaded", function () {
    const cartBadge = document.querySelector('.cart-badge');
    if (cartBadge) {
        const count = parseInt(cartBadge.textContent.trim(), 10);
        window.setCartBadgeCount(count);
    }
});

// Header scroll effect
const header = document.querySelector('.site-header');
if (header) {
    window.addEventListener('scroll', () => {
        if (window.pageYOffset > 0) {
            header.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
        } else {
            header.style.boxShadow = '0 2px 5px rgba(0, 0, 0, 0.05)';
        }
    });
}

// ==========================================
// USER ACCOUNT DROPDOWN LOGIC (NEW)
// ==========================================
document.addEventListener('DOMContentLoaded', function () {
    // 1. Lấy phần tử kích hoạt (Nút Hello/Icon User đã đăng nhập)
    const userTrigger = document.querySelector('.account-link.logged-in');

    // 2. Lấy menu dropdown
    const dropdownMenu = document.querySelector('.account-dropdown-menu');

    // Chỉ chạy logic nếu người dùng ĐÃ đăng nhập (tức là tồn tại userTrigger)
    if (userTrigger && dropdownMenu) {

        // Sự kiện Click vào Icon/Tên User
        userTrigger.addEventListener('click', function (e) {
            e.preventDefault(); // Ngăn chặn chuyển trang nếu thẻ a có href
            e.stopPropagation(); // Ngăn sự kiện lan ra ngoài (để không bị document click đóng ngay lập tức)

            // Toggle class 'show' để ẩn/hiện menu
            dropdownMenu.classList.toggle('show');
        });

        // Sự kiện Click ra ngoài vùng menu thì đóng menu lại
        document.addEventListener('click', function (e) {
            // Nếu click KHÔNG nằm trong nút user VÀ KHÔNG nằm trong menu dropdown
            if (!userTrigger.contains(e.target) && !dropdownMenu.contains(e.target)) {
                dropdownMenu.classList.remove('show');
            }
        });
    }
});