// thực hiện thao tác lọc danh mục và phân loại

    document.querySelectorAll(".categoryFilter").forEach((select) => {
        select.addEventListener("change", () => {
            const parent = document.querySelector('select[name="parent"]').value;
            const sub = document.querySelector('select[name="sub"]').value;
            const size = document.querySelector('select[name="size"]').value;
            const color = document.querySelector('select[name="color"]').value;

            let url = "admin-products?";
            let params = [];

            if (parent) params.push("parent=" + encodeURIComponent(parent));
            if (sub) params.push("sub=" + encodeURIComponent(sub));
            if (size) params.push("size=" + encodeURIComponent(size));
            if (color) params.push("color=" + encodeURIComponent(color));

            url += params.join("&");

            window.location.href = url;
        });
    });