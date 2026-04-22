// Chọn sao
const stars = document.querySelectorAll(".star");

stars.forEach(star => {
    star.addEventListener("click", function () {
        const value = this.getAttribute("data-value");

        stars.forEach(s => s.classList.remove("active"));
        for (let i = 0; i < value; i++) {
            stars[i].classList.add("active");
        }
    });
});

// Preview ảnh
const inputImage = document.getElementById("images");
const previewBox = document.getElementById("preview");

inputImage.addEventListener("change", function () {
    previewBox.innerHTML = "";
    const files = this.files;

    for (let i = 0; i < files.length; i++) {
        const img = document.createElement("img");
        img.src = URL.createObjectURL(files[i]);
        previewBox.appendChild(img);
    }
});
// Nút gửi đánh giá
const submitBtn = document.querySelector(".btn-submit");
const popup = document.getElementById("successPopup");
const closePopup = document.getElementById("closePopup");

submitBtn.addEventListener("click", function () {
    popup.style.display = "flex"; // Hiện popup

    // Nếu bạn muốn xóa form sau khi gửi:
    // document.querySelector("textarea").value = "";
    // document.getElementById("preview").innerHTML = "";
    // stars.forEach(s => s.classList.remove("active"));
});

// Đóng popup
closePopup.addEventListener("click", function () {
    popup.style.display = "none";
});
