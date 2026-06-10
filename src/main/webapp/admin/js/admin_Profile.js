// Sidebar toggle for mobile
document.getElementById("sidebarToggle").addEventListener("click", function () {
  document.querySelector(".admin-sidebar").classList.toggle("active");
});

document
  .getElementById("changePasswordForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    showAppToast("Mật khẩu đã được đổi!", "success");
    this.reset();
  });

// Success Alert auto dismiss
document.addEventListener('DOMContentLoaded', function () {
    const alertEl = document.getElementById('successAlert');
    if (alertEl) {
        setTimeout(() => {
            const bsAlert = bootstrap.Alert.getOrCreateInstance(alertEl);
            bsAlert.close();
        }, 3000);
    }
});

// Dynamic GHN Geography Dropdowns for Admin Profile
document.addEventListener('DOMContentLoaded', function () {
    const provinceSelect = document.getElementById('adminProvince');
    const districtSelect = document.getElementById('adminDistrict');
    const cityNameInput = document.getElementById('adminCityName');
    const districtNameInput = document.getElementById('adminDistrictName');

    if (provinceSelect && districtSelect) {
        const rootPath = window.contextPath || '';

        // Load provinces
        function loadProvinces() {
            fetch(rootPath + '/api/address/province')
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        const selectedProvinceName = provinceSelect.getAttribute('data-selected');
                        let selectedProvinceId = null;

                        data.data.forEach(prov => {
                            let option = document.createElement('option');
                            option.value = prov.ProvinceID;
                            option.text = prov.ProvinceName;
                            if (selectedProvinceName && selectedProvinceName.trim().toLowerCase() === prov.ProvinceName.trim().toLowerCase()) {
                                option.selected = true;
                                selectedProvinceId = prov.ProvinceID;
                                cityNameInput.value = prov.ProvinceName;
                            }
                            provinceSelect.appendChild(option);
                        });

                        if (selectedProvinceId) {
                            loadDistricts(selectedProvinceId);
                        }
                    }
                })
                .catch(error => console.error("Error loading provinces:", error));
        }

        // Load districts
        function loadDistricts(provinceId) {
            districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
            districtSelect.disabled = true;

            fetch(rootPath + '/api/address/district?province_id=' + provinceId)
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        districtSelect.disabled = false;
                        const selectedDistrictName = districtSelect.getAttribute('data-selected');

                        data.data.forEach(dist => {
                            let option = document.createElement('option');
                            option.value = dist.DistrictID;
                            option.text = dist.DistrictName;
                            if (selectedDistrictName && selectedDistrictName.trim().toLowerCase() === dist.DistrictName.trim().toLowerCase()) {
                                option.selected = true;
                                districtNameInput.value = dist.DistrictName;
                            }
                            districtSelect.appendChild(option);
                        });
                    }
                })
                .catch(error => console.error("Error loading districts:", error));
        }

        // Event listener for province change
        provinceSelect.addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            if (this.value) {
                cityNameInput.value = selectedOption.text;
                loadDistricts(this.value);
            } else {
                cityNameInput.value = '';
                districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
                districtSelect.disabled = true;
                districtNameInput.value = '';
            }
        });

        // Event listener for district change
        districtSelect.addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            if (this.value) {
                districtNameInput.value = selectedOption.text;
            } else {
                districtNameInput.value = '';
            }
        });

        // Initial trigger
        loadProvinces();
    }
});
