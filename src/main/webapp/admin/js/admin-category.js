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

document.getElementById('btnDeletePreview').addEventListener('click', function() {
    document.getElementById('categoryImage').value = '';
    document.getElementById('imagePreview').src = '';
    document.getElementById('imagePreviewContainer').style.display = 'none';
    document.getElementById('isImageDeleted').value = 'true';
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
    const isDeletedInput = document.getElementById('isImageDeleted');
    const btnSubmitSpan = document.querySelector('#btnSubmitCategory span');

    // Reset trạng thái ban đầu mỗi khi mở modal
    imgInput.value = '';
    isDeletedInput.value = "false";

    if (!button) {
        modalLabel.innerText = "Thêm Danh Mục Mới";
        formAction.value = "add";
        idInput.value = "";
        parentIdInput.value = "";
        nameInput.value = "";
        descInput.value = "";
        imgPreviewCont.style.display = "none";
        imgPreview.src = "";
        btnSubmitSpan.innerText = "Thêm Mới";
        imgInput.required = true;
    } else {
        modalLabel.innerText = "Cập Nhật Danh Mục";
        formAction.value = "update";

        idInput.value = button.getAttribute("data-id");
        parentIdInput.value = button.getAttribute("data-parent-id");
        nameInput.value = button.getAttribute("data-name");
        descInput.value = button.getAttribute("data-desc");

        const imgUrl = button.getAttribute("data-img");
        if (imgUrl && imgUrl.trim() !== '') {
            imgPreview.src = imgUrl;
            imgPreviewCont.style.display = "block";
        } else {
            imgPreviewCont.style.display = "none";
        }

        btnSubmitSpan.innerText = "Cập Nhật";
        imgInput.required = false;
    }

    const modalElement = document.getElementById('categoryModal');
    const myModal = bootstrap.Modal.getOrCreateInstance(modalElement);
    myModal.show();
}