document
  .getElementById("registerForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    const password = this.querySelector('input[type="password"]');
    const confirmPassword = this.querySelectorAll('input[type="password"]')[1];

    if (password.value !== confirmPassword.value) {
      showAppToast("Mật khẩu không khớp!", "error");
      return;
    }

    showAppToast("Đăng ký thành công! Vui lòng đăng nhập.", "success");
    window.location.href = "admin-login.jsp";
  });
