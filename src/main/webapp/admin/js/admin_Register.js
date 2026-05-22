document.getElementById("registerForm").addEventListener("submit", function (e) {
    e.preventDefault();

    const submitBtn     = document.getElementById("submitBtn");
    const alertBox      = document.getElementById("alertBox");
    const contextPath   = document.getElementById("contextPath").value;

    // --- Thu thập dữ liệu ---
    const fullName        = document.getElementById("fullName").value.trim();
    const email           = document.getElementById("email").value.trim();
    const phone           = document.getElementById("phone").value.trim();
    const password        = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    const agreeTerms      = document.getElementById("agreeTerms").checked;

    // --- Validation phía client ---
    function showError(msg) {
        alertBox.className = "alert alert-danger mx-3";
        alertBox.textContent = msg;
        alertBox.classList.remove("d-none");
    }

    function showSuccess(msg) {
        alertBox.className = "alert alert-success mx-3";
        alertBox.textContent = msg;
        alertBox.classList.remove("d-none");
    }

    alertBox.classList.add("d-none");

    if (!fullName) { showError("Vui lòng nhập họ tên!"); return; }
    if (!email)    { showError("Vui lòng nhập email!"); return; }
    if (password.length < 8) { showError("Mật khẩu phải có ít nhất 8 ký tự!"); return; }
    if (password !== confirmPassword) { showError("Mật khẩu xác nhận không khớp!"); return; }
    if (!agreeTerms) { showError("Vui lòng đồng ý với điều khoản sử dụng!"); return; }

    // --- Gửi AJAX POST lên Servlet /admin-register ---
    submitBtn.disabled = true;
    submitBtn.textContent = "Đang xử lý...";

    const params = new URLSearchParams();
    params.append("fullName", fullName);
    params.append("email",    email);
    params.append("phone",    phone);
    params.append("password", password);

    fetch(contextPath + "/admin-register", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString()
    })
    .then(function (res) {
        return res.json().then(function (data) {
            return { status: res.status, body: data };
        });
    })
    .then(function (result) {
        if (result.body.status === "success") {
            showSuccess("Đăng ký tài khoản Admin thành công! Đang chuyển hướng...");
            setTimeout(function () {
                window.location.href = "admin-login.jsp";
            }, 1500);
        } else {
            showError(result.body.msg || "Đăng ký thất bại, vui lòng thử lại!");
            submitBtn.disabled = false;
            submitBtn.textContent = "Đăng Ký";
        }
    })
    .catch(function (err) {
        console.error("Lỗi kết nối tới server:", err);
        showError("Không thể kết nối tới server, vui lòng thử lại!");
        submitBtn.disabled = false;
        submitBtn.textContent = "Đăng Ký";
    });
});
