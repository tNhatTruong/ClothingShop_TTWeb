document.getElementById("sidebarToggle").addEventListener("click", function () {
  document.querySelector(".admin-sidebar").classList.toggle("active");
});

function viewOrder(orderId) {
  const modal = new bootstrap.Modal(
    document.getElementById("orderDetailModal")
  );
  modal.show();
}

function confirmOrder(orderId) {
  if (confirm("Xác nhận đơn hàng " + orderId + "?")) {
    showAppToast("Đơn hàng " + orderId + " đã được xác nhận!", "success");
    setTimeout(() => location.reload(), 1000);
  }
}

function trackOrder(orderId) {
  showAppToast("Theo dõi vận chuyển cho " + orderId, "success");
}

function printInvoice(orderId) {
  showAppToast("In hóa đơn cho " + orderId, "success");
  window.print();
}

function deleteOrder(orderId) {
  if (confirm("Bạn có chắc chắn muốn xóa " + orderId + "?")) {
    showAppToast("Đơn hàng " + orderId + " đã được xóa!", "success");
    setTimeout(() => location.reload(), 1000);
  }
}
