/**
 * Hiển thị thông báo dạng Toast mượt mà
 * @param {string} msg - Nội dung thông báo
 * @param {string} type - 'success' (mặc định), 'error', hoặc 'warning'
 */
function showAppToast(msg, type = 'success') {
    const toastId = "appGlobalToast";
    const oldToast = document.getElementById(toastId);
    if (oldToast) oldToast.remove();

    const toast = document.createElement("div");
    toast.id = toastId;
    
    // Tùy chỉnh class và icon dựa trên type
    let alertClass = "alert-success";
    let iconClass = "fa-circle-check";
    
    if (type === 'error') {
        alertClass = "alert-danger";
        iconClass = "fa-circle-exclamation";
    } else if (type === 'warning') {
        alertClass = "alert-warning";
        iconClass = "fa-triangle-exclamation";
    }

    toast.className = `alert ${alertClass} position-fixed top-0 end-0 m-4 shadow-lg d-flex align-items-center`;
    toast.style.zIndex = "9999";
    toast.style.minWidth = "250px";
    toast.style.animation = "slideInRight 0.3s ease-out forwards";
    
    // Thêm animation CSS trực tiếp nếu chưa có
    if (!document.getElementById("toast-animation-styles")) {
        const style = document.createElement('style');
        style.id = "toast-animation-styles";
        style.innerHTML = `
            @keyframes slideInRight {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes fadeOutToast {
                from { opacity: 1; }
                to { opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    }

    toast.innerHTML = `<i class="fa-solid ${iconClass} me-2 fs-5"></i> <span>${msg}</span>`;
    document.body.appendChild(toast);

    // Tự động ẩn sau 3 giây
    setTimeout(() => {
        if (toast.parentNode) {
            toast.style.animation = "fadeOutToast 0.3s ease-out forwards";
            setTimeout(() => toast.remove(), 300); // Đợi animation mờ dần kết thúc mới xóa DOM
        }
    }, 3000);
}
