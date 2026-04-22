document.addEventListener("DOMContentLoaded", function () {
  const cancelButton = document.querySelector(".btn.btn-danger");

  if (cancelButton) {
    cancelButton.addEventListener("click", function (e) {
      e.preventDefault();
      const modalElement = document.getElementById("cancelSuccessModal");
      const cancelSuccessModal = new bootstrap.Modal(modalElement);
      cancelSuccessModal.show();
    });
  }

  const closeButton = document.querySelector("#cancelSuccessModal .btn-close");
  const closeModalButton = document.querySelector(
    "#cancelSuccessModal .btn-success"
  );

  if (closeButton) {
    closeButton.addEventListener("click", function () {
      window.location.href = "index.jsp";
    });
  }

  if (closeModalButton) {
    closeModalButton.addEventListener("click", function () {
      window.location.href = "index.jsp";
    });
  }
});
