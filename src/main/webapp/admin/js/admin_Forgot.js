document.getElementById("forgotForm").addEventListener("submit", function (e) {
    e.preventDefault();
    alert("Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!");
    window.location.href = "admin-login.jsp";
});
