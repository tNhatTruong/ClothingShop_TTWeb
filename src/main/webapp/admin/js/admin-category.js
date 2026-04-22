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