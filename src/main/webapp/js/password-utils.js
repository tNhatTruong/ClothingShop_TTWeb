/**
 * password-utils.js
 * Các tiện ích xử lý mật khẩu: Ẩn/Hiện và Kiểm tra độ mạnh
 */

// Hàm toggle ẩn hiện mật khẩu
// Sử dụng event.currentTarget để lấy button được click
function togglePassword(id) {
    const input = document.getElementById(id);
    const icon = event.currentTarget.querySelector("i");

    if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}

// Logic check password strength đơn giản (UI only)
function checkPasswordStrength(password, context) {
    const bar = document.getElementById(context + 'StrengthBar');
    const text = document.getElementById(context + 'StrengthText');

    // Nếu không tìm thấy element hiển thị thì return luôn để tránh lỗi null
    if (!bar || !text) return;

    let strength = 0;
    if (password.length >= 8) strength++;
    if (password.match(/[a-z]+/)) strength++;
    if (password.match(/[A-Z]+/)) strength++;
    if (password.match(/[0-9]+/)) strength++;
    if (password.match(/[$@#&!]+/)) strength++;

    let color = '#e0e0e0';
    let width = '0%';
    let label = 'Chưa nhập';

    switch(strength) {
        case 0: break;
        case 1: width = '20%'; color = '#f44336'; label = 'Yếu'; break;
        case 2: width = '40%'; color = '#ff9800'; label = 'Trung bình'; break;
        case 3: width = '60%'; color = '#ffeb3b'; label = 'Khá'; break;
        case 4: width = '80%'; color = '#4caf50'; label = 'Mạnh'; break;
        case 5: width = '100%'; color = '#009688'; label = 'Rất mạnh'; break;
    }

    bar.style.width = width;
    bar.style.backgroundColor = color;
    text.innerText = 'Độ mạnh mật khẩu: ' + label;
}