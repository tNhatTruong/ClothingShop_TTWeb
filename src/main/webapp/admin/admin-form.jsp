<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Chỉnh Sửa Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
    <style>
        .img-wrapper { position: relative; display: inline-block; margin-top: 10px; }
        .btn-remove-img { position: absolute; top: -10px; right: -10px; background: #dc3545; color: white; border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; cursor: pointer; border: 2px solid white; font-size: 12px; }
        .variant-row { align-items: flex-end; }
    </style>
</head>

<body>
<c:set var="currentPage" value="products" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

<main class="admin-content">
    <c:set var="isEdit" value="${not empty product}" />

    <div class="page-header mb-5">
        <div>
            <h1 class="page-title" id="pageTitle">
                <c:choose>
                    <c:when test="${isEdit}">Chỉnh Sửa Sản Phẩm</c:when>
                    <c:otherwise>Thêm Sản Phẩm</c:otherwise>
                </c:choose>
            </h1>
        </div>
        <div class="page-actions">
            <a href="${root}/admin-products" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>
    </div>

    <form id="productForm"
          action="${isEdit ? root.concat('/AdminEditProduct') : root.concat('/AdminAddProduct')}"
          method="post"
          enctype="multipart/form-data"
          class="needs-validation"
          novalidate>

        <div class="row">
            <div class="col-lg-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Thông Tin Cơ Bản</h6>
                    </div>
                    <div class="card-body">
                        <c:if test="${isEdit}">
                            <input type="hidden" name="productId" value="${not empty product.product_id ? product.product_id : product.id}" />
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" name="productName" placeholder="Nhập tên sản phẩm" value="${isEdit ? product.product_name : ''}" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Danh Mục</label>
                            <select class="form-select" name="subCategoryId" required>
                                <option value="">-- Chọn Danh Mục --</option>
                                <c:forEach items="${parents}" var="p">
                                    <optgroup label="${p.name}">
                                        <c:forEach items="${p.subCategories}" var="sub">
                                            <option value="${sub.id}" ${isEdit && not empty product.subcategory && product.subcategory.id == sub.id ? 'selected' : ''}>
                                                    ${sub.name} (ID: ${sub.id})
                                            </option>
                                        </c:forEach>
                                    </optgroup>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả ngắn</label>
                            <textarea class="form-control" name="short_desc" rows="2" required>${isEdit ? product.short_description : ''}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả chi tiết</label>
                            <textarea class="form-control" name="detail_desc" rows="4" required>${isEdit ? product.detail_description : ''}</textarea>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Ảnh Sản Phẩm</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Chọn Ảnh Mới (Có thể chọn cùng lúc nhiều ảnh để thêm vào bộ sưu tập)</label>
                            <input type="file" class="form-control" id="productImages" name="images" accept="image/*" multiple ${!isEdit ? 'required' : ''}/>

                            <div id="deletedImagesContainer"></div>

                            <c:if test="${isEdit}">
                                <div class="mt-3" id="currentImgContainer">
                                    <p class="fw-bold mb-2 text-muted">Tất cả ảnh hiện tại của sản phẩm:</p>
                                    <div class="d-flex flex-wrap gap-3">
                                        <c:choose>
                                            <c:when test="${not empty productImages}">
                                                <c:forEach items="${productImages}" var="img">
                                                    <div class="img-wrapper" id="img-block-${img.imageId}">
                                                        <img src="${img.imagePath}" alt="Ảnh sản phẩm" style="width: 110px; height: 110px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd;">
                                                        <span class="btn-remove-img" onclick="markImageAsDeleted(${img.imageId})" title="Xóa ảnh này">
                                <i class="fas fa-times"></i>
                            </span>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-danger fst-italic small">Sản phẩm này hiện chưa có ảnh nào trong bộ sưu tập.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>

                            <p class="fw-bold mb-2 text-primary mt-3 d-none" id="previewLabel">Ảnh mới vừa chọn chọn (Xem trước):</p>
                            <div id="imgPreview" class="d-flex flex-wrap gap-2"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Giá & Biến Thể</h6>
                    </div>
                    <div class="card-body">
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Giá Bán Chung (đ)</label>
                            <input type="number" class="form-control" name="price" value="${isEdit ? product.price : ''}" required/>
                        </div>

                        <label class="form-label fw-bold">Danh sách Biến Thể (Size/Màu)</label>

                        <div id="variantsContainer">
                            <c:choose>
                                <c:when test="${isEdit && not empty product.variants}">
                                    <c:forEach items="${product.variants}" var="v">
                                        <div class="row mb-2 pb-2 border-bottom variant-row align-items-end">
                                            <input type="hidden" name="variantId" value="${v.variantId}" />
                                            <div class="col-md-3 mb-2">
                                                <label class="form-label text-muted small">Size</label>
                                                <input type="text" class="form-control" name="size" value="${v.size}" required/>
                                            </div>
                                            <div class="col-md-3 mb-2">
                                                <label class="form-label text-muted small">Màu</label>
                                                <input type="text" class="form-control" name="color" value="${v.color}" required/>
                                            </div>
                                            <div class="col-md-4 mb-2">
                                                <label class="form-label text-muted small">Số Lượng</label>
                                                <input type="number" class="form-control" name="quantity" value="${v.quantity}" required/>
                                            </div>
                                            <div class="col-md-2 mb-2 text-end">
                                                <button type="button" class="btn btn-outline-danger btn-sm" onclick="removeVariant(this)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="row mb-2 pb-2 border-bottom variant-row align-items-end">
                                        <input type="hidden" name="variantId" value="0" />
                                        <div class="col-md-3 mb-2">
                                            <label class="form-label text-muted small">Size</label>
                                            <input type="text" class="form-control" name="size" placeholder="VD: XL" required/>
                                        </div>
                                        <div class="col-md-3 mb-2">
                                            <label class="form-label text-muted small">Màu</label>
                                            <input type="text" class="form-control" name="color" placeholder="VD: Đỏ" required/>
                                        </div>
                                        <div class="col-md-4 mb-2">
                                            <label class="form-label text-muted small">Số Lượng</label>
                                            <input type="number" class="form-control" name="quantity" placeholder="0" required/>
                                        </div>
                                        <div class="col-md-2 mb-2 text-end">
                                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="removeVariant(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <button type="button" class="btn btn-sm btn-outline-primary mt-2" onclick="addVariant()">
                            <i class="fas fa-plus"></i> Thêm Biến Thể
                        </button>
                    </div>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Lưu ý</h6>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info mb-0">
                            Bạn có thể <b>chọn nhiều ảnh cùng lúc</b>. Hệ thống sẽ tự động tải lên thư mục <code>/images</code> và quản lý bộ sưu tập ảnh của sản phẩm.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: flex; justify-content: center; align-items: center; gap: 15px; margin-top: 25px; margin-bottom: 50px;">
            <button type="submit" class="btn btn-primary btn-lg" style="min-width: 200px;">
                <i class="fas fa-save"></i> ${isEdit ? 'Cập Nhật Sản Phẩm' : 'Thêm Sản Phẩm'}
            </button>
            <a href="${root}/admin-products" class="btn btn-secondary btn-lg" style="min-width: 200px;">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>
    </form>
</main>

<footer class="bg-dark text-white py-3">
    <div class="container-fluid text-center">
        <p class="mb-0">&copy; 2026 StyleEra Admin. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Xử lý xem trước (Preview) khi chọn thêm nhiều file ảnh mới
    document.getElementById('productImages').addEventListener('change', function() {
        const files = this.files;
        const previewContainer = document.getElementById('imgPreview');
        const previewLabel = document.getElementById('previewLabel');
        previewContainer.innerHTML = '';

        if (files && files.length > 0) {
            if(previewLabel) previewLabel.classList.remove('d-none');
            Array.from(files).forEach(file => {
                const imgWrapper = document.createElement('div');
                imgWrapper.className = 'img-wrapper';
                imgWrapper.style.marginRight = '5px';

                const img = document.createElement('img');
                img.src = URL.createObjectURL(file);
                img.style.width = '110px';
                img.style.height = '110px';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '6px';
                img.style.border = '2px solid #0d6efd'; // Viền xanh nhận diện ảnh mới sắp thêm

                imgWrapper.appendChild(img);
                previewContainer.appendChild(imgWrapper);
            });
        } else {
            if(previewLabel) previewLabel.classList.add('d-none');
        }
    });

    // Hàm xử lý xóa ảnh hiện tại
    function markImageAsDeleted(imageId) {
        if(confirm("Bạn có chắc chắn muốn xóa ảnh này khỏi sản phẩm?")) {
            // 1. Ẩn ảnh đó ngay trên giao diện người dùng
            const imgBlock = document.getElementById('img-block-' + imageId);
            if(imgBlock) {
                imgBlock.remove();
            }

            // 2. Tạo một input hidden chứa ID của ảnh bị xóa và append vào form để gửi về Servlet xử lý
            const container = document.getElementById('deletedImagesContainer');
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'deletedImageIds';
            hiddenInput.value = imageId;
            container.appendChild(hiddenInput);
        }
    }

    function addVariant() {
        const container = document.getElementById('variantsContainer');
        const newRow = `
            <div class="row mb-2 pb-2 border-bottom variant-row align-items-end">
                <input type="hidden" name="variantId" value="0" />
                <div class="col-md-3 mb-2">
                    <label class="form-label text-muted small">Size</label>
                    <input type="text" class="form-control" name="size" placeholder="VD: XL" required/>
                </div>
                <div class="col-md-3 mb-2">
                    <label class="form-label text-muted small">Màu</label>
                    <input type="text" class="form-control" name="color" placeholder="VD: Đỏ" required/>
                </div>
                <div class="col-md-4 mb-2">
                    <label class="form-label text-muted small">Số Lượng</label>
                    <input type="number" class="form-control" name="quantity" placeholder="0" required/>
                </div>
                <div class="col-md-2 mb-2 text-end">
                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="removeVariant(this)">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        `;
        container.insertAdjacentHTML('beforeend', newRow);
    }

    function removeVariant(btn) {
        const totalRows = document.querySelectorAll('.variant-row').length;
        if(totalRows <= 1) {
            alert("Sản phẩm phải có ít nhất 1 biến thể (Size/Màu)!");
            return;
        }
        btn.closest('.variant-row').remove();
    }

</script>
</body>
</html>