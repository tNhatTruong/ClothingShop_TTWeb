// Hàm định dạng tiền tệ
function formatVND(amount) {
    const n = Number(String(amount ?? 0).replace(/[^\d-]/g, "")) || 0;
    return new Intl.NumberFormat("vi-VN", {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(amount) + " VNĐ";
}

// hàm xử lý cập nhật thông tin trong giỏ hàng dùng Ajax:
function updateCart(variantId, action, btn) {
    fetch(contextPath + "/update-cart", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "variantId=" + variantId + "&action=" + action
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === "success") {
                const row = btn.closest("tr");
                // cập nhật số lượng
                row.querySelector(".qty-input").value = data.quantity;
                // cập nhật giá dòng
                row.querySelector(".cart_price").innerText =
                    formatVND(data.itemTotal);
                // cập nhật badge giỏ hàng
                const cartBadge = document.querySelector(".cart-badge");
                if (cartBadge) {
                    cartBadge.innerText = data.totalQuantity;
                }
                // cập nhật tổng đơn hàng
                const totalQtyElement = document.getElementById("total-quantity");
                if (totalQtyElement) {
                    totalQtyElement.innerText = data.totalQuantity;
                }
                // cập nhật tổng giá tiền
                const totalPriceElement = document.getElementById("total-price");
                if (totalPriceElement) {
                    totalPriceElement.innerText = formatVND(data.cartTotal);
                }
            }
        })
        .catch(err => console.error(err));
}