<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Quản lý bình luận</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>
<body>

<c:set var="currentPage" value="comment" scope="request"/>
<!-- ===== HEADER ===== -->
<%@ include file="/admin/layout/Layoutadmin.jsp" %>
<main class="admin-content">
    <!-- Page Header -->
    <div class="page-header mb-5">
        <div>
            <h1 class="page-title">Quản lý Bình Luận</h1>
        </div>
    </div>
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form action="${root}/admin-reviews" method="GET" class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label class="form-label">Tìm Kiếm</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Tên tài khoản"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Phân loại đánh giá</label>
                    <select class="form-select" name="ratingFilter" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <option value="good" ${param.ratingFilter == 'good' ? 'selected' : ''}>Tốt (4 - 5 sao)</option>
                        <option value="average" ${param.ratingFilter == 'average' ? 'selected' : ''}>Trung bình (3 - 4 sao)</option>
                        <option value="bad" ${param.ratingFilter == 'bad' ? 'selected' : ''}>Tệ (1 - 3 sao)</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Ngày Bình luận</label>
                    <select class="form-select" name="dateSort" onchange="this.form.submit()">
                        <option value="newest" ${param.dateSort == 'newest' ? 'selected' : ''}>Bình luận mới nhất</option>
                        <option value="oldest" ${param.dateSort == 'oldest' ? 'selected' : ''}>Bình luận cũ nhất</option>
                    </select>
                </div>
            </form>
        </div>
    </div>
    <div>
        <div class="tab-pane">
            <div class="card shadow-sm">
                <div class="card-header bg-light border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Danh Sách Bình Luận</h6>
                    <span class="text-muted small">Tổng cộng: <strong>${totalReviews}</strong> Bình luận</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Sản phẩm</th>
                                <th>Người dùng</th>
                                <th>Đánh giá</th>
                                <th>Nội dung</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${reviewList}">
                                <tr>
                                    <td>#${item.id}</td>

                                    <td>Mã SP: ${item.productId}</td>

                                    <td><strong>${item.fullName}</strong></td>

                                    <td>
                                        <div class="text-warning">
                                            <c:forEach begin="1" end="${item.rating}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${item.rating + 1}" end="5">
                                                <i class="far fa-star"></i>
                                            </c:forEach>
                                        </div>
                                    </td>

                                    <td style="max-width: 250px;" class="text-truncate" title="${item.comment}">
                                            ${item.comment}
                                        <c:if test="${item.editCount > 0}">
                                            <br><small class="text-muted">(Đã chỉnh sửa)</small>
                                        </c:if>
                                    </td>
                                    
                                    <td style="max-width: 200px;" class="text-truncate" title="${item.adminReply}" id="reply-status-${item.id}">
                                        <c:choose>
                                            <c:when test="${not empty item.adminReply}">
                                                <span class="text-success"><i class="fas fa-check-circle"></i> Đã trả lời</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-secondary"><i class="fas fa-clock"></i> Chưa trả lời</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>

                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" id="btn-reply-${item.id}" onclick="openReplyModal('${item.id}', '${item.fullName}', '${item.adminReply}')">
                                            <i class="fas fa-reply"></i> ${not empty item.adminReply ? 'Sửa trả lời' : 'Trả lời'}
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Reply Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="replyModalLabel"><i class="fas fa-reply me-2"></i>Trả lời bình luận</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form onsubmit="submitReplyForm(event)">
                <div class="modal-body">
                    <p class="mb-3">Đang trả lời người dùng: <strong id="replyUserName"></strong></p>
                    <input type="hidden" name="reviewId" id="replyReviewId">
                    <div class="mb-3">
                        <label for="adminReplyText" class="form-label fw-medium">Nội dung phản hồi:</label>
                        <textarea class="form-control" name="adminReply" id="adminReplyText" rows="4" placeholder="Nhập câu trả lời của Người bán..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Gửi phản hồi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100; margin-top: 60px;">
    <div id="liveToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body fw-medium" id="toastMessage">
                <i class="fas fa-check-circle me-2"></i> Thành công!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openReplyModal(reviewId, userName, currentReply) {
        document.getElementById('replyReviewId').value = reviewId;
        document.getElementById('replyUserName').textContent = userName;
        document.getElementById('adminReplyText').value = currentReply && currentReply !== 'null' ? currentReply : '';
        
        const modal = new bootstrap.Modal(document.getElementById('replyModal'));
        modal.show();
    }

    function submitReplyForm(event) {
        event.preventDefault();
        const form = event.target;
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerText;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang gửi...';
        submitBtn.disabled = true;

        const formData = new FormData(form);
        formData.append("ajax", "true");
        
        fetch('${root}/admin-reviews', {
            method: 'POST',
            body: new URLSearchParams(formData)
        })
        .then(res => res.json())
        .then(data => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            
            if(data.status === 'success') {
                const modal = bootstrap.Modal.getInstance(document.getElementById('replyModal'));
                modal.hide();
                
                // Hiển thị toast
                document.getElementById('toastMessage').innerHTML = '<i class="fas fa-check-circle me-2"></i> ' + data.message;
                const toast = new bootstrap.Toast(document.getElementById('liveToast'));
                toast.show();
                
                // Cập nhật DOM
                const reviewId = document.getElementById('replyReviewId').value;
                const replyText = document.getElementById('adminReplyText').value;
                
                const statusTd = document.getElementById('reply-status-' + reviewId);
                if (statusTd) {
                    statusTd.title = replyText;
                    statusTd.innerHTML = '<span class="text-success"><i class="fas fa-check-circle"></i> Đã trả lời</span>';
                }
                
                const btn = document.getElementById('btn-reply-' + reviewId);
                if (btn) {
                    btn.innerHTML = '<i class="fas fa-reply"></i> Sửa trả lời';
                    btn.setAttribute('onclick', "openReplyModal('" + reviewId + "', '" + document.getElementById('replyUserName').textContent + "', '" + replyText.replace(/'/g, "\\'") + "')");
                }
            } else {
                alert(data.message);
            }
        }).catch(err => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            alert("Có lỗi kết nối xảy ra!");
        });
    }
</script>
</body>
</html>
