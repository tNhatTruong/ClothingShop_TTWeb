<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>
<%@ page import="java.util.List" %>
<%@ page import="com.clothingshop.styleera.model.Review" %>
<%@ page import="com.clothingshop.styleera.model.Product" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleEra - Sản phẩm</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${root}/css/header-footer.css">
    <link rel="stylesheet" href="${root}/css/product_detail.css">
    <link rel="stylesheet" href="${root}/css/style.css">
</head>

<body>
<!-- ===== HEADER ===== -->
<jsp:include page="/views/layout/header.jsp"/>

<!-- ===== MAIN CONTENT ===== -->
<main class="main-content">
    <!-- Content goes here -->
    <div class="product_detail_container">
        <div class="product_detail_wrapper">

            <!-- LEFT: PRODUCT IMAGES -->
            <div class="product_images">
                <div class="product_main_image">
                    <img id="mainImage" src="${root}${imageList[0]}" alt="${product.product_name}">
                </div>

                <div class="product_thumbs">
                    <c:forEach items="${imageList}" var="imgUrl" begin="0" end="1">
                        <img src="${root}${imgUrl}"
                             alt="Thumbnail"
                             onclick="changeImage('${root}${imgUrl}')"
                             style="cursor: pointer;">
                    </c:forEach>
                </div>
            </div>

            <!-- RIGHT: PRODUCT INFO -->
            <div class="product_info">
                <h2 class="product_title">Áo polo nam BASIC SYMBOL vải cá sấu cotton interlock xuất xịn,
                    thanh lịch, sang trọng - POLOMANOR</h2>

                <div class="rating">
                    <c:forEach begin="0" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= product.medium_rating}">
                                <img src="${root}/images/image_product/start.png" alt="star" width="20">
                            </c:when>

                        </c:choose>
                    </c:forEach>

                    <span>- Đánh giá ${product.medium_rating}/5</span>
                </div>

                <h3 class="product_price">
                    <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/>đ
                    <span style="text-decoration: line-through; margin-left: 10px; font-size: 0.8em; color: gray;">

                    </span>
                </h3>

                <p class="product_desc">
                    Áo polo nam chất liệu cá sấu cotton interlock cao cấp, bề mặt mềm mịn, thấm hút tốt;
                    thiết kế cổ bẻ, tay ngắn chuẩn form tạo vẻ ngoài lịch sự và sang trọng.
                </p>

                <div class="product_detail_option">
                    <form action="${root}/checkout" method="POST" id="checkoutForm">
                        <!-- SIZE -->
                        <div class="product_detail_size">
                            <label class="size-label">S</label>
                            <label class="size-label">M</label>
                            <label class="size-label">L</label>
                            <label class="size-label active">XL</label>
                            <label class="size-label">XXL</label>
                        </div>

                        <!-- COLOR -->
                        <div class="product_detail_color">
                            <span>Color:</span>
                            <div class="mt-2">
                                <c:forEach items="${colorList}" var="c">
                                    <button type="button" class="btn btn-outline-secondary btn-sm me-2 color-choice"
                                            onclick="pickColor(this, '${c}')">${c}</button>
                                </c:forEach>
                            </div>
                        </div>
                        <input type="hidden" name="selectedColor" id="finalColor" value="">

                        <div class="product_detail_quantity">
                            <label for="quantity">Số lượng:</label>
                            <button type="button" id="btn-decrease">−</button>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" readonly>
                            <button type="button" id="btn-increase">+</button>
                        </div>
                        <input type="hidden" name="productName" value="${product.product_name}">
                        <input type="hidden" name="productImage" id="hiddenProductImage" value="${imageList[0]}">
                        <input type="hidden" name="productPrice" value="${product.price}">
                        <input type="hidden" name="selectedSize" id="finalSize" value="XL">

                        <div class="product_detail_actions"
                             style="margin-top: 25px;"> <%-- Gom nút vào div riêng để dễ căn chỉnh --%>
                            <button type="submit" class="btn btn-primary validate_order">
                                Mua hàng
                            </button>
                            <%-- Nút thêm vào giỏ hàng--%>
                            <button class="btn btn-primary validate_order" type="button"
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
                        <a class="nav-link active" data-tab="tabs-5">MÔ TẢ</a>
                    </li>

                    <li class="nav_item">
                        <a class="nav-link" data-tab="tabs-7">THÔNG TIN BỔ SUNG</a>
                    </li>
                </ul>

                <div class="tab_content">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-5" role="tabpanel">
                            <div class="product_details_tab_content">
                                <p class="note">Thời điểm này chỉ là tạm thời, nhưng nó lại tạo nên một bố
                                    cục hài hòa ở giữa, không có bất kỳ yêu cầu phức tạp nào. Pellentesque
                                    diam dolor, một phần tử giúp bố cục gọn gàng hơn nhờ sự liên kết và mềm
                                    mại khi hiển thị. Phần nội dung này được thiết kế để hỗ trợ cấu trúc
                                    tổng thể, đồng thời tăng tính trực quan và dễ chịu khi người dùng trải
                                    nghiệm.</p>
                                <div class="product_details_tab_content_item">
                                    <h5>THÔNG TIN SẢN PHẨM</h5>
                                    <p>Một Pocket PC là một loại máy tính cầm tay, sở hữu nhiều chức năng
                                        tương tự như một máy tính cá nhân hiện đại. Những thiết bị nhỏ gọn
                                        này cho phép người dùng nhận và lưu trữ email, tạo danh sách liên
                                        hệ, sắp xếp lịch hẹn, lướt Internet, gửi tin nhắn văn bản và nhiều
                                        tính năng khác. Mỗi sản phẩm được gọi là Pocket PC phải được trang
                                        bị phần mềm chuyên dụng để vận hành thiết bị và phải có màn hình cảm
                                        ứng cùng touchpad.</p>
                                    <p>Giống như bất kỳ sản phẩm công nghệ mới nào, giá của Pocket PC trong
                                        thời kỳ đầu ra mắt rất cao. Vào khoảng năm 2003, người tiêu dùng
                                        phải chi khoảng 700 USD để sở hữu một trong những mẫu Pocket PC cao
                                        cấp nhất. Ngày nay, khách hàng có thể thấy mức giá đã trở nên hợp lý
                                        hơn nhiều khi độ “hot” ban đầu đã giảm. Hiện tại, với khoảng 350
                                        USD, bạn đã có thể mua một chiếc Pocket PC mới.</p>
                                </div>
                                <div class="product_details_tab_content_item">
                                    <h5>CHẤT LIỆU SỬ DỤNG</h5>
                                    <p>Polyester được xem là chất liệu có chất lượng thấp hơn do không phải
                                        là sợi tự nhiên. Chất liệu này được tạo ra từ sợi tổng hợp, không tự
                                        nhiên như len. Những bộ suit làm từ polyester dễ bị nhăn và nổi
                                        tiếng với đặc tính không thoáng khí. Ngoài ra, suit polyester thường
                                        có độ bóng nhẹ so với suit bằng len hoặc cotton, điều này có thể
                                        khiến trang phục trông kém sang trọng.

                                        Ngược lại, chất liệu nhung (velvet) có kết cấu mềm mịn, sang trọng
                                        và thoáng khí. Velvet là lựa chọn tuyệt vời cho áo khoác dự tiệc tối
                                        và có thể mặc quanh năm.</p>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane" id="tabs-7" role="tabpanel">
                            <div class="product_details_tab_content">
                                <p class="note">Khoảng thời gian này chỉ mang tính tạm thời, nhưng lại tạo
                                    nên một bố cục hài hòa và chắc chắn, không đòi hỏi quá nhiều.
                                    Pellentesque diam dolor, một yếu tố giúp tăng sự liên kết và mềm mại cho
                                    bố cục. Phần nội dung này hỗ trợ tốt cho cấu trúc tổng thể, mang lại sự
                                    ổn định và tăng tính trực quan cho người dùng.</p>
                                <div class="product_details_tab_content_item">
                                    <h5>THÔNG TIN SẢN PHẨM</h5>
                                    <p>Pocket PC là một dạng máy tính cầm tay, sở hữu nhiều tính năng tương
                                        tự như một máy tính cá nhân hiện đại. Những thiết bị nhỏ gọn này cho
                                        phép người dùng nhận và lưu trữ email, tạo danh bạ liên hệ, sắp xếp
                                        các cuộc hẹn, lướt Internet, gửi tin nhắn văn bản và nhiều chức năng
                                        khác. Mỗi sản phẩm được gắn nhãn Pocket PC đều phải đi kèm phần mềm
                                        chuyên dụng để vận hành thiết bị và phải có màn hình cảm ứng cùng
                                        touchpad.</p>
                                    <p>Giống như nhiều sản phẩm công nghệ mới khác, giá của Pocket PC khi
                                        mới ra mắt khá cao. Khoảng năm 2003, người tiêu dùng phải bỏ ra gần
                                        700 USD để sở hữu một trong những mẫu Pocket PC cao cấp nhất. Ngày
                                        nay, khi độ “mới lạ” đã giảm, khách hàng nhận thấy mức giá đã trở
                                        nên hợp lý hơn nhiều. Hiện tại, với khoảng 350 USD, bạn đã có thể
                                        mua một chiếc Pocket PC hoàn toàn mới.</p>
                                </div>
                                <div class="product_details_tab_content_item">
                                    <h5>CHẤT LIỆU SỬ DỤNG</h5>
                                    <p>Polyester được xem là chất liệu có chất lượng thấp hơn vì không phải
                                        là sợi tự nhiên. Nó được tạo ra từ các sợi tổng hợp, khác với những
                                        chất liệu tự nhiên như len. Những bộ suit làm từ polyester dễ bị
                                        nhăn và được biết đến là không thoáng khí. Ngoài ra, suit polyester
                                        thường có độ bóng nhẹ so với suit làm từ len hoặc cotton, điều này
                                        có thể khiến bộ trang phục trông kém sang trọng.

                                        Ngược lại, chất liệu nhung (velvet) có kết cấu mềm mịn, sang trọng
                                        và thoáng khí. Velvet là lựa chọn tuyệt vời cho áo khoác dự tiệc tối
                                        và có thể được sử dụng quanh năm.</p>
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
        <h2>ĐÁNH GIÁ SẢN PHẨM</h2>
        <div class="review-container">
            <%
                // Lấy danh sách đánh giá từ request attribute do Controller gửi sang
                List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");

                if (reviewList != null && !reviewList.isEmpty()) {
                    // Định dạng ngày tháng hiển thị theo kiểu năm-tháng-ngày giống form mẫu
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                    for (Review r : reviewList) {
                        String formattedDate = sdf.format(r.getCreatedAt());
            %>
            <div class="item">
                <div class="review-content">
                    <div class="item_top">
                        <div class="user">
                            <img src="<%= request.getContextPath() %>/images/image_product/user.png" alt="User Avatar">

                            <div class="infos">
                                <p><span class="reviews"><%= r.getFullName() %></span></p>
                                <p><span class="time"><%= formattedDate %></span></p>
                            </div>
                        </div>
                    </div>

                    <div class="review-details">
                        <div class="item_mid">
                            <div class="rating">
                                <%
                                    // Vòng lặp hiển thị chuẩn số ngôi sao dựa trên dữ liệu rating (1-5) trong DB
                                    for (int i = 0; i < r.getRating(); i++) {
                                %>
                                <img src="<%= request.getContextPath() %>/images/image_product/start.png" alt="star">
                                <% } %>
                            </div>
                        </div>

                        <div class="item_content">
                            <div class="item-content-main-content">
                                <div class="item-content-main-content-reviews">
                                    <div class="item-content-main-content-reviews-item">
                                        <span><%= r.getComment() %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12 text-center py-5">
                <p class="text-muted" style="font-style: italic;">Sản phẩm này chưa có lượt đánh giá nào từ khách hàng.</p>
            </div>
            <% } %>
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
                        <h3 class="related-title" style="font-weight: bold; text-transform: uppercase;">Sản phẩm liên quan</h3>
                    </div>
                </div>

                <div class="products-grid">
                    <%
                        // Lấy danh sách sản phẩm liên quan từ request attribute
                        List<Product> relatedProducts = (List<Product>) request.getAttribute("relatedProducts");

                        if (relatedProducts != null && !relatedProducts.isEmpty()) {
                            for (Product p : relatedProducts) {
                                String imgPath = (p.getThumbnail() != null)
                                        ? request.getContextPath() + p.getThumbnail()
                                        : request.getContextPath() + "/images/no-image.png";
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

                                <button class="btn-cart" type="button" title="Thêm vào giỏ"
                                        <%= p.getDefaultVariantId() == null ? "disabled" : "" %>
                                        onclick="addToCart(<%= p.getDefaultVariantId() %>)">
                                    <i class="fas fa-shopping-cart"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <p class="text-center" style="grid-column: 1 / -1; color: #6c757d;">Không tìm thấy sản phẩm liên quan nào...</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ===== FOOTER ===== -->
<jsp:include page="/views/layout/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script src="../../js/main.js"></script>
<%-- Sử dụng pageContext để lấy tên dự án tự động --%>
<script src="<c:url value='/js/product_detail.js'/>"></script>
<%--Truyền contextPath của web app từ JSP sang JavaScript--%>
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>
<%--Xử lý sự kiện trong product - thêm giỏ hàng--%>
<script src="${root}/js/add-cart.js?v=<%= System.currentTimeMillis() %>"></script>
</body>

</html>