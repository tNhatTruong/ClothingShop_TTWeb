//xử lý không reload trang khi thêm giỏ hàng dùng Ajax
function addToCart(variantId) {
    let ctx = "";
    if (typeof contextPath !== "undefined") {
        ctx = contextPath;
    } else if (typeof window.contextPath !== "undefined") {
        ctx = window.contextPath;
    } else {
        const pathName = window.location.pathname;
        const parts = pathName.split("/").filter(Boolean);
        const knownPages = ["product", "product_detail", "cart", "checkout", "login", "register", "home", "index"];
        if (parts.length > 0) {
            if (knownPages.includes(parts[0])) {
                ctx = "";
            } else {
                ctx = `/${parts[0]}`;
            }
        } else {
            ctx = "";
        }
    }

    const quantityInput = document.getElementById("quantity");
    const quantity = quantityInput ? parseInt(quantityInput.value) || 1 : 1;

    fetch(`${ctx}/addcart`, {
        method: "POST",
        credentials: "same-origin",
        headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
        body: new URLSearchParams({
            variantId: String(variantId),
            quantity: String(quantity)
        })
    })
        .then(r => r.json())
        .then(data => {
            if (data.status !== "success") {
                alert(data.msg || "Không thể thêm vào giỏ hàng");
                return;
            }
            const totalItems = data.cartSize;

            document.querySelectorAll(".cart-badge").forEach(el => {
                el.textContent = totalItems;
                el.style.display = totalItems > 0 ? "flex" : "none";
            });

            showToast("Đã thêm vào giỏ hàng!");
        })
        .catch(() => {
            alert("Có lỗi xảy ra. Vui lòng thử lại!");
        });
}
//Hiển thị hộp thông báo thêm giỏ hàng ra 1 giây
function showToast(msg) {
    const toast = document.createElement("div");
    toast.className = "alert alert-success position-fixed top-0 end-0 m-4";
    toast.style.zIndex = "9999";
    toast.innerHTML = `<i class="fa-solid fa-circle-check"></i> ${msg}`;
    document.body.appendChild(toast);

    setTimeout(() => toast.remove(), 1000);
}