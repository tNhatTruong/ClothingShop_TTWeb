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
    alert("Đơn hàng " + orderId + " đã được xác nhận!");
    location.reload();
  }
}

function trackOrder(orderId) {
  alert("Theo dõi vận chuyển cho " + orderId);
}

function printInvoice(orderId) {
  alert("In hóa đơn cho " + orderId);
  window.print();
}

function deleteOrder(orderId) {
  if (confirm("Bạn có chắc chắn muốn xóa " + orderId + "?")) {
    alert("Đơn hàng " + orderId + " đã được xóa!");
    location.reload();
  }
}
