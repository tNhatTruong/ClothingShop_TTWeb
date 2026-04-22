// ===== COMMON FUNCTIONS FOR ADMIN PAGES =====

// Update current date
function updateCurrentDate() {
    const dateElement = document.getElementById('current-date');
    if (dateElement) {
        const today = new Date();
        const options = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
        const formattedDate = today.toLocaleDateString('vi-VN', options);
        dateElement.textContent = formattedDate;
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function () {
    updateCurrentDate();
    initializeTooltips();
});

// Initialize Bootstrap tooltips
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Show success notification
function showSuccess(message) {
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-success alert-dismissible fade show fixed-top';
    alertDiv.style.zIndex = '5000';
    alertDiv.style.margin = '20px';
    alertDiv.innerHTML = `
        <strong>Thành công!</strong> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    document.body.appendChild(alertDiv);

    setTimeout(() => {
        alertDiv.remove();
    }, 5000);
}

// Show error notification
function showError(message) {
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-danger alert-dismissible fade show fixed-top';
    alertDiv.style.zIndex = '5000';
    alertDiv.style.margin = '20px';
    alertDiv.innerHTML = `
        <strong>Lỗi!</strong> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    document.body.appendChild(alertDiv);

    setTimeout(() => {
        alertDiv.remove();
    }, 5000);
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

// Format date
function formatDate(date) {
    const options = {year: 'numeric', month: '2-digit', day: '2-digit'};
    return new Date(date).toLocaleDateString('vi-VN', options);
}

// Logout function
function logout() {
    if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
        window.location.href = 'admin-login.jsp';
    }
}

// Set active navbar link
function setActiveNavLink() {
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');

    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
}

// Initialize navbar
document.addEventListener('DOMContentLoaded', function () {
    setActiveNavLink();
});

// Confirm deletion
function confirmDelete(itemName = 'item') {
    return confirm(`Bạn có chắc chắn muốn xóa ${itemName} này?`);
}

// Validate email
function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Validate phone
function isValidPhone(phone) {
    const re = /^(\+84|0)[0-9]{9,10}$/;
    return re.test(phone);
}

// Export data as CSV
function exportToCSV(tableSelector, fileName) {
    const table = document.querySelector(tableSelector);
    let csv = [];

    // Get headers
    const headers = [];
    table.querySelectorAll('thead th').forEach(th => {
        headers.push(th.textContent.trim());
    });
    csv.push(headers.join(','));

    // Get rows
    table.querySelectorAll('tbody tr').forEach(tr => {
        const row = [];
        tr.querySelectorAll('td').forEach((td, index) => {
            if (index < headers.length - 1) { // Skip last column (actions)
                row.push('"' + td.textContent.trim() + '"');
            }
        });
        csv.push(row.join(','));
    });

    // Create download link
    const csvContent = 'data:text/csv;charset=utf-8,' + csv.join('\n');
    const link = document.createElement('a');
    link.setAttribute('href', encodeURI(csvContent));
    link.setAttribute('download', fileName);
    link.click();
}

// Print page
function printPage() {
    window.print();
}

// Copy to clipboard
function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
        showSuccess('Đã sao chép vào clipboard!');
    });
}

// Local storage helpers
const Storage = {
    set: (key, value) => localStorage.setItem(key, JSON.stringify(value)),
    get: (key) => {
        const item = localStorage.getItem(key);
        return item ? JSON.parse(item) : null;
    },
    remove: (key) => localStorage.removeItem(key),
    clear: () => localStorage.clear()
};

// API helpers
const API = {
    baseUrl: 'https://api.example.com',

    get: async (endpoint) => {
        try {
            const response = await fetch(API.baseUrl + endpoint);
            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            showError('Lỗi khi tải dữ liệu!');
        }
    },

    post: async (endpoint, data) => {
        try {
            const response = await fetch(API.baseUrl + endpoint, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });
            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            showError('Lỗi khi lưu dữ liệu!');
        }
    }
};
