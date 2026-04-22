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
                if (badge) badge.innerText = data.totalQuantity;
                // cập nhật tổng đơn hàng
                const totalQtyElement = document.getElementById("total-quantity");
                if (totalQtyElement) {
                    totalQtyElement.innerText = data.totalQuantity;
                }
                // cập nhật tổng giá tiền
                const totalPriceElement = document.getElementById("total-price");
                if (totalPriceElement && data.cartTotal !== undefined) {
                    totalPriceElement.innerText = formatVND(data.cartTotal);
                }
                // Kiểm tra nếu giỏ hàng trống
                if (data.totalQuantity === 0) {
                    const tbody = document.querySelector("table tbody");
                    if (tbody) {
                        tbody.innerHTML = `
                            <tr>
                                <td colspan="7" class="text-center py-4">
                                    <i class="fa-solid fa-cart-shopping fa-2x mb-2"></i>
                                    <p class="mt-2 mb-0 fw-bold">Giỏ hàng của bạn đang trống</p>
                                </td>
                            </tr>
                        `;
                    }
                }
            } else {
                alert(data.msg);
            }
        })
        .catch(err => console.error(err));
}