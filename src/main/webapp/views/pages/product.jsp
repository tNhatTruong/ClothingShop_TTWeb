<%@ page import="com.clothingshop.styleera.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                                <c:forEach items="${p.subCategories}" var="s">
                                    <li class="${param.cateId == s.id ? 'active' : ''}">
                                        <a href="${root}/product?cateId=${s.id}">${s.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>

                    <hr>
                    <div class="filter-section">
                        <h6>Giá</h6>
                        <ul>
                            <li><input type="checkbox"> Dưới 200.000</li>
                            <li><input type="checkbox"> 200.000 – 500.000</li>
                            <li><input type="checkbox"> Trên 500.000</li>
                        </ul>
                    </div>
                    <hr>
                    <div class="filter-section">
                        <h6>Kích thước</h6>
                        <div class="size-list" style="display: flex; flex-wrap: wrap; gap: 5px;">
                            <c:forEach items="${listSizes}" var="size">
                                <a href="#" class="btn btn-outline-secondary btn-sm"
                                   style="min-width: 35px;">${size}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <hr>
                    <div class="filter-section">
                        <h6>Màu sắc</h6>
                        <ul class="color-list" style="list-style: none; padding: 0;">
                            <c:forEach items="${listColors}" var="color">
                                <li style="margin-bottom: 5px;">
                                    <input type="checkbox"> ${color}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </aside>

            <section class="col-lg-9 col-md-8">

                <h2 class="category-title" id="category-title">
                    ${requestScope.categoryTitle != null ? requestScope.categoryTitle : 'Tất cả sản phẩm'}
                </h2>

                <div class="sort-bar d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Hiển thị trang ${currentPage} / ${totalPages}</span>
                    <select class="form-select w-auto" onchange="location = this.value;">
                        <option value="${root}/product" ${empty currentSort ? 'selected' : ''}>Mặc định</option>
                        <option value="${root}/product?sort=newest" ${currentSort == 'newest' ? 'selected' : ''}>Hàng mới về</option>
                        <option value="${root}/product?sort=bestseller" ${currentSort == 'bestseller' ? 'selected' : ''}>Sản phẩm bán chạy</option>
                        <option value="${root}/product?sort=price_asc" ${currentSort == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                        <option value="${root}/product?sort=price_desc" ${currentSort == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
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
                            <a href="${root}/product_detail?id=<%=p.getProduct_id()%>"
                               class="product-card-link">
                                <div class="product-image">
                                    <span class="product-badge badge-new">NEW</span>
                                    <img src="<%= imgPath %>" alt="<%=p.getProduct_name()%>">
                                </div>
                                <div class="product-info">
                                    <h5 class="product-name"><%=p.getProduct_name()%></h5>
                                    <p class="product-price"><%=String.format("%,.0f", p.getPrice())%> VNĐ</p>
                                </div>
                            </a>
                            <div class="product-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <button class="btn-cart" type="button"
                                    <%= p.getDefaultVariantId() == null ? "disabled" : "" %>
                                    onclick="addToCart(<%= p.getDefaultVariantId() %>)">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
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

                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-5">
                        <ul class="pagination justify-content-center">

                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&cateId=${currentCate}&parentId=${currentParent}&sort=${currentSort}&search=${currentSearch}" aria-label="Next">
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

<jsp:include page="/views/layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>
<script src="${root}/js/add-cart.js"></script>
<script src="${root}/js/main.js"></script>

</body>
</html>