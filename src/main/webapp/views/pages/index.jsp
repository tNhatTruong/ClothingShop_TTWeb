<%@ page import="com.clothingshop.styleera.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

<c:if test="${not empty sessionScope.successMsg}">
    <div id="successAlert" class="alert alert-success alert-dismissible fade show position-fixed top-0 end-0 m-4"
         role="alert" style="z-index: 9999;">
        <i class="fa-solid fa-circle-check"></i>
            ${sessionScope.successMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

    <c:remove var="successMsg" scope="session"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Thời Trang Cho Mọi Người</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/style.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
</head>

<body>
<jsp:include page="/views/layout/header.jsp"/>

<main class="main-content">
    <section class="hero-section">
        <div class="hero-slider">
            <div class="hero-slide active">
                <img src="${root}/images/slide/slide-01.jpg" alt="Fashion Banner 1">
            </div>
            <div class="hero-slide">
                <img src="${root}/images/slide/slide-02.jpg" alt="Fashion Banner 2">
            </div>
        </div>
        <div class="hero-overlay">
            <div class="hero-content">
                <h1>Định Nghĩa Phong Cách Của Bạn</h1>
                <p>Khám phá bộ sưu tập thời trang hiện đại - Nơi phong cách gặp gỡ sự tự tin</p>
                <div class="hero-buttons">
                    <a href="#collections" class="btn-hero btn-hero-primary">Khám Phá Ngay</a>
                    <a href="#new-arrivals" class="btn-hero btn-hero-secondary">Hàng Mới Về</a>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <h3>Miễn Phí Vận Chuyển</h3>
                <p>Giao hàng miễn phí cho đơn hàng trên 500.000đ</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-undo-alt"></i>
                </div>
                <h3>Đổi Trả Dễ Dàng</h3>
                <p>Đổi trả trong vòng 30 ngày miễn phí</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3>Thanh Toán An Toàn</h3>
                <p>Bảo mật thông tin với công nghệ mã hóa</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3>Hỗ Trợ 24/7</h3>
                <p>Đội ngũ chăm sóc khách hàng luôn sẵn sàng</p>
            </div>
        </div>
    </section>

    <section id="new-arrivals" class="products-section">
        <div class="products-container">
            <div class="section-header">
                <h2>Hàng Mới Về</h2>
                <p>Cập nhật những xu hướng thời trang mới nhất</p>
            </div>
            <div class="products-grid">
                <%
                    List<Product> newArrivals = (List<Product>) request.getAttribute("newArrivals");
                    if (newArrivals != null) {
                        for (Product p : newArrivals) {
                            String imgPath = (p.getThumbnail() != null) ? request.getContextPath() + p.getThumbnail() : request.getContextPath() + "/images/no-image.png";
                %>
                <div class="product-card">
                    <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" class="product-card-link">
                        <div class="product-image">
                            <span class="product-badge badge-new">NEW</span>
                            <img src="<%=imgPath%>" alt="<%=p.getProduct_name()%>" loading="lazy">
                        </div>
                    </a>

                    <div class="product-details">
                        <div class="product-info">
                            <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" style="text-decoration: none;">
                                <h4><%=p.getProduct_name()%></h4>
                            </a>

                            <div class="product-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>

                        <div class="product-bottom">
                            <div class="product-price">
                                <span class="price"><%=String.format("%,.0f", p.getPrice())%>₫</span>
                            </div>

                            <button class="btn-cart" type="button" title="Chọn phân loại"
                                    onclick="openQuickView(<%= p.getProduct_id() %>, '<%= p.getProduct_name().replace("'", "\\'") %>', <%= p.getPrice() %>, '<%= imgPath %>')">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <% }
                }
                %>
            </div>
            <div class="section-footer">
                <a href="${root}/product?sort=newest" class="btn-view-all">Xem Tất Cả</a>
            </div>
        </div>
    </section>

    <section class="products-section bg-light">
        <div class="products-container">
            <div class="section-header">
                <h2>Sản Phẩm Bán Chạy</h2>
                <p>Những sản phẩm được yêu thích nhất</p>
            </div>
            <div class="products-grid">
                <%
                    List<Product> bestSellers = (List<Product>) request.getAttribute("bestSellers");
                    if (bestSellers != null && !bestSellers.isEmpty()) {
                        for (Product p : bestSellers) {
                            String imgPath = (p.getThumbnail() != null)
                                    ? request.getContextPath() + p.getThumbnail()
                                    : request.getContextPath() + "/images/no-image.png";
                %>
                <div class="product-card">
                    <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" class="product-card-link">
                        <div class="product-image">
                            <span class="product-badge badge-bestseller">BEST SELLER</span>
                            <img src="<%=imgPath%>" alt="<%=p.getProduct_name()%>" loading="lazy">
                        </div>
                    </a>

                    <div class="product-details">
                        <div class="product-info">
                            <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" style="text-decoration: none;">
                                <h4><%=p.getProduct_name()%></h4>
                            </a>

                            <div class="product-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>

                        <div class="product-bottom">
                            <div class="product-price">
                                <span class="price"><%=String.format("%,.0f", p.getPrice())%>₫</span>
                            </div>

                            <button class="btn-cart" type="button" title="Chọn phân loại"
                                    onclick="openQuickView(<%= p.getProduct_id() %>, '<%= p.getProduct_name().replace("'", "\\'") %>', <%= p.getPrice() %>, '<%= imgPath %>')">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <% }
                } else {
                %>
                <p class="text-center">Đang cập nhật sản phẩm bán chạy...</p>
                <% } %>
            </div>
            <div class="section-footer">
                <a href="${root}/product?sort=bestseller" class="btn-view-all">Xem Tất Cả</a>
            </div>
        </div>
    </section>

    <section id="collections" class="collections-section">
        <div class="section-header">
            <h2>Bộ Sưu Tập Nổi Bật</h2>
            <p>Khám phá các bộ sưu tập thời trang được yêu thích nhất</p>
        </div>
        <div class="collections-grid">
            <div class="collection-card">
                <img src="${root}/images/category-banner/banner/male-fashion.jpg" alt="Thời trang nam">
                <div class="collection-overlay">
                    <h3>Thời Trang Nam</h3>
                    <p>Phong cách lịch lãm - Năng động - Cá tính</p>
                    <a href="${root}/product?parentId=1" class="collection-link">
                        Khám Phá <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <div class="collection-card">
                <img src="${root}/images/category-banner/banner/female-fashion.jpg" alt="Thời trang nữ">
                <div class="collection-overlay">
                    <h3>Thời Trang Nữ</h3>
                    <p>Thanh lịch - Tinh tế - Quyến rũ</p>
                    <a href="${root}/product?parentId=2" class="collection-link">
                        Khám Phá <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="categories-section">
        <div class="categories-container">

            <c:if test="${not empty parents}">
                <c:forEach items="${parents}" var="p">
                    <div class="category-group">
                        <div class="category-group-header">
                            <div class="category-icon ${p.id == 1 ? 'male' : (p.id == 2 ? 'female' : 'couple')}">
                                <i class="fas ${p.id == 1 ? 'fa-mars' : (p.id == 2 ? 'fa-venus' : 'fa-heart')}"></i>
                            </div>
                            <h2>Thời Trang ${p.name}</h2>
                        </div>

                        <div class="category-items-grid">
                            <c:if test="${not empty p.subCategories}">
                                <c:forEach items="${p.subCategories}" var="sub">
                                    <c:set var="categoryImg" value="${not empty sub.image ? sub.image : '/images/no-image.png'}"/>
                                    <a href="${root}/product?cateId=${sub.id}" class="category-item-card">
                                        <div class="category-item-image">
                                            <img src="${root}${categoryImg}"
                                                 alt="${sub.name}" loading="lazy">
                                        </div>
                                        <div class="category-item-content">
                                            <h4>${sub.name}</h4>
                                            <p>${sub.description}</p>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty p.subCategories}">
                                <p class="text-center">Đang cập nhật danh mục...</p>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty parents}">
                <p class="text-center">Đang cập nhật danh mục sản phẩm...</p>
            </c:if>

        </div>
    </section>
