<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản Lý Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css"/>
    <link rel="stylesheet" href="css/admin_order.css"/>
</head>

<body>
<!-- ===== HEADER ===== -->
<c:set var="currentPage" value="orders" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

        <!-- ===== CONTENT ===== -->
        <main class="admin-content">
            <!-- Page Header -->
            <div class="page-header mb-5">
                <div>
                    <h1 class="page-title">Quản Lý Đơn Hàng</h1>
                </div>
            </div>

            <!-- Stats -->
            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1">156</h3>
                            <p class="text-muted small mb-0">Chờ Vận chuyển</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-warning">84</h3>
                            <p class="text-muted small mb-0">Đang Vận chuyển</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-success">942</h3>
                            <p class="text-muted small mb-0">Đã Giao</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h3 class="mb-1 text-danger">52</h3>
                            <p class="text-muted small mb-0">Đã Hủy</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label">Tìm Kiếm Mã ĐH</label>
                            <input type="text" class="form-control" placeholder="#985106"/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Trạng Thái</label>
                            <select class="form-select">
                                <option value="">Tất Cả Trạng Thái</option>
                                <option value="pending">Chờ Vận chuyển</option>
                                <option value="shipping">Đang Vận chuyển</option>
                                <option value="delivered">Đã Giao</option>
                                <option value="cancelled">Đã Hủy</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Danh Sách Đơn Hàng</h6>
                    <span class="text-muted small">Tổng cộng: <strong>5</strong> đơn hàng</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>Mã ĐH</th>
                                <th>Khách Hàng</th>
                                <th>Email</th>
                                <th>Ngày Đặt</th>
                                <th>Tổng Tiền</th>
                                <th>Trạng Thái</th>
                                <th style="width: 120px">Theo dõi</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><strong>#985110</strong></td>
                                <td>Phạm Văn D</td>
                                <td>phamvand@email.com</td>
                                <td>15/11/2025</td>
                                <td><strong>890,000đ</strong></td>
                                <td><span class="badge bg-info">Chờ Vận chuyển</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info" title="Chi tiết" onclick="viewOrder('#985110')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#985109</strong></td>
                                <td>Hoàng Thị E</td>
                                <td>hoangthie@email.com</td>
                                <td>14/11/2025</td>
                                <td><strong>620,000đ</strong></td>
                                <td>
                        <span class="badge bg-warning text-dark">Đang Vận chuyển</span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info" title="Chi tiết" onclick="viewOrder('#985109')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#985108</strong></td>
                                <td>Đặng Văn F</td>
                                <td>dangvanf@email.com</td>
                                <td>13/11/2025</td>
                                <td><strong>1,100,000đ</strong></td>
                                <td><span class="badge bg-success">Đã Giao</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info" title="Chi tiết" onclick="viewOrder('#985108')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#985107</strong></td>
                                <td>Bùi Thị G</td>
                                <td>buithig@email.com</td>
                                <td>12/11/2025</td>
                                <td><strong>350,000đ</strong></td>
                                <td><span class="badge bg-success">Đã Giao</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info" title="Chi tiết" onclick="viewOrder('#985107')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#985106</strong></td>
                                <td>Nguyễn Văn A</td>
                                <td>nguyenvana@email.com</td>
                                <td>11/11/2025</td>
                                <td><strong>500,000đ</strong></td>
                                <td><span class="badge bg-danger">Đã Hủy</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info" title="Chi tiết" onclick="viewOrder('#985106')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="card-footer bg-light">
                    <nav aria-label="Page navigation">
                        <ul class="pagination mb-0 justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Trước</a>
                            </li>
                            <li class="page-item active">
                                <a class="page-link" href="#">1</a>
                            </li>

                            <li class="page-item">
                                <a class="page-link" href="#">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Order Detail Modal -->
<div class="modal fade" id="orderDetailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi Tiết Đơn Hàng</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                ></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <h6 class="text-muted">Thông Tin Khách Hàng</h6>
                        <p class="mb-1"><strong>Nguyễn Văn A</strong></p>
                        <p class="mb-1 small text-muted">nguyenvana@email.com</p>
                        <p class="small text-muted">0912345678</p>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-muted">Địa Chỉ Giao Hàng</h6>
                        <p class="small mb-0">123 Đường ABC, Quận 1, TP. HCM</p>
                    </div>
                </div>

                <hr/>

                <h6 class="text-muted mb-3">Chi Tiết Sản Phẩm</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-sm">
                        <thead class="table-light">
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Áo Khoác Nam</td>
                            <td>1</td>
                            <td>500,000đ</td>
                            <td>500,000đ</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <hr/>

                <div class="row text-end">
                    <div class="col-md-8"></div>
                    <div class="col-md-4">
                        <p class="mb-1">Tổng: <strong>500,000đ</strong></p>
                        <p class="mb-1">Phí vận chuyển: <strong>0đ</strong></p>
                        <p class="mb-0 fw-bold">Tổng Cộng: 500,000đ</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script src="js/admin-common.js"></script>
<script src="js/admin-dashboard.js"></script>
<script src="js/admin_Orders.js"></script>
</body>
</html>
