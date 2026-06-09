document.getElementById("forgotForm").addEventListener("submit", function (e) {
    e.preventDefault();
    showAppToast("Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!", "success");
    window.location.href = "admin-login.jsp";
});
