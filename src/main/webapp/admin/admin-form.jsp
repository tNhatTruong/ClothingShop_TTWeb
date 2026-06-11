<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Thêm/Chỉnh Sửa Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/admin/css/admin.css"/>
</head>

<body>
<c:set var="currentPage" value="products" scope="request"/>
<%@ include file="/admin/layout/Layoutadmin.jsp" %>

<main class="admin-content">
    <div class="page-header mb-5">
        <div>
            <h1 class="page-title" id="pageTitle">Thêm Sản Phẩm</h1>
        </div>
        <div class="page-actions">
            <a href="${root}/admin-products" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>
    </div>

    <c:set var="isEdit" value="${not empty product}" />
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
                            <input type="hidden" name="productId" value="${product.product_id}" />
                            <input type="hidden" name="variantId" value="${variant.variantId}" />
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên Sản Phẩm</label>
                            <input type="text"
                                   class="form-control"
                                   name="productName"
                                   placeholder="Nhập tên sản phẩm"
                                   value="${isEdit ? product.product_name : ''}"
                                   required/>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label fw-bold">Danh Mục</label>
                                <select class="form-select" name="subCategoryId" required>
                                    <option value="">-- Chọn Danh Mục --</option>
                                    <c:forEach items="${parents}" var="p">
                                        <optgroup label="${p.name}">
                                            <c:forEach items="${p.subCategories}" var="sub">
                                                <option value="${sub.id}" ${isEdit && product.subcategory.id == sub.id ? 'selected' : ''}>
                                                        ${sub.name} (ID: ${sub.id})
                                                </option>
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả ngắn</label>
                            <textarea class="form-control"
                                      name="short_desc"
                                      rows="2"
                                      placeholder="Nhập mô tả ngắn"
                                      required>${isEdit ? product.short_description : ''}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả chi tiết</label>
                            <textarea class="form-control"
                                      name="detail_desc"
                                      rows="4"
                                      placeholder="Nhập mô tả chi tiết sản phẩm"
                                      required>${isEdit ? product.detail_description : ''}</textarea>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Ảnh Sản Phẩm</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Chọn Ảnh</label>
                            <input type="file"
                                   class="form-control"
                                   id="productImages"
                                   name="image"
                                   accept="image/*"
                                   form="productForm"
                            ${!isEdit ? 'required' : ''}/>
                            <div class="form-text">
                                Chọn 1 hoặc nhiều ảnh (JPG, PNG) ${isEdit ? '(để trống nếu không thay đổi)' : ''}
                            </div>
                            <c:if test="${isEdit && not empty product.thumbnail}">
                                <div class="mt-3 current-img-box">
                                    <p class="fw-bold mb-2">Ảnh hiện tại:</p>
                                    <img src="${root}${product.thumbnail}" alt="${product.product_name}" style="max-width: 200px; border-radius: 4px;">
                                </div>
                            </c:if>
                            <div id="imgPreview" class="d-flex flex-column gap-2 mt-3"></div>
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
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Giá Bán (đ)</label>
                                <input type="number"
                                       class="form-control"
                                       name="price"
                                       placeholder="0"
                                       min="0"
                                       value="${isEdit ? product.price : ''}"
                                       required/>
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label fw-bold">Size</label>
                                <input type="text"
                                       class="form-control"
                                       name="size"
                                       placeholder="M/L/XL..."
                                       value="${isEdit && not empty product.variants ? product.variants[0].size : ''}"
                                       required/>
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label fw-bold">Màu</label>
                                <input type="text"
                                       class="form-control"
                                       name="color"
                                       placeholder="Đen/Trắng..."
                                       value="${isEdit && not empty product.variants ? product.variants[0].color : ''}"
                                       required/>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số Lượng Kho</label>
                                <input type="number"
                                       class="form-control"
                                       name="quantity"
                                       placeholder="0"
                                       min="0"
                                       value="${isEdit && not empty product.variants ? product.variants[0].quantity : ''}"
                                       required/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light border-bottom">
                        <h6 class="mb-0">Lưu ý</h6>
                    </div>
                    <div class="card-body">
                        <input type="hidden" name="image_name" value="" />
                        <input type="hidden" name="image_path" value="" />

                        <div class="alert alert-info mb-0">
                            Bạn chỉ cần <b>chọn ảnh</b> ở khung bên phải. Hệ thống sẽ tự tạo <code>image_path</code>.
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div style="display: flex; justify-content: center; align-items: center; gap: 15px; margin-top: 25px; margin-bottom: 50px;">
            <button type="submit" form="productForm" class="btn btn-primary btn-lg" style="min-width: 200px;">
                <i class="fas fa-save"></i>
                <c:choose>
                    <c:when test="${isEdit}">Cập Nhật Sản Phẩm</c:when>
                    <c:otherwise>Thêm Sản Phẩm</c:otherwise>
                </c:choose>
            </button>
            <a href="${root}/admin-products" class="btn btn-secondary btn-lg" style="min-width: 200px;">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>

    </form>
</main>
<footer class="bg-dark text-white py-3">
    <div class="container-fluid text-center">
        <p class="mb-0">&copy; 2025 StyleEra Admin. All rights reserved.</p>
    </div>
</footer>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Xử lý form submit và redirect
    document.getElementById('productForm').addEventListener('submit', function(e) {
        // Cho phép form submit tới server
        // Servlet sẽ xử lý và redirect tự động về admin-products.jsp
    });

    // Xử lý sự kiện change ảnh và live preview
    document.getElementById('productImages').addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            document.querySelector('input[name="image_name"]').value = file.name;
            document.querySelector('input[name="image_path"]').value = "/images/" + file.name;

            const previewContainer = document.getElementById('imgPreview');
            previewContainer.innerHTML = '';

            // Tự động ẩn khối ảnh cũ đi khi admin chọn một ảnh mới từ máy tính
            const oldImgBox = document.querySelector('.current-img-box');
            if(oldImgBox) {
                oldImgBox.style.display = 'none';
            }

            const previewTitle = document.createElement('p');
            previewTitle.className = 'fw-bold mb-2 text-primary';
            previewTitle.innerHTML = '<i class="fas fa-eye me-1"></i> Ảnh xem trước:';

            const img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            img.style.maxWidth = '100%';
            img.style.maxHeight = '250px';
            img.style.borderRadius = '8px';
            img.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
            img.className = 'border border-light';

            previewContainer.appendChild(previewTitle);
            previewContainer.appendChild(img);
        }
    });
</script>
</body>
</html>