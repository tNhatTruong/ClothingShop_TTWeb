// Sidebar toggle for mobile
document.getElementById("sidebarToggle").addEventListener("click", function () {
    document.querySelector(".admin-sidebar").classList.toggle("active");
});

// Khởi tạo dữ liệu mẫu từ localStorage
function initializeUsers() {
    const existingUsers = localStorage.getItem("users");
    if (!existingUsers) {
        const defaultUsers = [
            {
                id: "U001",
                name: "Nguyễn Văn A",
                email: "nguyenvana@email.com",
                phone: "0912345678",
                role: "user",
                address: "Số 123 Đường Lê Lợi",
                city: "TP. Hồ Chí Minh",
                district: "Quận 1",
                note: "",
                createdDate: "2025-01-05",
            },
            {
                id: "U002",
                name: "Trần Thị B",
                email: "tranthib@email.com",
                phone: "0987654321",
                role: "user",
                address: "Số 456 Đường Trần Hưng Đạo",
                city: "TP. Hồ Chí Minh",
                district: "Quận 3",
                note: "",
                createdDate: "2025-02-10",
            },
            {
                id: "A003",
                name: "Quản Trị Viên",
                email: "admin@styleera.com",
                phone: "0904899626",
                role: "admin",
                address: "Số 789 Đường Nguyễn Huệ",
                city: "TP. Hồ Chí Minh",
                district: "Quận 1",
                note: "",
                createdDate: "2019-12-11",
            },
        ];
        localStorage.setItem("users", JSON.stringify(defaultUsers));
    }
}

// Lấy tất cả users từ localStorage
function getUsers() {
    const users = localStorage.getItem("users");
    return users ? JSON.parse(users) : [];
}

// Lưu users vào localStorage
function saveUsers(users) {
    localStorage.setItem("users", JSON.stringify(users));
}

// Load table khi trang load
document.addEventListener("DOMContentLoaded", function () {
    initializeUsers();
    loadUserTable();
});

// Load bảng người dùng từ localStorage
function loadUserTable() {
    const users = getUsers();
    const tbody = document.querySelector("table tbody");

    if (!tbody) return; // Nếu không có table, skip

    tbody.innerHTML = ""; // Xóa dữ liệu cũ

    users.forEach((user) => {
        const row = document.createElement("tr");
        const badgeClass = user.role === "admin" ? "bg-warning" : "bg-success";
        const roleText = user.role === "admin" ? "Admin" : "User";

        row.innerHTML = `
      <td>#${user.id}</td>
      <td>${user.name}</td>
      <td>${user.email}</td>
      <td><span class="badge ${badgeClass}">${roleText}</span></td>
      <td>*******</td>
      <td>${user.phone}</td>
      <td>${user.createdDate}</td>
      <td>
        <a href="admin-form-user.html?id=${user.id}" class="btn btn-sm btn-warning" title="Chỉnh sửa">
          <i class="fas fa-edit"></i>
        </a>
        <button class="btn btn-sm btn-danger" title="Xóa" onclick="deleteUserFromTable('${user.id}')">
          <i class="fas fa-trash"></i>
        </button>
      </td>
    `;

        tbody.appendChild(row);
    });
}

// Xóa user từ bảng và localStorage
function deleteUserFromTable(userId) {
    if (confirm("Bạn chắc chắn muốn xóa tài khoản này?")) {
        let users = getUsers();
        users = users.filter((user) => user.id !== userId);
        saveUsers(users);
        loadUserTable();
        alert("Xóa tài khoản thành công!");
    }
}

// Form validation
(function () {
    "use strict";
    window.addEventListener(
        "load",
        function () {
            var forms = document.querySelectorAll(".needs-validation");
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener(
                    "submit",
                    function (event) {
                        // Kiểm tra mật khẩu
                        const newPassword = document.getElementById("newPassword");
                        const confirmPassword = document.getElementById("confirmPassword");

                        if (newPassword && confirmPassword && newPassword.value) {
                            if (newPassword.value !== confirmPassword.value) {
                                event.preventDefault();
                                event.stopPropagation();
                                alert("Mật khẩu xác nhận không khớp!");
                                return;
                            }

                            if (newPassword.value.length < 8) {
                                event.preventDefault();
                                event.stopPropagation();
                                alert("Mật khẩu mới phải có ít nhất 8 ký tự!");
                                return;
                            }
                        }

                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add("was-validated");
                    },
                    false
                );
            });
        },
        false
    );
})();

// Xử lý form thêm tài khoản
const addUserForm = document.getElementById("addUserForm");
if (addUserForm) {
    addUserForm.addEventListener("submit", function (e) {
        e.preventDefault();

        // Validate form
        if (!this.checkValidity() === false) {
            e.stopPropagation();
        }

        const password = document.getElementById("addPassword").value;
        const confirmPassword = document.getElementById("addConfirmPassword").value;

        if (password.length < 8) {
            alert("Mật khẩu phải có ít nhất 8 ký tự");
            return;
        }

        if (password !== confirmPassword) {
            alert("Mật khẩu xác nhận không trùng khớp");
            return;
        }

        // Tạo ID mới dựa vào role (Admin = A, User = U)
        const users = getUsers();
        const role = document.getElementById("addRole").value;
        const prefix = role === "admin" ? "A" : "U";

        // Tìm số lớn nhất của cùng loại người dùng
        let maxNum = 0;
        users.forEach((user) => {
            if (user.id.startsWith(prefix)) {
                const num = parseInt(user.id.substring(1));
                if (num > maxNum) {
                    maxNum = num;
                }
            }
        });

        const newId = prefix + String(maxNum + 1).padStart(3, "0");

        const newUserData = {
            id: newId,
            name: document.getElementById("addName").value,
            email: document.getElementById("addEmail").value,
            phone: document.getElementById("addPhone").value,
            role: role,
            address: document.getElementById("addAddress").value,
            city: document.getElementById("addCity").value,
            district: document.getElementById("addDistrict").value,
            password: password,
            note: document.getElementById("addNote").value,
            createdDate: new Date().toISOString().split("T")[0],
        };

        console.log("New User Data:", newUserData);

        // Lưu vào localStorage
        users.push(newUserData);
        saveUsers(users);

        // Reset form
        this.reset();

        // Đóng modal
        const modal = bootstrap.Modal.getInstance(
            document.getElementById("addUserModal")
        );
        modal.hide();

        // Reload bảng
        loadUserTable();

        alert("Thêm tài khoản thành công!");
    });
}
