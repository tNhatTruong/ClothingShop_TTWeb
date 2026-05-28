let revenueChart = null;

document.addEventListener("DOMContentLoaded", function () {
    initializeDashboard();
});

function initializeDashboard() {
    const revenueCanvas = document.getElementById("revenueChart");
    if (revenueCanvas) {
        createRevenueChart(revenueCanvas);
    }

    const sidebarToggle = document.getElementById("sidebarToggle");
    if (sidebarToggle) {
        sidebarToggle.addEventListener("click", function () {
            document.querySelector(".admin-sidebar").classList.toggle("active");
        });
    }

    const targetCanvas = document.getElementById("targetChart");
    if (targetCanvas) {
        initializeTargetChart(targetCanvas);
    }
}

function getDashboardChartConfig() {
    const chartData = window.dashboardChartData;
    if (chartData && chartData.labels && chartData.labels.length > 0) {
        return {
            labels: chartData.labels,
            data: chartData.data || [],
        };
    }

    return {
        labels: [],
        data: [],
    };
}

function formatRevenueTick(value) {
    if (value >= 1_000_000) {
        return (value / 1_000_000).toFixed(1) + "M";
    }
    if (value >= 1_000) {
        return Math.round(value / 1_000) + "K";
    }
    return value;
}

function createRevenueChart(canvas) {
    const config = getDashboardChartConfig();
    const ctx = canvas.getContext("2d");

    revenueChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: config.labels,
            datasets: [
                {
                    label: "Doanh Thu (VNĐ)",
                    data: config.data,
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
                            return formatRevenueTick(value);
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

function refreshDashboard() {
    window.location.reload();
}

function exportDashboardData() {
    const statCards = document.querySelectorAll(".stat-card h3");
    const data = {
        timestamp: new Date().toISOString(),
        users: statCards[0] ? statCards[0].textContent.trim() : "",
        orders: statCards[1] ? statCards[1].textContent.trim() : "",
        revenue: statCards[2] ? statCards[2].textContent.trim() : "",
        products: statCards[3] ? statCards[3].textContent.trim() : "",
    };

    const dataStr = JSON.stringify(data, null, 2);
    const dataBlob = new Blob([dataStr], {type: "application/json"});
    const url = URL.createObjectURL(dataBlob);
    const link = document.createElement("a");
    link.href = url;
    link.download = `dashboard-${new Date().getTime()}.json`;
    link.click();
    URL.revokeObjectURL(url);
}

function updateChartData(newData) {
    if (revenueChart) {
        revenueChart.data.datasets[0].data = newData;
        revenueChart.update();
    }
}

function initializeTargetChart(canvas) {
    const ctx = canvas.getContext("2d");
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
