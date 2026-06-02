// Đổi ảnh chính
function changeImage(fullPath) {
  const mainImg = document.getElementById('mainImage');
  if (mainImg) {
    mainImg.src = fullPath;
  }
}

// Hàm chọn MÀU (Xử lý lọc Size)
function pickColor(element, selectedColor) {
  // Không làm gì nếu nút màu đang bị mờ (trường hợp mở rộng sau này)
  if (element.classList.contains('disabled-variant')) return;

  // Đổi trạng thái active cho nút Màu
  document.querySelectorAll('.color-choice').forEach(el => el.classList.remove('active'));
  element.classList.add('active');

  const finalColorInput = document.getElementById('finalColor');
  if(finalColorInput) finalColorInput.value = selectedColor;

  // Biến variantsData lấy từ JSP
  if (typeof variantsData === 'undefined') return;

  // Lọc ra danh sách các SIZE CÓ SẴN (tồn kho > 0) cho màu vừa chọn
  const availableSizes = variantsData
      .filter(v => v.color === selectedColor && v.stock > 0)
      .map(v => v.size);

  const finalSizeInput = document.getElementById('finalSize');
  let isCurrentSizeStillAvailable = false;

  // Duyệt qua tất cả nút Size để ẩn/hiện
  document.querySelectorAll('.size-label').forEach(label => {
    const size = label.getAttribute('data-size');

    if (availableSizes.includes(size)) {
      // Có hàng -> Hiện bình thường
      label.classList.remove('disabled-variant');
      if (finalSizeInput && finalSizeInput.value === size) {
        isCurrentSizeStillAvailable = true;
      }
    } else {
      // Hết hàng -> Làm mờ
      label.classList.add('disabled-variant');
      label.classList.remove('active');
    }
  });

  // Nếu Size đang chọn trước đó không còn hỗ trợ cho màu mới, reset lại Size
  if (!isCurrentSizeStillAvailable && finalSizeInput) {
    finalSizeInput.value = '';
    document.querySelectorAll('.size-label').forEach(label => label.classList.remove('active'));
  }

  updateVariantIdForCart();
}

// Hàm chọn SIZE
function pickSize(element, selectedSize) {
  // Không làm gì nếu nút Size đang bị mờ (hết hàng)
  if (element.classList.contains('disabled-variant')) return;

  // Đổi trạng thái active cho nút Size
  document.querySelectorAll('.size-label').forEach(el => el.classList.remove('active'));
  element.classList.add('active');

  const finalSizeInput = document.getElementById('finalSize');
  if(finalSizeInput) finalSizeInput.value = selectedSize;

  updateVariantIdForCart();
}

// Cập nhật Variant ID cho nút Giỏ Hàng
function updateVariantIdForCart() {
  const finalSizeInput = document.getElementById('finalSize');
  const finalColorInput = document.getElementById('finalColor');
  const finalVariantIdInput = document.getElementById('finalVariantId');
  const btnAddToCart = document.getElementById('btnAddToCart');
  const btnBuyNow = document.getElementById('btnBuyNow');

  if (!finalSizeInput || !finalColorInput || typeof variantsData === 'undefined') return;

  const currentSize = finalSizeInput.value;
  const currentColor = finalColorInput.value;

  // Kiểm tra nếu người dùng đã chọn đầy đủ cả Size và Color
  if (currentSize && currentColor) {
    const matchedVariant = variantsData.find(v => v.size === currentSize && v.color === currentColor);

    if (matchedVariant) {

      // Cập nhật cho nút Thêm vào giỏ hàng
      if (btnAddToCart) {
        btnAddToCart.setAttribute('data-variant-id', matchedVariant.variantId);
        btnAddToCart.disabled = false;
      }

      // Cập nhật cho Form Mua hàng
      if (finalVariantIdInput) {
        finalVariantIdInput.value = matchedVariant.variantId; // Gắn ID vào để submit form
      }
      if (btnBuyNow) {
        btnBuyNow.disabled = false; // Bật nút mua hàng
      }
      return; // Thoát hàm thành công
    }
  }

  if (btnAddToCart) btnAddToCart.disabled = true;
  if (btnBuyNow) btnBuyNow.disabled = true;
  if (finalVariantIdInput) finalVariantIdInput.value = '';
}

// Khởi tạo các sự kiện khi load trang
document.addEventListener("DOMContentLoaded", () => {
  // Xử lý tăng giảm số lượng
  const qtyInput = document.getElementById('quantity');
  const btnInc = document.getElementById('btn-increase');
  const btnDec = document.getElementById('btn-decrease');

  if (btnInc && btnDec && qtyInput) {
    btnInc.onclick = () => qtyInput.value = parseInt(qtyInput.value) + 1;
    btnDec.onclick = () => {
      let v = parseInt(qtyInput.value);
      if (v > 1) qtyInput.value = v - 1;
    };
  }

  // Tự động kích hoạt Màu đầu tiên ngay khi load trang
  const defaultColorElement = document.querySelector('.color-choice.active');
  if (defaultColorElement) {
    pickColor(defaultColorElement, defaultColorElement.getAttribute('data-color'));
  }
});