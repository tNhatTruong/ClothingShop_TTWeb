document.getElementById("sidebarToggle").addEventListener("click", function () {
  document.querySelector(".admin-sidebar").classList.toggle("active");
});

function viewOrder(root, orderId) {
  fetch(root + '/api/admin/order-detail?id=' + orderId)
    .then(response => response.json())
    .then(data => {
        if(data.error) {
            showAppToast(data.error, "danger");
            return;
        }
        
        const order = data.order;
        const items = data.items;

        // Cập nhật thông tin khách hàng và giao hàng
        document.getElementById('modalCustomerName').textContent = order.shippingName || order.userName || 'N/A';
        document.getElementById('modalCustomerEmail').textContent = order.email || 'N/A';
        document.getElementById('modalCustomerPhone').textContent = order.shippingPhone || 'N/A';
        document.getElementById('modalShippingAddress').textContent = order.shippingAddress || 'N/A';
        document.getElementById('modalOrderNote').textContent = order.note ? "Ghi chú: " + order.note : "";

        // Cập nhật danh sách sản phẩm
        const tbody = document.getElementById('modalItemsTbody');
        tbody.innerHTML = '';
        
        items.forEach(item => {
            const tr = document.createElement('tr');
            tr.className = "text-center";
            
            // Format tiền
            const formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.price);
            const formattedTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.total);
            const imagePath = item.thumbnail ? root + item.thumbnail : root + '/images/default.jpg'; // Dữ liệu DB đã có sẵn '/images/'

            tr.innerHTML = `
                <td><img src="` + imagePath + `" alt="Product" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"></td>
                <td class="text-start">
                    <div class="fw-bold">` + item.productName + `</div>
                    <small class="text-muted">Phân loại: ` + item.color + `, Size ` + item.size + `</small>
                </td>
                <td>` + item.quantity + `</td>
                <td>` + formattedPrice + `</td>
                <td class="fw-bold">` + formattedTotal + `</td>
            `;
            tbody.appendChild(tr);
        });

        // Cập nhật tổng tiền
        const formattedSubtotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(order.price);
        const formattedFee = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(order.feeDelivery);
        const formattedTotalOrder = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(order.totalPrice);

        document.getElementById('modalSubtotal').textContent = formattedSubtotal;
        document.getElementById('modalFeeDelivery').textContent = formattedFee;
        document.getElementById('modalTotalPrice').textContent = formattedTotalOrder;

        // Hiển thị modal
        const modal = new bootstrap.Modal(document.getElementById("orderDetailModal"));
        modal.show();
    })
    .catch(error => {
        console.error('Error fetching order details:', error);
        showAppToast('Lỗi khi tải chi tiết đơn hàng', "danger");
    });
}

function confirmOrder(orderId) {
  if (confirm("Xác nhận đơn hàng " + orderId + "?")) {
    showAppToast("Đơn hàng " + orderId + " đã được xác nhận!", "success");
    setTimeout(() => location.reload(), 1000);
  }
}

function trackOrder(orderId) {
  showAppToast("Theo dõi vận chuyển cho " + orderId, "success");
}

function printInvoice(orderId) {
  showAppToast("In hóa đơn cho " + orderId, "success");
  window.print();
}

function deleteOrder(orderId) {
  if (confirm("Bạn có chắc chắn muốn xóa " + orderId + "?")) {
    showAppToast("Đơn hàng " + orderId + " đã được xóa!", "success");
    setTimeout(() => location.reload(), 1000);
  }
}

// ==========================================
// TẠO ĐƠN HÀNG TRỰC TIẾP TỪ ADMIN
// ==========================================

