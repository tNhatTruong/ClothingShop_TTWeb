<%@ page import="com.clothingshop.styleera.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Danh sách sản phẩm</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/product.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

</head>

<body>
<%
    // Lấy danh sách sản phẩm từ Controller
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<jsp:include page="/views/layout/header.jsp"/>

<main class="product-page">
    <div class="container">

        <nav aria-label="breadcrumb" class="mt-3 mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${root}/home">Trang Chủ</a></li>
                <li class="breadcrumb-item active" id="breadcrumb-category">
                    ${requestScope.categoryTitle != null ? requestScope.categoryTitle : 'Danh mục'}
                </li>
            </ol>
        </nav>

        <div class="row">
            <aside class="col-lg-3 col-md-4">
                <div class="filter-box">
                    <button type="button" class="btn-close-sidebar d-md-none" onclick="toggleSidebar()">
                        <i class="fas fa-times"></i>
                    </button>
                    <h5 class="filter-title">
                        <a href="${root}/product" style="text-decoration: none; color: inherit;">
                            <i class="fas fa-list-ul"></i> Tất cả sản phẩm
                        </a>
                    </h5>

                    <c:forEach items="${parents}" var="p">
                        <div class="filter-section">
                            <h6>
                                <a href="${root}/product?parentId=${p.id}"
                                   style="text-decoration: none; color: inherit; font-weight: bold;">
                                        ${p.name}
                                </a>
                            </h6>
                            <ul>
                                <c:forEach items="${p.subCategories}" var="s" varStatus="status">
                                    <li class="${param.cateId == s.id ? 'active' : ''}
                           ${status.index >= 4 ? 'hidden-sub' : ''}">
                                        <a href="${root}/product?cateId=${s.id}">${s.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>

                            <c:if test="${fn:length(p.subCategories) > 4}">
                                <a href="#" class="toggle-sub float-end">
                                    Xem thêm (${fn:length(p.subCategories) - 4})
                                    <i class="bi bi-chevron-down"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:forEach>

                    <hr>
                    <div class="filter-section">
                        <h5>Giá</h5>
                        <form id="priceFilterForm" action="product" method="get">
                            <!-- Giữ cateId hoặc parentId nếu có -->
                            <c:if test="${not empty currentCate}">
                                <input type="hidden" name="cateId" value="${currentCate}" />
                            </c:if>
                            <c:if test="${not empty currentParent}">
                                <input type="hidden" name="parentId" value="${currentParent}" />
                            </c:if>

                            <c:if test="${not empty currentSort}">
                                <input type="hidden" name="sort" value="${currentSort}" />
                            </c:if>
                            <c:if test="${not empty currentSearch}">
                                <input type="hidden" name="search" value="${currentSearch}" />
                            </c:if>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="priceRange" value="1"
                                       id="priceRange1" ${currentPriceRange == '1' ? 'checked' : ''}>
                                <label class="form-check-label" for="priceRange1">Dưới 200.000</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="priceRange" value="2"
                                       id="priceRange2" ${currentPriceRange == '2' ? 'checked' : ''}>
                                <label class="form-check-label" for="priceRange2">200.000 - 500.000</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="priceRange" value="3"
                                       id="priceRange3" ${currentPriceRange == '3' ? 'checked' : ''}>
                                <label class="form-check-label" for="priceRange3">Trên 500.000</label>
                            </div>
                        </form>
                    </div>
                    <hr>
                    <div class="filter-section">
                        <h6>Kích thước</h6>
                        <div class="size-list" style="display: flex; flex-wrap: wrap; gap: 5px;">
                            <c:forEach items="${listSizes}" var="size" varStatus="status">
                                <a href="#" class="btn btn-outline-secondary btn-sm ${status.index >= 4 ? 'hidden-size' : ''}">
                                        ${size}
                                </a>
                            </c:forEach>
                            <c:if test="${fn:length(listSizes) > 4}">
                                <a href="#" class="toggle-size float-end">
                                    Xem thêm (${fn:length(listSizes) - 4})
                                    <i class="bi bi-chevron-down"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                    <hr>
                    <div class="filter-section">
                        <h6>Màu sắc</h6>
                        <ul class="color-list" style="list-style:none; padding:0;">
                            <c:forEach items="${listColors}" var="color" varStatus="status">
                                <li class="${status.index >= 4 ? 'hidden-color' : ''}" style="margin-bottom:5px;">
                                    <input type="checkbox"> ${color}
                                </li>
                            </c:forEach>
                        </ul>
                        <c:if test="${fn:length(listColors) > 4}">
                            <a href="#" class="toggle-color float-end">
                                Xem thêm (${fn:length(listColors) - 4})
                                <i class="bi bi-chevron-down"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
            </aside>

            <section class="col-lg-9 col-md-8">
                <button class="filter-toggle-btn" onclick="toggleSidebar()">
                    <i class="fas fa-filter"></i> Bộ lọc sản phẩm
                </button>

                <h2 class="category-title" id="category-title">
                    ${requestScope.categoryTitle != null ? requestScope.categoryTitle : 'Tất cả sản phẩm'}
                </h2>

                <div class="filter-overlay" id="filterOverlay" onclick="toggleSidebar()"></div>
                <div class="sort-bar d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Hiển thị trang ${currentPage} / ${totalPages}</span>
                    <select class="form-select w-auto" onchange="updateSort(this.value)">
                        <option value="" ${empty param.sort ? 'selected' : ''}>Mặc định</option>
                        <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Hàng mới về</option>
                        <option value="bestseller" ${param.sort == 'bestseller' ? 'selected' : ''}>Sản phẩm bán chạy</option>
                        <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                        <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                    </select>
                </div>

                <div class="row g-3" id="product-list">
                    <%
                        if (products != null && !products.isEmpty()) {
                            for (Product p : products) {
                                String imgPath = (p.getThumbnail() != null)
                                        ? request.getContextPath() + p.getThumbnail()
                                        : request.getContextPath() + "/images/no-image.png";
                    %>
                    <div class="col-lg-4 col-md-6 col-6">
                        <div class="product-card">
                            <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" class="product-card-link">
                                <div class="product-image">
                                    <span class="product-badge badge-new">NEW</span>
                                    <img src="<%= imgPath %>" alt="<%=p.getProduct_name()%>" loading="lazy">
                                </div>
                            </a>
                            <div class="product-details">
                                <div class="product-info">
                                    <a href="${root}/product_detail?id=<%=p.getProduct_id()%>" style="text-decoration: none;">
                                        <h4 class="product-name"><%=p.getProduct_name()%></h4>
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
                    </div>
                    <% }
                    } else {
                    %>
                    <div class="col-12 text-center mt-5">
                        <p class="text-muted">Không tìm thấy sản phẩm nào trong danh mục này.</p>
                    </div>
                    <% } %>
                </div>

                <c:if test="${totalPages >= 1}">
                    <nav aria-label="Page navigation" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}&priceRange=${currentPriceRange}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}&priceRange=${currentPriceRange}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}&priceRange=${currentPriceRange}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </section>
        </div>
    </div>
