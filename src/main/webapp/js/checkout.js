document.addEventListener('DOMContentLoaded', function () {
    // 1. DỮ LIỆU DÙNG ID (KHỚP VỚI HTML: 43 và 44)
    const districts = {
        "43": [ // TP.HCM Nội thành
            { value: "1", text: "Quận 1" },
            { value: "3", text: "Quận 3" },
            { value: "4", text: "Quận 4" },
            { value: "5", text: "Quận 5" },
            { value: "6", text: "Quận 6" },
            { value: "7", text: "Quận 7" },
            { value: "8", text: "Quận 8" },
            { value: "10", text: "Quận 10" },
            { value: "11", text: "Quận 11" },
            { value: "12", text: "Quận 12" },
            { value: "TB", text: "Quận Tân Bình" },
            { value: "TP", text: "Quận Tân Phú" },
            { value: "BT", text: "Quận Bình Thạnh" },
            { value: "BTA", text: "Quận Bình Tân" },
            { value: "PN", text: "Quận Phú Nhuận" }
        ],
        "44": [ // TP.HCM Ngoại thành
            { value: "GV", text: "Quận Gò Vấp" },
            { value: "TD", text: "TP Thủ Đức" },
            { value: "CC", text: "Huyện Củ Chi" },
            { value: "BC", text: "Huyện Bình Chánh" },
            { value: "NB", text: "Huyện Nhà Bè" },
            { value: "CG", text: "Huyện Cần Giờ" },
            { value: "HM", text: "Huyện Hóc Môn" }
        ]
    };

    const citySelect = document.getElementById("input-shipping-zone");
    const districtSelect = document.getElementById("input-shipping-custom-field-30");

    // Hai thẻ ẩn dùng để gửi Tên về Server
    const hiddenCity = document.getElementById("hidden-city-name");
    const hiddenDistrict = document.getElementById("hidden-district-name");

    if (citySelect && districtSelect) {

        // Hàm reset
        function resetDistricts() {
            districtSelect.innerHTML = '<option value="">Vui lòng chọn quận/huyện</option>';
            districtSelect.disabled = true;
            // Nếu reset quận thì cũng xóa value trong thẻ hidden
            if(hiddenDistrict) hiddenDistrict.value = "";
        }

        // Hàm cập nhật Input ẩn khi người dùng chọn (Lấy TEXT để lưu DB)
        function updateHiddenInputs() {
            // Lấy text của Tỉnh đang chọn -> Gán vào hiddenCity
            if (citySelect.selectedIndex >= 0 && hiddenCity) {
                hiddenCity.value = citySelect.options[citySelect.selectedIndex].text;
            }
            // Lấy text của Quận đang chọn -> Gán vào hiddenDistrict
            if (districtSelect.selectedIndex >= 0 && hiddenDistrict && !districtSelect.disabled) {
                hiddenDistrict.value = districtSelect.options[districtSelect.selectedIndex].text;
            }
        }

        // Hàm Render Quận/Huyện
        function renderDistricts(cityId, selectedDistrictText = null) {
            resetDistricts();

            if (!cityId || cityId === "0" || !districts[cityId]) return;

            const list = districts[cityId];
            list.forEach(d => {
                const option = document.createElement("option");
                option.value = d.value; // ID ngắn gọn
                option.textContent = d.text;

                // Logic Auto-fill: So sánh bằng TEXT vì DB lưu Text
                if (selectedDistrictText && d.text === selectedDistrictText) {
                    option.selected = true;
                }
                districtSelect.appendChild(option);
            });

            districtSelect.disabled = false;
            // Gọi update ngay sau khi render để đảm bảo thẻ hidden có dữ liệu đúng
            updateHiddenInputs();
        }

        // --- SỰ KIỆN ---
        citySelect.addEventListener("change", function () {
            renderDistricts(this.value);
            updateHiddenInputs();
        });

        districtSelect.addEventListener("change", function () {
            updateHiddenInputs();
        });


        // === LOGIC AUTO-FILL TỪ DATABASE (QUAN TRỌNG) ===
        // DB trả về Tên ("TP.Hồ Chí Minh..."), ta cần tìm ra ID ("43") để select đúng
        const savedCityText = citySelect.getAttribute("data-selected"); // "TP.Hồ Chí Minh..."
        const savedDistrictText = districtSelect.getAttribute("data-selected"); // "Quận 1"

        if (savedCityText) {
            // 1. Tìm option nào trong City Select có text trùng với savedCityText
            let foundCityId = "";
            for (let i = 0; i < citySelect.options.length; i++) {
                if (citySelect.options[i].text === savedCityText) {
                    citySelect.selectedIndex = i;
                    foundCityId = citySelect.options[i].value;
                    break;
                }
            }

            // 2. Nếu tìm thấy ID tương ứng (VD: 43) -> Render quận và chọn lại quận cũ
            if (foundCityId) {
                renderDistricts(foundCityId, savedDistrictText);
            }
            // Cập nhật thẻ hidden để nếu user không sửa gì thì bấm lưu vẫn đúng
            updateHiddenInputs();
        }
    }

    // XÁC NHẬN ĐƠN HÀNG (Logic Modal)
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

    // Populate Modal (chỉ chạy ở trang checkout success)
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
});