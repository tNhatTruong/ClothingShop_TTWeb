document.addEventListener('DOMContentLoaded', function () {

    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

    if (provinceSelect && districtSelect && wardSelect) {
        // A. Hàm load Tỉnh/Thành ngay khi mở trang
        function loadProvinces() {
            console.log("1. Đang gọi Java Backend để lấy Tỉnh/Thành...");
            fetch(contextPath + '/api/address/province', {
                method: 'GET'
            })
                .then(response => response.json())
                .then(data => {
                    if(data.code === 200) {
                        let savedProvince = provinceSelect.getAttribute('data-selected-name');
                        data.data.forEach(province => {
                            let option = document.createElement('option');
                            option.value = province.ProvinceID;
                            option.text = province.ProvinceName;
                            provinceSelect.appendChild(option);
                            if (savedProvince && province.ProvinceName === savedProvince) {
                                provinceSelect.value = province.ProvinceID;
                            }
                        });
                        console.log("2. Đã load xong danh sách Tỉnh/Thành!");
                        if (provinceSelect.value) {
                            provinceSelect.dispatchEvent(new Event('change'));
                        }
                    } else {
                        console.error("Lỗi: ", data.message);
                    }
                }).catch(error => console.error("Lỗi mạng: ", error));
        }

        loadProvinces();

        // B. Sự kiện chọn Tỉnh -> Xổ Quận/Huyện
        provinceSelect.addEventListener('change', function() {
            let provinceId = this.value;
            let provinceNameHidden = document.getElementById('provinceName');
            let districtNameHidden = document.getElementById('districtName');
            let wardNameHidden = document.getElementById('wardName');
            
            if(provinceNameHidden && this.selectedIndex > 0) {
                provinceNameHidden.value = this.options[this.selectedIndex].text;
            } else if (provinceNameHidden) {
                provinceNameHidden.value = '';
            }
            if (districtNameHidden) districtNameHidden.value = '';
            if (wardNameHidden) wardNameHidden.value = '';

            districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            districtSelect.disabled = true;
            wardSelect.disabled = true;

            if (!provinceId) return;

            fetch(contextPath + '/api/address/district?province_id=' + provinceId, {
                method: 'GET'
            })
                .then(response => response.json())
                .then(data => {
                    if(data.code === 200) {
                        districtSelect.disabled = false;
                        let savedDistrict = districtSelect.getAttribute('data-selected-name');
                        data.data.forEach(district => {
                            let option = document.createElement('option');
                            option.value = district.DistrictID;
                            option.text = district.DistrictName;
                            districtSelect.appendChild(option);
                            if (savedDistrict && district.DistrictName === savedDistrict) {
                                districtSelect.value = district.DistrictID;
                            }
                        });
                        if (districtSelect.value) {
                            districtSelect.dispatchEvent(new Event('change'));
                        }
                    }
                });
        });

        // C. Sự kiện chọn Quận -> Xổ Phường/Xã
        districtSelect.addEventListener('change', function() {
            let districtId = this.value;
            let districtNameHidden = document.getElementById('districtName');
            let wardNameHidden = document.getElementById('wardName');
            
            if(districtNameHidden && this.selectedIndex > 0) {
                districtNameHidden.value = this.options[this.selectedIndex].text;
            } else if (districtNameHidden) {
                districtNameHidden.value = '';
            }
            if (wardNameHidden) wardNameHidden.value = '';

            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;

            if (!districtId) return;

            fetch(contextPath + '/api/address/ward?district_id=' + districtId, {
                method: 'GET'
            })
                .then(response => response.json())
                .then(data => {
                    if(data.code === 200) {
                        wardSelect.disabled = false;
                        let savedWard = wardSelect.getAttribute('data-selected-name');
                        data.data.forEach(ward => {
                            let option = document.createElement('option');
                            option.value = ward.WardCode;
                            option.text = ward.WardName;
                            wardSelect.appendChild(option);
                            if (savedWard && ward.WardName === savedWard) {
                                wardSelect.value = ward.WardCode;
                            }
                        });
                        if (wardSelect.value) {
                            wardSelect.dispatchEvent(new Event('change'));
                        }
                    }
                });
        });

        // D. Gọi tính phí khi chọn Phường/Xã
        wardSelect.addEventListener('change', function() {
            let toDistrictId = districtSelect.value;
            let toWardCode = this.value;
            let wardNameHidden = document.getElementById('wardName');
            if(wardNameHidden && this.selectedIndex > 0) {
                wardNameHidden.value = this.options[this.selectedIndex].text;
            } else if (wardNameHidden) {
                wardNameHidden.value = '';
            }

            // Chỉ tính phí ship nếu đang ở trang checkout (có hiển thị phí ship)
            let shippingFeeSpan = document.getElementById('shipping-fee-display');
            if (!shippingFeeSpan) return;

            if(toDistrictId && toWardCode) {
                fetch(contextPath + '/api/calculate-shipping', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        'district_id': toDistrictId,
                        'ward_code': toWardCode
                    })
                })
                    .then(res => res.json())
                    .then(data => {
                        if(data.status === 'success') {
                            let shippingFee = data.fee;

                            let subTotalSpan = document.getElementById('sub-total-display');
                            let subTotal = subTotalSpan ? parseInt(subTotalSpan.getAttribute('data-value') || 0) : 0;

                            let total = subTotal + shippingFee;

                            const formatter = new Intl.NumberFormat('vi-VN');
                            let shipDisplay = document.getElementById('shipping-fee-display');
                            let totalDisplay = document.getElementById('total-price-display');

                            if(shipDisplay) shipDisplay.innerText = formatter.format(shippingFee) + '₫';
                            if(totalDisplay) totalDisplay.innerText = formatter.format(total) + '₫';
                        } else {
                            console.error("Lỗi tính phí: ", data.message);
                        }
                    })
                    .catch(err => console.error(err));
            }
        });
    }

    // Modal và Nút bấm
    const viewOrderBtn = document.getElementById('viewOrderBtn');
    const trackBtn = document.getElementById('trackBtn');
    const homeBtn = document.getElementById('homeBtn');
    const modalBackdrop = document.getElementById('modalBackdrop');

    function openModal(){
        if(modalBackdrop) {
            modalBackdrop.classList.add('show');
            modalBackdrop.setAttribute('aria-hidden','false');
        }
    }

    if (viewOrderBtn) viewOrderBtn.addEventListener('click', () => openModal());

    if (trackBtn) {
        trackBtn.addEventListener('click', () => {
            const params = new URLSearchParams(location.search);
            const orderId = params.get('order') || '985723';
            location.href = '/orders/' + orderId;
        });
    }

    if (homeBtn) {
        homeBtn.addEventListener('click', () => {
            location.href = window.location.origin + '/StyleEra/home';
        });
    }

    (function populateFromQuery(){
        const params = new URLSearchParams(location.search);
        const setText = (id, val) => {
            const el = document.getElementById(id);
            if(el) el.textContent = val;
        };
        if(params.has('order')){
            const id = params.get('order');
            setText('orderId', 'Mã đơn hàng: #' + id);
            setText('modalOrder', '#' + id);
        }
        if(params.has('name')) setText('shipName', params.get('name'));
        if(params.has('phone')) setText('shipPhone', params.get('phone'));
        if(params.has('addr')) setText('shipAddress', params.get('addr'));
        if(params.has('eta')) setText('shipETA', params.get('eta'));
        if(params.has('pay')) setText('payMethod', params.get('pay'));
    })();

    // Tự động điền ngày hôm nay vào ô "Ngày đặt hàng"
    const orderDateInput = document.getElementById('input-shipping-custom-field-31');
    if (orderDateInput && !orderDateInput.value) {
        const today = new Date();
        const dd = String(today.getDate()).padStart(2, '0');
        const mm = String(today.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
        const yyyy = today.getFullYear();

        // Định dạng DD/MM/YYYY theo VN
        orderDateInput.value = `${dd}/${mm}/${yyyy}`;
        orderDateInput.readOnly = true;
    }
});