</main>

<div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="quickViewModalLabel">Chọn phân loại sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex gap-3 mb-3">
                    <img id="qv-product-img" src="" alt="" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px;">
                    <div>
                        <h6 id="qv-product-name" class="fw-bold mb-1"></h6>
                        <p id="qv-product-price" class="text-danger fw-bold mb-0"></p>
                    </div>
                </div>

                <div class="mb-3">
                    <span class="d-block fw-semibold mb-2">Màu sắc:</span>
                    <div id="qv-color-container" class="d-flex flex-wrap gap-2">
                    </div>
                </div>

                <div class="mb-3">
                    <span class="d-block fw-semibold mb-2">Kích cỡ (Size):</span>
                    <div id="qv-size-container" class="d-flex flex-wrap gap-2">
                    </div>
                </div>

                <div class="mb-3">
                    <span class="d-block fw-semibold mb-2">Số lượng:</span>
                    <div class="input-group" style="width: 130px;">
                        <button class="btn btn-outline-secondary" type="button" id="qv-btn-decrease">-</button>
                        <input type="text" id="qv-quantity" class="form-control text-center" value="1" readonly>
                        <button class="btn btn-outline-secondary" type="button" id="qv-btn-increase">+</button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="button" id="qv-btn-add-to-cart" class="btn btn-primary" disabled>Thêm vào giỏ hàng</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="${root}/js/main.js"></script>
<script src="${root}/js/home.js"></script>
<script src="${root}/js/add-cart.js?v=<%= System.currentTimeMillis() %>"></script>
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>
</body>
</html>