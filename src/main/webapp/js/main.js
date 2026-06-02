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

            if (e.target.closest('.submenu-container')) {
                return;
            }

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

// ==========================================
// BACK TO TOP BUTTON LOGIC (ISSUE #8)
// ==========================================
document.addEventListener('DOMContentLoaded', function () {
    const backToTopBtn = document.getElementById("backToTopBtn");

    if (backToTopBtn) {
        // 1. Khi cuộn xuống 300px thì hiện nút
        window.addEventListener("scroll", function() {
            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                backToTopBtn.style.display = "block";
            } else {
                backToTopBtn.style.display = "none";
            }
        });

        // 2. Khi click vào nút thì cuộn lên đầu mượt mà
        backToTopBtn.addEventListener("click", function() {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        });
    }
});
function toggleMobileSearch() {
    const searchBar = document.getElementById('mobileSearchBar');
    // Bật/tắt class 'active'
    searchBar.classList.toggle('active');

    // Tùy chọn: Tự động focus vào ô input khi mở ra
    if (searchBar.classList.contains('active')) {
        searchBar.querySelector('input').focus();
    }
}

// Đóng search nếu người dùng mở menu mobile (tránh chồng chéo)
function toggleMobileMenu() {
    const nav = document.getElementById('mainNavigation');
    const searchBar = document.getElementById('mobileSearchBar');

    nav.classList.toggle('active');
    if (nav.classList.contains('active')) {
        searchBar.classList.remove('active');
    }
}

let qvVariantsData = []; // Lưu trữ biến thể sản phẩm đang xem
let qvSelectedColor = '';
let qvSelectedSize = '';

// Hàm mở Modal và lấy dữ liệu biến thể từ Server bằng AJAX
function openQuickView(productId, name, price, imgUrl) {
    // Set thông tin cơ bản lên modal trước
    document.getElementById('qv-product-name').innerText = name;
    document.getElementById('qv-product-price').innerText = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(price);
    document.getElementById('qv-product-img').src = imgUrl;

    // Reset form
    qvSelectedColor = '';
    qvSelectedSize = '';
    document.getElementById('qv-quantity').value = 1;
    document.getElementById('qv-btn-add-to-cart').disabled = true;
    document.getElementById('qv-color-container').innerHTML = '<span class="text-muted small">Đang tải...</span>';
    document.getElementById('qv-size-container').innerHTML = '<span class="text-muted small">Vui lòng chọn màu trước...</span>';

    // Hiển thị modal lên màn hình
    const qvModal = new bootstrap.Modal(document.getElementById('quickViewModal'));
    qvModal.show();

    // Gọi AJAX lấy danh sách biến thể của sản phẩm
    // Hãy chắc chắn rằng bạn có 1 Servlet map đường dẫn này trả về JSON biến thể
    fetch(`${contextPath}/api/product-variants?productId=${productId}`)
        .then(response => response.json())
        .then(data => {
            qvVariantsData = data; // Dữ liệu mảng các biến thể [{variantId, color, size, stock}, ...]
            renderQuickViewColors();
        })
        .catch(err => {
            console.error("Lỗi tải biến thể:", err);
            document.getElementById('qv-color-container').innerHTML = '<span class="text-danger small">Không thể tải phân loại!</span>';
        });
}

// Hàm render danh sách MÀU SẮC độc nhất
function renderQuickViewColors() {
    const colorContainer = document.getElementById('qv-color-container');
    colorContainer.innerHTML = '';

    // Lọc ra danh sách các màu không trùng nhau
    const uniqueColors = [...new Set(qvVariantsData.map(v => v.color))];

    uniqueColors.forEach(color => {
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'btn btn-outline-secondary btn-sm qv-color-btn';
        btn.innerText = color;
        btn.onclick = function() {
            selectQuickViewColor(this, color);
        };
        colorContainer.appendChild(btn);
    });
}

// Xử lý khi click chọn MÀU
function selectQuickViewColor(element, color) {
    qvSelectedColor = color;
    qvSelectedSize = ''; // Reset size khi chọn lại màu khác
    document.getElementById('qv-btn-add-to-cart').disabled = true;

    // Đổi Active class cho nút màu
    document.querySelectorAll('.qv-color-btn').forEach(b => b.classList.remove('active'));
    element.classList.add('active');

    // Lọc ra các size có sẵn (stock > 0) thuộc về màu đã chọn
    const availableSizes = qvVariantsData
        .filter(v => v.color === color && v.stock > 0)
        .map(v => v.size);

    // Lấy toàn bộ danh sách size tổng quát của sản phẩm để hiển thị mờ/rõ
    const allSizes = [...new Set(qvVariantsData.map(v => v.size))];
    const sizeContainer = document.getElementById('qv-size-container');
    sizeContainer.innerHTML = '';

    allSizes.forEach(size => {
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.innerText = size;

        if (availableSizes.includes(size)) {
            btn.className = 'btn btn-outline-secondary btn-sm qv-size-btn';
            btn.onclick = function() {
                selectQuickViewSize(this, size);
            };
        } else {
            // Hết hàng thì làm mờ đi
            btn.className = 'btn btn-outline-secondary btn-sm disabled text-decoration-line-through';
            btn.style.opacity = '0.4';
        }
        sizeContainer.appendChild(btn);
    });
}

// Xử lý khi click chọn SIZE
function selectQuickViewSize(element, size) {
    qvSelectedSize = size;

    // Đổi Active class cho nút size
    document.querySelectorAll('.qv-size-btn').forEach(b => b.classList.remove('active'));
    element.classList.add('active');

    // Tìm Variant tương ứng để lấy ID và kích hoạt nút thêm vào giỏ hàng
    const matched = qvVariantsData.find(v => v.color === qvSelectedColor && v.size === qvSelectedSize);
    const btnAdd = document.getElementById('qv-btn-add-to-cart');

    if (matched) {
        btnAdd.disabled = false;
        // Gán sự kiện click thực hiện thêm vào giỏ hàng thật
        btnAdd.onclick = function() {
            const quantity = document.getElementById('qv-quantity').value;
            // Gọi hàm addToCart sẵn có của bạn (truyền thêm tham số số lượng nếu hàm của bạn có hỗ trợ)
            addToCart(matched.variantId, quantity);

            // Đóng modal sau khi thêm thành công
            bootstrap.Modal.getInstance(document.getElementById('quickViewModal')).hide();
        };
    }
}

// Thiết lập tăng giảm số lượng trong Modal khi DOM sẵn sàng
document.addEventListener("DOMContentLoaded", () => {
    const qtyInput = document.getElementById('qv-quantity');
    document.getElementById('qv-btn-increase').onclick = () => qtyInput.value = parseInt(qtyInput.value) + 1;
    document.getElementById('qv-btn-decrease').onclick = () => {
        let v = parseInt(qtyInput.value);
        if (v > 1) qtyInput.value = v - 1;
    };
});