// Hàm định dạng tiền tệ
function formatVND(amount) {
    const n = Number(String(amount ?? 0).replace(/[^\d-]/g, "")) || 0;
    return new Intl.NumberFormat("vi-VN", {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(n) + " VNĐ";
}

// Xoá giỏ hàng ko reload lại trang:
function removeItem(variantId, btn) {
    fetch(contextPath + "/del-item", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({ variantId: String(variantId) }).toString()
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === "success") {
                const row = btn.closest("tr");
                if (row) row.remove();
                const badge = document.querySelector(".cart-badge");
                if (badge) badge.innerText = data.cartSize;
                // cập nhật tổng sản phẩm và tổng giá tiền
                if (window.calculateCartSummary) {
                    window.calculateCartSummary();
                } else {
                    const totalQtyElement = document.getElementById("total-quantity");
                    if (totalQtyElement) {
                        totalQtyElement.innerText = data.totalQuantity;
                    }
                    const totalPriceElement = document.getElementById("total-price");
                    if (totalPriceElement && data.cartTotal !== undefined) {
                        totalPriceElement.innerText = formatVND(data.cartTotal);
                    }
                }
                // Kiểm tra nếu giỏ hàng trống thì reload trang để hiển thị Empty State chuẩn và đồng bộ badge
                if (data.totalQuantity === 0) {
                    window.location.reload();
                }
            } else {
                showAppToast(data.msg, "error");
            }
        })
        .catch(err => console.error(err));
}