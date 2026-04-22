let revenueChart = null;
let categoryChart = null;

document.addEventListener("DOMContentLoaded", function () {
    initializeDashboard();
});

function initializeDashboard() {
    createRevenueChart();
    createCategoryChart();
    loadDashboardData();
}

// Create Revenue Chart
function createRevenueChart() {
    const ctx = document.getElementById("revenueChart").getContext("2d");

    revenueChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: [
                "Tháng 7",
                "Tháng 8",
                "Tháng 9",
                "Tháng 10",
                "Tháng 11",
                "Tháng 12",
            ],
            datasets: [
                {
                    label: "Doanh Thu (triệu đ)",
                    data: [65, 78, 90, 81, 95, 120],
                    backgroundColor: "#667eea",
                    borderColor: "#667eea",
                    borderWidth: 1,
                    borderRadius: 6,
                },
            ],
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            indexAxis: undefined,
            plugins: {
                legend: {
                    display: true,
                    position: "top",
                },
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: "#f0f0f0",
                        drawBorder: false,
                    },
                    ticks: {
                        callback: function (value) {
                            return value + "M";
                        },
                    },
                },
                x: {
                    grid: {
                        display: false,
                    },
                },
            },
        },
    });
}

// Create Category Chart (Pie)
function createCategoryChart() {
    const ctx = document.getElementById("categoryChart").getContext("2d");

    categoryChart = new Chart(ctx, {
        type: "doughnut",
        data: {
            labels: ["Nam", "Nữ", "Đồ Đôi"],
            datasets: [
                {
                    label: "Phần trăm bán hàng",
                    data: [45, 35, 20],
                    backgroundColor: ["#667eea", "#28a745", "#ffc107"],
                    borderColor: "#fff",
                    borderWidth: 2,
                },
            ],
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: "bottom",
                    labels: {
                        padding: 15,
                        font: {
                            size: 12,
                        },
                    },
                },
            },
        },
    });
}

function loadDashboardData() {
    // Simulate loading data from API
    console.log("Loading dashboard data...");

    // You can replace these with actual API calls
    updateStatCards();
    updateRecentOrders();
}

// Update Stat Cards
function updateStatCards() {
    const stats = [
        {value: "2.5M", label: "Doanh Thu", change: "12.5%"},
        {value: "1,234", label: "Đơn Hàng", change: "8.2%"},
        {value: "856", label: "Khách Hàng", change: "5.3%"},
        {value: "342", label: "Sản Phẩm", change: "0%"},
    ];

    console.log("Stats updated:", stats);
}

// Update Recent Orders
function updateRecentOrders() {
    const orders = [
        {
            id: "#985106",
            customer: "Nguyễn Văn A",
            date: "14/11/2025",
            total: "500,000đ",
            status: "Chờ Xác Nhận",
        },
        {
            id: "#985105",
            customer: "Trần Thị B",
            date: "13/11/2025",
            total: "750,000đ",
            status: "Đang Giao",
        },
        {
            id: "#985104",
            customer: "Lê Văn C",
            date: "12/11/2025",
            total: "1,200,000đ",
            status: "Đã Giao",
        },
    ];

    console.log("Recent orders updated:", orders);
}

// Refresh dashboard data
function refreshDashboard() {
    loadDashboardData();
    showSuccess("Dữ liệu đã được cập nhật!");
}

// Export dashboard data
function exportDashboardData() {
    const data = {
        timestamp: new Date(),
        revenue: "2.5M",
        orders: "1,234",
        customers: "856",
        products: "342",
    };

    const dataStr = JSON.stringify(data, null, 2);
    const dataBlob = new Blob([dataStr], {type: "application/json"});
    const url = URL.createObjectURL(dataBlob);
    const link = document.createElement("a");
    link.href = url;
    link.download = `dashboard-${new Date().getTime()}.json`;
    link.click();
}

// Update chart with new data
function updateChartData(newData) {
    if (revenueChart) {
        revenueChart.data.datasets[0].data = newData;
        revenueChart.update();
    }
}

document.getElementById("sidebarToggle").addEventListener("click", function () {
    document.querySelector(".admin-sidebar").classList.toggle("active");
});

function initializeTargetChart() {
    const ctx = document.getElementById("targetChart").getContext("2d");
    new Chart(ctx, {
        type: "doughnut",
        data: {
            datasets: [
                {
                    data: [75.55, 24.45],
                    backgroundColor: ["#667eea", "#e0e0e0"],
                    borderColor: "white",
                    borderWidth: 3,
                },
            ],
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {display: false},
            },
        },
    });
}

document.addEventListener("DOMContentLoaded", initializeTargetChart);
