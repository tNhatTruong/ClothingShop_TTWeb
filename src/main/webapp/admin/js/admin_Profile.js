// Sidebar toggle for mobile
document.getElementById("sidebarToggle").addEventListener("click", function () {
  document.querySelector(".admin-sidebar").classList.toggle("active");
});

document
  .getElementById("changePasswordForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    alert("Mật khẩu đã được đổi!");
    this.reset();
  });

document
  .getElementById("settingsForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    alert("Cài đặt đã được lưu!");
  });
