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

    // Thực hiện tìm kiếm sản phẩm tức thì phía Client
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchInput");
        if (searchInput) {
            searchInput.addEventListener("input", function() {
                const searchText = this.value.toLowerCase().trim();
                const tableRows = document.querySelectorAll("#productsTable tbody tr");
                
                tableRows.forEach(row => {
                    // Bỏ qua dòng trống nếu không có sản phẩm
                    if (row.cells.length < 3) return;
                    
                    const idText = row.cells[0].textContent.toLowerCase();
                    const nameText = row.cells[2].textContent.toLowerCase();
                    
                    if (idText.includes(searchText) || nameText.includes(searchText)) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            });
        }
    });