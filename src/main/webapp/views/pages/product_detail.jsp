<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <c:set var="root" value="${pageContext.request.contextPath}" scope="request" />
            <%@ page import="java.util.List" %>
                <%@ page import="com.clothingshop.styleera.model.Review" %>
                    <%@ page import="com.clothingshop.styleera.model.Product" %>
                        <%@ page import="java.text.SimpleDateFormat" %>

                            <!DOCTYPE html>
                            <html lang="vi">

                            <head>
                                <meta charset="utf-8" />
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>StyleEra - Sản phẩm</title>
                                <link rel="icon" type="image/png" href="${root}/images/logo.png">
                                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                                    rel="stylesheet">
                                <link rel="stylesheet"
                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                                <link rel="stylesheet" href="${root}/css/header-footer.css">
                                <link rel="stylesheet" href="${root}/css/product_detail.css">
                                <link rel="stylesheet" href="${root}/css/style.css">
                            </head>

                            <body>
                                <!-- ===== HEADER ===== -->
                                <jsp:include page="/views/layout/header.jsp" />

                                <!-- ===== MAIN CONTENT ===== -->
                                <main class="main-content">
                                    <!-- Content goes here -->
                                    <div class="product_detail_container">
                                        <div class="product_detail_wrapper">

                                            <!-- LEFT: PRODUCT IMAGES -->
                                            <div class="product_images">
                                                <div class="product_main_image">
                                                    <img id="mainImage" src="${root}${imageList[0]}"
                                                        alt="${product.product_name}">
                                                </div>

                                                <div class="product_thumbs">
                                                    <c:forEach items="${imageList}" var="imgUrl" begin="0" end="1">
                                                        <img src="${root}${imgUrl}" alt="Thumbnail"
                                                            onclick="changeImage('${root}${imgUrl}')"
                                                            style="cursor: pointer;">
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <!-- RIGHT: PRODUCT INFO -->
                                            <div class="product_info">
                                                <h2 class="product_title">${product.product_name}</h2>

                                                <div class="rating">
                                                    <c:forEach begin="0" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= product.medium_rating}">
                                                                <img src="${root}/images/image_product/start.png"
                                                                    alt="star" width="20">
                                                            </c:when>

                                                        </c:choose>
                                                    </c:forEach>

                                                    <span>- Đánh giá ${product.medium_rating}/5</span>
                                                </div>

                                                <h3 class="product_price">
                                                    <fmt:formatNumber value="${product.price}" type="number"
                                                        maxFractionDigits="0" />đ
                                                    <span
                                                        style="text-decoration: line-through; margin-left: 10px; font-size: 0.8em; color: gray;">

                                                    </span>
                                                </h3>

                                                <p class="product_desc">
                                                    ${product.short_description}
                                                </p>

                                                <div class="product_detail_option">
                                                    <form action="${root}/checkout" method="POST" id="checkoutForm">
                                                        <!-- SIZE -->
                                                        <div class="product_detail_size">
                                                            <span>Size:</span>
                                                            <c:forEach items="${sizeList}" var="s" varStatus="status">
                                                                <label
                                                                    class="size-label ${status.first ? 'active' : ''}"
                                                                    onclick="pickSize(this, '${s}')">${s}</label>
                                                            </c:forEach>
                                                        </div>
                                                        <input type="hidden" name="selectedSize" id="finalSize"
                                                            value="${sizeList[0]}">
                                                        <!-- COLOR -->
                                                        <div class="product_detail_color">
                                                            <span>Color:</span>
                                                            <div class="mt-2">
                                                                <c:forEach items="${colorList}" var="c">
                                                                    <button type="button"
                                                                        class="btn btn-outline-secondary btn-sm me-2 color-choice"
                                                                        onclick="pickColor(this, '${c}')">${c}</button>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" name="selectedColor" id="finalColor"
                                                            value="">

                                                        <div class="product_detail_quantity">
                                                            <label for="quantity">Số lượng:</label>
                                                            <button type="button" id="btn-decrease">−</button>
                                                            <input type="number" id="quantity" name="quantity" value="1"
                                                                min="1" readonly>
                                                            <button type="button" id="btn-increase">+</button>
                                                        </div>
                                                        <input type="hidden" name="productName"
                                                            value="${product.product_name}">
                                                        <input type="hidden" name="productImage" id="hiddenProductImage"
                                                            value="${imageList[0]}">
                                                        <input type="hidden" name="productPrice"
                                                            value="${product.price}">
                                                        <input type="hidden" name="selectedSize" id="finalSize"
                                                            value="XL">

                                                        <div class="product_detail_actions" style="margin-top: 25px;">
                                                            <%-- Gom nút vào div riêng để dễ căn chỉnh --%>
                                                                <button type="submit"
                                                                    class="btn btn-primary validate_order">
                                                                    Mua hàng
                                                                </button>
                                                                <%-- Nút thêm vào giỏ hàng--%>
                                                                    <button class="btn btn-primary validate_order"
                                                                        type="button"
                                                                        data-variant-id="${product.defaultVariantId}"
                                                                        onclick="addToCart(this.getAttribute('data-variant-id'))">
                                                                        Thêm vào giỏ hàng
                                                                    </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row_2">
                                        <div class="colum">
                                            <div class="product_detail_tab">
                                                <ul class="nav">
                                                    <li class="nav_item">
                                                        <a class="nav-link active" data-bs-toggle="tab" data-bs-target="#tabs-5" href="javascript:void(0)" style="cursor: pointer;">MÔ TẢ</a>
                                                    </li>

                                                    <li class="nav_item">
                                                        <a class="nav-link" data-bs-toggle="tab" data-bs-target="#tabs-7" href="javascript:void(0)" style="cursor: pointer;">HƯỚNG DẪN CHỌN SIZE & CHÍNH SÁCH</a>
                                                    </li>
                                                </ul>

                                                <div class="tab_content">
                                                    <div class="tab-content">
                                                        <div class="tab-pane fade show active" id="tabs-5" role="tabpanel">
                                                            <div class="product_details_tab_content" id="productDescriptionContent" style="display: none;">${product.detail_description}</div>
                                                            <div class="product_details_tab_content" id="productDescriptionRendered"></div>
                                                        </div>


                                                        <div class="tab-pane fade" id="tabs-7" role="tabpanel">
                                                            <div class="product_details_tab_content">
                                                                <p class="note">Để chọn được sản phẩm vừa vặn nhất, quý khách vui lòng tham khảo bảng hướng dẫn hoặc liên hệ trực tiếp với bộ phận CSKH của StyleEra để được tư vấn chi tiết.</p>
                                                                <div class="product_details_tab_content_item">
                                                                    <h5>HƯỚNG DẪN CHỌN SIZE CƠ BẢN</h5>
                                                                    <p><b>Size S:</b> Cân nặng 45kg - 55kg, Chiều cao 1m50 - 1m60<br>
                                                                       <b>Size M:</b> Cân nặng 55kg - 65kg, Chiều cao 1m60 - 1m68<br>
                                                                       <b>Size L:</b> Cân nặng 65kg - 75kg, Chiều cao 1m68 - 1m75<br>
                                                                       <b>Size XL:</b> Cân nặng 75kg - 85kg, Chiều cao 1m75 - 1m82</p>
                                                                </div>
                                                                <div class="product_details_tab_content_item">
                                                                    <h5>CHÍNH SÁCH VẬN CHUYỂN</h5>
                                                                    <p>- Miễn phí vận chuyển toàn quốc cho đơn hàng từ 500.000 VNĐ.<br>
                                                                       - Giao hàng hỏa tốc trong vòng 2H nội thành TP.HCM.<br>
                                                                       - Các tỉnh thành khác nhận hàng từ 2 - 4 ngày làm việc.</p>
                                                                </div>
                                                                <div class="product_details_tab_content_item">
                                                                    <h5>CHÍNH SÁCH ĐỔI TRẢ</h5>
                                                                    <p>- Hỗ trợ đổi trả trong vòng 7 ngày kể từ khi nhận hàng.<br>
                                                                       - Sản phẩm phải còn nguyên tem mác, chưa qua sử dụng, chưa giặt tẩy.<br>
                                                                       - Miễn phí đổi hàng đối với trường hợp sản phẩm bị lỗi do nhà sản xuất.</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                                    <div class="reviews">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2>ĐÁNH GIÁ SẢN PHẨM</h2>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.currentUser}">
                                                    <button type="button" class="btn btn-dark" data-bs-toggle="modal"
                                                        data-bs-target="#reviewModal">
                                                        <i class="fas fa-pen"></i> Viết đánh giá
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${root}/login" class="btn btn-outline-dark">
                                                        <i class="fas fa-sign-in-alt"></i> Đăng nhập để đánh giá
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="review-container">
                                            <% /* Lấy danh sách đánh giá từ request attribute do Controller gửi sang */
                                                List<Review> reviewList = (List<Review>)
                                                    request.getAttribute("reviewList");

                                                    if (reviewList != null && !reviewList.isEmpty()) {
                                                    /* Định dạng ngày tháng hiển thị theo kiểu năm-tháng-ngày giống form mẫu */
                                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                                    for (Review r : reviewList) {
                                                    String formattedDate = sdf.format(r.getCreatedAt());
                                                    %>
                                                    <div class="item">
                                                        <div class="review-content">
                                                            <div class="item_top">
                                                                <div class="user">
                                                                    <img src="<%= request.getContextPath() %>/images/image_product/user.png"
                                                                        alt="User Avatar">

                                                                    <div class="infos">
                                                                        <p><span class="reviews">
                                                                                <%= r.getFullName() %>
                                                                            </span></p>
                                                                        <p><span class="time">
                                                                                <%= formattedDate %>
                                                                            </span></p>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="review-details">
                                                                <div class="item_mid">
                                                                    <div class="rating">
                                                                        <% /* Vòng lặp hiển thị chuẩn số ngôi sao dựa
                                                                            trên dữ liệu rating (1-5) trong DB */
                                                                            for (int i=0; i < r.getRating(); i++) { %>
                                                                            <img src="<%= request.getContextPath() %>/images/image_product/start.png"
                                                                                alt="star">
                                                                            <% } %>
                                                                    </div>
                                                                </div>

                                                                <div class="item_content">
                                                                    <div class="item-content-main-content">
                                                                        <div class="item-content-main-content-reviews">
                                                                            <div
                                                                                class="item-content-main-content-reviews-item">
                                                                                <span>
                                                                                    <%= r.getComment() %>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } } else { %>
                                                        <div class="col-12 text-center py-5">
                                                            <p class="text-muted" style="font-style: italic;">Sản phẩm
                                                                này chưa có lượt đánh giá nào từ khách hàng.</p>
                                                        </div>
                                                        <% } %>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="reviewModal" tabindex="-1"
                                        aria-labelledby="reviewModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title fw-bold" id="reviewModalLabel">Viết đánh giá
                                                        sản phẩm</h5>
                                                    <button type="button" class="btn btn-dark mb-4"
                                                        data-bs-toggle="modal" data-bs-target="#reviewModal">
                                                        <i class="fas fa-pen"></i> Viết đánh giá
                                                    </button>
                                                </div>

                                                <form action="${root}/submit_review" method="POST">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="productId"
                                                            value="${product.product_id}">
                                                        <input type="hidden" name="rating" id="ratingInput" value="5">

                                                        <div class="mb-4 text-center">
                                                            <label class="form-label d-block mb-2">Chất lượng sản
                                                                phẩm:</label>
                                                            <div class="star-rating-form"
                                                                style="font-size: 2rem; cursor: pointer;">
                                                                <i class="fas fa-star text-warning"
                                                                    onclick="setFormRating(1)"></i>
                                                                <i class="fas fa-star text-warning"
                                                                    onclick="setFormRating(2)"></i>
                                                                <i class="fas fa-star text-warning"
                                                                    onclick="setFormRating(3)"></i>
                                                                <i class="fas fa-star text-warning"
                                                                    onclick="setFormRating(4)"></i>
                                                                <i class="fas fa-star text-warning"
                                                                    onclick="setFormRating(5)"></i>
                                                            </div>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="reviewComment" class="form-label">Nội dung đánh
                                                                giá:</label>
                                                            <textarea class="form-control" name="comment"
                                                                id="reviewComment" rows="4"
                                                                placeholder="Hãy chia sẻ cảm nhận của bạn về sản phẩm này nhé..."
                                                                required></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">Trở lại</button>
                                                        <button type="submit" class="btn btn-primary">Gửi đánh
                                                            giá</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                    </div>
                                    </div>

                                    <div class="re">
                                        <div class="related">
                                            <div class="container">
                                                <div class="row mb-3">
                                                    <div class="col-12">
                                                        <h3 class="related-title"
                                                            style="font-weight: bold; text-transform: uppercase;">Sản
                                                            phẩm liên quan</h3>
                                                    </div>
                                                </div>

                                                <div class="products-grid">
                                                    <% /* Lấy danh sách sản phẩm liên quan từ request attribute */
                                                        List<Product> relatedProducts = (List<Product>)
                                                            request.getAttribute("relatedProducts");

                                                            if (relatedProducts != null && !relatedProducts.isEmpty()) {
                                                            for (Product p : relatedProducts) {
                                                            String imgPath = (p.getThumbnail() != null)
                                                            ? request.getContextPath() + p.getThumbnail()
                                                            : request.getContextPath() + "/images/no-image.png";
                                                            %>
                                                            <div class="product-card">
                                                                <a href="${root}/product_detail?id=<%=p.getProduct_id()%>"
                                                                    class="product-card-link">
                                                                    <div class="product-image">
                                                                        <span class="product-badge badge-new">NEW</span>
                                                                        <img src="<%=imgPath%>"
                                                                            alt="<%=p.getProduct_name()%>"
                                                                            loading="lazy">
                                                                    </div>
                                                                </a>

                                                                <div class="product-details">
                                                                    <div class="product-info">
                                                                        <a href="${root}/product_detail?id=<%=p.getProduct_id()%>"
                                                                            style="text-decoration: none;">
                                                                            <h4>
                                                                                <%=p.getProduct_name()%>
                                                                            </h4>
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
                                                                            <span class="price">
                                                                                <%=String.format("%,.0f",
                                                                                    p.getPrice())%>₫
                                                                            </span>
                                                                        </div>

                                                                        <button class="btn-cart" type="button"
                                                                            title="Thêm vào giỏ"
                                                                            <%=p.getDefaultVariantId()==null
                                                                            ? "disabled" : "" %>
                                                                            onclick="addToCart(<%=
                                                                                p.getDefaultVariantId() %>)">
                                                                                <i class="fas fa-shopping-cart"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <% } } else { %>
                                                                <p class="text-center"
                                                                    style="grid-column: 1 / -1; color: #6c757d;">Không
                                                                    tìm thấy sản phẩm liên quan nào...</p>
                                                                <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </main>

                                <!-- ===== FOOTER ===== -->
                                <jsp:include page="/views/layout/footer.jsp" />

                                <!-- Bootstrap JS -->
                                <script
                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                                <!-- Marked.js for Markdown parsing -->
                                <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

                                <!-- Custom JavaScript -->
                                <script src="../../js/main.js"></script>
                                <%-- Sử dụng pageContext để lấy tên dự án tự động --%>
                                    <script src="<c:url value='/js/product_detail.js'/>"></script>
                                    <%--Truyền contextPath của web app từ JSP sang JavaScript--%>
                                        <script>
                                            const contextPath = "<%= request.getContextPath() %>";
                                        </script>
                                        <%--Xử lý sự kiện trong product - thêm giỏ hàng--%>
                                            <script
                                                src="${root}/js/add-cart.js?v=<%= System.currentTimeMillis() %>"></script>
                                            <script>
                                                // Hàm xử lý hiệu ứng click chọn số sao trong Form đánh giá
                                                function setFormRating(rating) {
                                                    // Cập nhật giá trị số sao vào ô input ẩn để gửi về Server
                                                    document.getElementById('ratingInput').value = rating;

                                                    // Đổi màu hiển thị của các ngôi sao
                                                    const stars = document.querySelectorAll('.star-rating-form .fa-star');
                                                    stars.forEach((star, index) => {
                                                        if (index < rating) {
                                                            // Sáng lên (Thêm màu vàng, bỏ màu xám)
                                                            star.classList.add('text-warning');
                                                            star.classList.remove('text-muted');
                                                        } else {
                                                            // Tối đi (Thêm màu xám, bỏ màu vàng)
                                                            star.classList.remove('text-warning');
                                                            star.classList.add('text-muted');
                                                        }
                                                    });
                                                }

                                                // Render Markdown for product description
                                                document.addEventListener("DOMContentLoaded", function() {
                                                    var rawContentDiv = document.getElementById("productDescriptionContent");
                                                    var renderedDiv = document.getElementById("productDescriptionRendered");
                                                    if (rawContentDiv && renderedDiv && typeof marked !== 'undefined') {
                                                        var rawText = rawContentDiv.textContent || rawContentDiv.innerText;
                                                        // Configure marked to use breaks
                                                        marked.setOptions({
                                                            breaks: true,
                                                            gfm: true
                                                        });
                                                        renderedDiv.innerHTML = marked.parse(rawText);
                                                    }
                                                });
                                            </script>
                            </body>

                            </html>