</main>

<%--Hiển thị thông báo thêm vào giỏ hàng--%>
<c:if test="${not empty sessionScope.successMsg}">
    <div id="successAlert" class="alert alert-success alert-dismissible fade show position-fixed top-0 end-0 m-4"
         role="alert" style="z-index: 9999;">
        <i class="fa-solid fa-circle-check"></i>
            ${sessionScope.successMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="successMsg" scope="session"/>
</c:if>

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
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>
<script src="${root}/js/add-cart.js?v=<%= System.currentTimeMillis() %>"></script>
<script src="${root}/js/main.js"></script>
<script>
    function toggleSidebar() {
        const sidebar = document.querySelector('.filter-box');
        const overlay = document.getElementById('filterOverlay');

        sidebar.classList.toggle('show');
        overlay.classList.toggle('active');

        // Ngăn chặn cuộn trang phía sau khi đang mở bộ lọc
        if (sidebar.classList.contains('show')) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = 'auto';
        }
    }
    document.querySelectorAll('#priceFilterForm input[name="priceRange"]').forEach(function(el) {
        el.addEventListener('change', function() {
            document.getElementById('priceFilterForm').submit();
        });
    });
    document.addEventListener("DOMContentLoaded", function() {
        function setupToggle(toggleClass, hiddenClass) {
            const cleanClassName = hiddenClass.replace('.', '');
            const expandedClassName = cleanClassName + '-expanded';
            const selector = hiddenClass + ', .' + expandedClassName;

            document.querySelectorAll(toggleClass).forEach(function(toggle) {
                toggle.addEventListener("click", function(e) {
                    e.preventDefault();
                    const parent = toggle.closest(".filter-section");
                    const items = parent.querySelectorAll(selector);
                    if (items.length === 0) return;

                    const isHidden = items[0].classList.contains(cleanClassName);

                    items.forEach(function(el) {
                        if (isHidden) {
                            el.classList.remove(cleanClassName);
                            el.classList.add(expandedClassName);
                        } else {
                            el.classList.remove(expandedClassName);
                            el.classList.add(cleanClassName);
                        }
                    });

                    const totalItems = items.length;
                    if (isHidden) {
                        toggle.innerHTML = 'Thu gọn <i class="bi bi-chevron-up"></i>';
                    } else {
                        toggle.innerHTML = 'Xem thêm (' + totalItems + ') <i class="bi bi-chevron-down"></i>';
                    }
                });
            });
        }

        setupToggle(".toggle-sub", ".hidden-sub");
        setupToggle(".toggle-size", ".hidden-size");
        setupToggle(".toggle-color", ".hidden-color");

    });
    function updateSort(sortValue) {
        const url = new URL(window.location.href);
        if (sortValue) {
            url.searchParams.set('sort', sortValue);
        } else {
            url.searchParams.delete('sort');
        }
        url.searchParams.set('page', '1');
        window.location.href = url.toString();
    }
</script>
</body>
</html>