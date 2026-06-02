function addToCart(variantId, optionalQuantity = null) {
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

    let quantity = 1;
    if (optionalQuantity !== null && optionalQuantity !== undefined) {
        quantity = parseInt(optionalQuantity) || 1;
    } else {
        const quantityInput = document.getElementById("quantity");
        quantity = quantityInput ? parseInt(quantityInput.value) || 1 : 1;
    }

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

            const totalItems = data.totalQuantity;

            if (typeof window.setCartBadgeCount === "function") {
                window.setCartBadgeCount(totalItems);
            } else {
                document.querySelectorAll(".cart-badge").forEach(el => {
                    el.textContent = totalItems;
                    el.style.display = totalItems > 0 ? "flex" : "none";
                });
            }

            showToast("Đã thêm vào giỏ hàng thành công!");
        })
        .catch((err) => {
            console.error("Lỗi add-cart:", err);
            alert("Có lỗi xảy ra. Vui lòng thử lại!");
        });
}

function showToast(msg) {
    const oldToast = document.getElementById("cartQuickToast");
    if (oldToast) oldToast.remove();

    const toast = document.createElement("div");
    toast.id = "cartQuickToast";
    toast.className = "alert alert-success position-fixed top-0 end-0 m-4 shadow-lg";
    toast.style.zIndex = "9999";
    toast.innerHTML = `<i class="fa-solid fa-circle-check me-2"></i> ${msg}`;
    document.body.appendChild(toast);

    setTimeout(() => {
        if (toast.parentNode) {
            toast.remove();
        }
    }, 1200);
}