// ==== Mobile Menu ====
function toggleMobileMenu() {
    const menu = document.getElementById("mainNavigation");
    menu.classList.toggle("active");
}

// ==== Toggle Account Dropdown ====
function toggleAccountDropdown() {
    const dropdown = document.querySelector(".account-dropdown-menu");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
}

// ==== Handle Logout ====
function handleLogout() {
    localStorage.removeItem('loggedIn'); // Xóa trạng thái login
    localStorage.removeItem('userType');
    alert("Đăng xuất thành công!");
    window.location.href = "login.jsp"; // Chuyển về login
}

// ==== Initialize Account Link (chạy khi trang tải) ====
window.onload = function() {
    const accountLink = document.querySelector(".account-link");
    const loggedIn = localStorage.getItem('loggedIn');

    if (loggedIn === 'true') {
        // Đã login: Thay đổi thành button toggle dropdown
        accountLink.href = "#"; // Ngăn chuyển trang
        accountLink.addEventListener('click', function(event) {
            event.preventDefault();
            toggleAccountDropdown();
        });

        // Thêm event cho logout nếu có
        const logoutLink = document.querySelector(".account-dropdown-menu a[href='#logout']");
        if (logoutLink) {
            logoutLink.addEventListener('click', function(event) {
                event.preventDefault();
                handleLogout();
            });
        }
    } else {
        // Chưa login: Giữ nguyên href="login.jsp"
        // accountLink.href = "login.jsp";
    }
};