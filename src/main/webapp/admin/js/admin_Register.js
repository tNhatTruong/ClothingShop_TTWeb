document
  .getElementById("registerForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    const password = this.querySelector('input[type="password"]');
    const confirmPassword = this.querySelectorAll('input[type="password"]')[1];

    if (password.value !== confirmPassword.value) {
      alert("Mật khẩu không khớp!");
      return;
    }

    alert("Đăng ký thành công! Vui lòng đăng nhập.");
    window.location.href = "admin-login.jsp";
  });