document.addEventListener('DOMContentLoaded', function () {
    const provinceSelect = document.getElementById('co_province');
    const districtSelect = document.getElementById('co_district');
    const wardSelect = document.getElementById('co_ward');
    const searchInput = document.getElementById('createOrderSearchInput');
    const searchBtn = document.getElementById('btnSearchProduct');
    const searchResults = document.getElementById('searchProductResults');
    const cartBody = document.getElementById('createOrderCartBody');
    const form = document.getElementById('adminCreateOrderForm');

    let adminCart = []; // Mảng chứa các sản phẩm đã chọn { variantId, productName, color, size, price, quantity, maxQuantity, thumbnail }

    // --- 1. Xử lý Địa chỉ GHN và Tính phí Ship ---
    if (provinceSelect && districtSelect && wardSelect) {
        fetch(contextPath + '/api/address/province')
            .then(res => res.json())
            .then(data => {
                if (data.code === 200) {
                    data.data.forEach(p => {
                        let opt = document.createElement('option');
                        opt.value = p.ProvinceID;
                        opt.text = p.ProvinceName;
                        provinceSelect.appendChild(opt);
                    });
                }
            });

        provinceSelect.addEventListener('change', function () {
            let pid = this.value;
            document.getElementById('co_provinceName').value = this.options[this.selectedIndex].text;
            document.getElementById('co_districtName').value = '';
            document.getElementById('co_wardName').value = '';

            districtSelect.innerHTML = '<option value="">-- Chọn --</option>';
            wardSelect.innerHTML = '<option value="">-- Chọn --</option>';
            districtSelect.disabled = true;
            wardSelect.disabled = true;
            resetShippingFee();

            if (!pid) return;

            fetch(contextPath + '/api/address/district?province_id=' + pid)
                .then(res => res.json())
                .then(data => {
                    if (data.code === 200) {
                        districtSelect.disabled = false;
                        data.data.forEach(d => {
                            let opt = document.createElement('option');
                            opt.value = d.DistrictID;
                            opt.text = d.DistrictName;
                            districtSelect.appendChild(opt);
                        });
                    }
                });
        });

        districtSelect.addEventListener('change', function () {
            let did = this.value;
            document.getElementById('co_districtName').value = this.options[this.selectedIndex].text;
            document.getElementById('co_wardName').value = '';

            wardSelect.innerHTML = '<option value="">-- Chọn --</option>';
            wardSelect.disabled = true;
            resetShippingFee();

            if (!did) return;

            fetch(contextPath + '/api/address/ward?district_id=' + did)
                .then(res => res.json())
                .then(data => {
                    if (data.code === 200) {
                        wardSelect.disabled = false;
                        data.data.forEach(w => {
                            let opt = document.createElement('option');
                            opt.value = w.WardCode;
                            opt.text = w.WardName;
                            wardSelect.appendChild(opt);
                        });
                    }
                });
        });

        wardSelect.addEventListener('change', function () {
            document.getElementById('co_wardName').value = this.options[this.selectedIndex].text;
            let did = districtSelect.value;
            let wid = this.value;

            if (did && wid) {
                fetch(contextPath + '/api/calculate-shipping', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ 'district_id': did, 'ward_code': wid })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.status === 'success') {
                            updateTotals(data.fee);
                        } else {
                            showAppToast("Không thể tính phí vận chuyển", "danger");
                        }
                    });
            }
        });
    }

    // --- 2. Xử lý Tìm kiếm Sản phẩm ---
    if (searchInput) {
        let searchTimeout;
        
        function doSearch() {
            const kw = searchInput.value.trim();
            if (!kw) {
                searchResults.style.display = 'none';
                return;
            }
            fetch(contextPath + '/api/admin/search-product?keyword=' + encodeURIComponent(kw))
                .then(res => res.json())
                .then(data => {
                    searchResults.innerHTML = '';
                    if (data.status === 'success' && data.data.length > 0) {
                        data.data.forEach(v => {
                            const a = document.createElement('a');
                            a.href = "#";
                            a.className = "list-group-item list-group-item-action d-flex align-items-center";
                            const imgUrl = v.product.thumbnail ? contextPath + v.product.thumbnail : contextPath + '/images/default.jpg';
                            const priceFormatted = new Intl.NumberFormat('vi-VN').format(v.product.price) + 'đ';
                            
                            a.innerHTML = `
                                <img src="${imgUrl}" style="width:40px; height:40px; object-fit:cover; margin-right:10px;">
                                <div class="flex-grow-1">
                                    <div class="fw-bold" style="font-size:14px;">${v.product.product_name}</div>
                                    <div class="text-muted" style="font-size:12px;">Size: ${v.size} | Màu: ${v.color} | Tồn: ${v.quantity}</div>
                                </div>
                                <div class="text-danger fw-bold" style="font-size:14px;">${priceFormatted}</div>
                            `;
                            a.onclick = function(e) {
                                e.preventDefault();
                                addToCart(v);
                                searchResults.style.display = 'none';
                                searchInput.value = '';
                            };
                            searchResults.appendChild(a);
                        });
                        searchResults.style.display = 'block';
                    } else {
                        searchResults.innerHTML = '<div class="list-group-item text-muted">Không tìm thấy sản phẩm</div>';
                        searchResults.style.display = 'block';
                    }
                });
        }
        
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(doSearch, 300);
        });
        
        searchInput.addEventListener('focus', function() {
            if (searchInput.value.trim()) {
                doSearch();
            }
        });
        
        if (searchBtn) {
            searchBtn.addEventListener('click', doSearch);
        }
        
        // Ẩn kết quả khi click ra ngoài
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.style.display = 'none';
            }
        });
    }

    // --- 3. Xử lý Giỏ hàng nội bộ ---
    function addToCart(variant) {
        if (variant.quantity <= 0) {
            showAppToast("Sản phẩm này đã hết hàng!", "warning");
            return;
        }
        let existing = adminCart.find(item => item.variantId === variant.variantId);
        if (existing) {
            if (existing.quantity < existing.maxQuantity) {
                existing.quantity++;
            } else {
                showAppToast("Không thể vượt quá số lượng tồn kho!", "warning");
            }
        } else {
            adminCart.push({
                variantId: variant.variantId,
                productName: variant.product.product_name,
                size: variant.size,
                color: variant.color,
                price: variant.product.price,
                quantity: 1,
                maxQuantity: variant.quantity,
                thumbnail: variant.product.thumbnail
            });
        }
        renderCart();
    }

    window.changeCartQty = function(variantId, delta) {
        let item = adminCart.find(i => i.variantId === variantId);
        if (item) {
            let newQ = item.quantity + delta;
            if (newQ > 0 && newQ <= item.maxQuantity) {
                item.quantity = newQ;
            } else if (newQ > item.maxQuantity) {
                showAppToast("Vượt quá tồn kho!", "warning");
            }
            renderCart();
        }
    };

    window.removeCartItem = function(variantId) {
        adminCart = adminCart.filter(i => i.variantId !== variantId);
        renderCart();
    };

    function renderCart() {
        if (adminCart.length === 0) {
            cartBody.innerHTML = '<tr id="emptyCartRow"><td colspan="5" class="text-muted py-3">Chưa có sản phẩm nào</td></tr>';
            updateTotals(getShippingFee());
            return;
        }

        cartBody.innerHTML = '';
        adminCart.forEach(item => {
            const tr = document.createElement('tr');
            const imgUrl = item.thumbnail ? contextPath + item.thumbnail : contextPath + '/images/default.jpg';
            const priceF = new Intl.NumberFormat('vi-VN').format(item.price) + 'đ';
            const totalF = new Intl.NumberFormat('vi-VN').format(item.price * item.quantity) + 'đ';
            
            tr.innerHTML = `
                <td class="text-start">
                    <div class="d-flex align-items-center">
                        <img src="${imgUrl}" style="width:30px; height:30px; object-fit:cover; margin-right:8px;">
                        <div>
                            <div style="font-size:13px;" class="fw-bold">${item.productName}</div>
                            <div style="font-size:11px;" class="text-muted">Size: ${item.size} | Màu: ${item.color}</div>
                        </div>
                    </div>
                </td>
                <td style="font-size:13px;">${priceF}</td>
                <td>
                    <div class="input-group input-group-sm" style="width:100px; margin: 0 auto;">
                        <button class="btn btn-outline-secondary px-2" type="button" onclick="changeCartQty(${item.variantId}, -1)">-</button>
                        <input type="text" class="form-control text-center px-1" value="${item.quantity}" readonly>
                        <button class="btn btn-outline-secondary px-2" type="button" onclick="changeCartQty(${item.variantId}, 1)">+</button>
                    </div>
                </td>
                <td class="text-danger fw-bold" style="font-size:13px;">${totalF}</td>
                <td><button type="button" class="btn btn-sm text-danger px-1" onclick="removeCartItem(${item.variantId})"><i class="fas fa-times"></i></button></td>
            `;
            cartBody.appendChild(tr);
        });
        updateTotals(getShippingFee());
    }

    function getShippingFee() {
        let el = document.getElementById('co_shippingFeeDisplay');
        return parseInt(el.getAttribute('data-value') || 0);
    }

    function resetShippingFee() {
        updateTotals(0);
    }

    function updateTotals(shippingFee) {
        let subTotal = adminCart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        let total = subTotal + shippingFee;

        document.getElementById('co_shippingFeeDisplay').setAttribute('data-value', shippingFee);
        document.getElementById('co_shippingFeeDisplay').innerText = new Intl.NumberFormat('vi-VN').format(shippingFee) + 'đ';
        
        document.getElementById('co_subTotalDisplay').setAttribute('data-value', subTotal);
        document.getElementById('co_subTotalDisplay').innerText = new Intl.NumberFormat('vi-VN').format(subTotal) + 'đ';
        
        document.getElementById('co_totalDisplay').setAttribute('data-value', total);
        document.getElementById('co_totalDisplay').innerText = new Intl.NumberFormat('vi-VN').format(total) + 'đ';
    }

    // --- 4. Submit Form ---
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            
            if (adminCart.length === 0) {
                showAppToast("Vui lòng chọn ít nhất 1 sản phẩm!", "danger");
                return;
            }

            const formData = new FormData(form);
            const payload = {
                customerName: formData.get('customerName'),
                customerPhone: formData.get('customerPhone'),
                province_name: formData.get('province_name'),
                district_name: formData.get('district_name'),
                ward_name: formData.get('ward_name'),
                street: formData.get('street'),
                note: formData.get('note'),
                orderStatus: formData.get('orderStatus'),
                shippingFee: getShippingFee(),
                items: adminCart.map(item => ({
                    variantId: item.variantId,
                    quantity: item.quantity
                }))
            };

            const btnSubmit = document.getElementById('btnSubmitCreateOrder');
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Đang xử lý...';

            fetch(contextPath + '/api/admin/create-order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    showAppToast(data.message, "success");
                    // Ẩn modal và reload trang ngay lập tức
                    let modalObj = bootstrap.Modal.getInstance(document.getElementById('adminCreateOrderModal'));
                    if (modalObj) modalObj.hide();
                    location.reload();
                } else {
                    showAppToast(data.message, "danger");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = '<i class="fas fa-check-circle me-1"></i> Chốt Đơn Hàng';
                }
            })
            .catch(err => {
                console.error(err);
                showAppToast("Lỗi kết nối Server", "danger");
                btnSubmit.disabled = false;
                btnSubmit.innerHTML = '<i class="fas fa-check-circle me-1"></i> Chốt Đơn Hàng';
            });
        });
    }
});
