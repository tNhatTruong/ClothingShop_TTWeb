const filterForm = document.querySelector('.filter-form');
const searchInput = document.getElementById('searchInput');
const parentCategoryFilter = document.getElementById('parentCategoryFilter');
const subCategoryFilter = document.getElementById('subCategoryFilter');

// Tự động lọc khi thay đổi
searchInput.addEventListener('change', function() {
    filterForm.submit();
});

parentCategoryFilter.addEventListener('change', function() {
    const selectedParent = this.value;
    const subOptions = subCategoryFilter.querySelectorAll('option');

    subOptions.forEach(option => {
        if (option.value === '') {
            option.style.display = '';
        } else {
            const dataParent = option.getAttribute('data-parent');
            if (selectedParent && dataParent === selectedParent) {
                option.style.display = '';
            } else if (!selectedParent) {
                option.style.display = '';
            } else {
                option.style.display = 'none';
            }
        }
    });

    // Reset subcategory selection
    subCategoryFilter.value = '';

    // Tự động submit form
    filterForm.submit();
});

subCategoryFilter.addEventListener('change', function() {
    filterForm.submit();
});

function openCategoryModal(button = null) {
    const modalLabel = document.getElementById('categoryModalLabel');
    const formAction = document.getElementById('formAction');
    const idInput = document.getElementById('subCategoryId');
    const parentIdInput = document.getElementById('parentId');
    const nameInput = document.getElementById('subCategoryName');
    const descInput = document.getElementById('categoryDesc');
    const imgInput = document.getElementById('categoryImage');
    const imgPreviewCont = document.getElementById('imagePreviewContainer');
    const imgPreview = document.getElementById('imagePreview');
    const btnSubmitSpan = document.querySelector('#btnSubmitCategory span');

    // Reset file input mỗi lần mở modal
    imgInput.value = '';

    if (!button) {
        // ==== CHẾ ĐỘ THÊM MỚI ====
        modalLabel.innerText = "Thêm Danh Mục Mới";
        formAction.value = "add";
        idInput.value = "";
        parentIdInput.value = "";
        nameInput.value = "";
        descInput.value = "";

        imgPreviewCont.style.display = "none";
        imgPreview.src = "";
        btnSubmitSpan.innerText = "Thêm Mới";

        // File ảnh sẽ là bắt buộc khi thêm mới
        imgInput.required = true;

    } else {
        // ==== CHẾ ĐỘ CẬP NHẬT ====
        modalLabel.innerText = "Cập Nhật Danh Mục";
        formAction.value = "update";

        // Rút trích data từ các thuộc tính data-* của nút Sửa
        const id = button.getAttribute("data-id");
        const parentId = button.getAttribute("data-parent-id");
        const name = button.getAttribute("data-name");
        const desc = button.getAttribute("data-desc");
        const imgUrl = button.getAttribute("data-img");

        // Đổ dữ liệu vào form
        idInput.value = id;
        parentIdInput.value = parentId;
        nameInput.value = name;
        descInput.value = desc;

        // Xử lý hiển thị ảnh cũ
        if (imgUrl && imgUrl.trim() !== '') {
            imgPreview.src = imgUrl;
            imgPreviewCont.style.display = "block";
        } else {
            imgPreviewCont.style.display = "none";
        }

        btnSubmitSpan.innerText = "Cập Nhật";

        // File ảnh KHÔNG bắt buộc khi cập nhật (giữ nguyên ảnh cũ nếu không chọn)
        imgInput.required = false;
    }

    // Kích hoạt hiển thị Bootstrap Modal
    const modalElement = document.getElementById('categoryModal');
    const myModal = bootstrap.Modal.getOrCreateInstance(modalElement);
    myModal.show();
}