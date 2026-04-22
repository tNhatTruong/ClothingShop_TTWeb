document.querySelectorAll('.btn-view-details').forEach(btn => {
    btn.addEventListener('click', function() {
        const currentRow = this.closest('tr');
        const detailsRow = currentRow.nextElementSibling;
        if (detailsRow.style.display === 'none') {
            detailsRow.style.display = 'table-row';
            this.textContent = 'Ẩn chi tiết';
        } else {
            detailsRow.style.display = 'none';
            this.textContent = 'Xem chi tiết';
        }
    });
});
