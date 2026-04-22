<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

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
                                    onclick="addToCart(${product.getDefaultVariantId()})">
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
            <!-- Khối bên trái: Đánh giá của người dùng -->
            <div class="left-block">
                <div class="item">
                    <!-- Phần đánh giá bên trái -->
                    <div class="review-content">
                        <div class="item_top">
                            <div class="user">
                                <img src="<c:url value='/images/image_product/user.png'/>"
                                     alt="${rp.product_name}">

                                <div class="infos">
                                    <p><span class="reviews">T***h</span></p>
                                    <p><span class="time">2025-20-11</span></p>
                                </div>
                            </div>
                        </div>

                        <!-- Bao quanh item_mid và item_content để xếp ngang -->
                        <div class="review-details">
                            <div class="item_mid">
                                <div class="rating">
                                    <img src="../../images/image_product/start.png">
                                    <img src="../../images/image_product/start.png">
                                    <img src="../../images/image_product/start.png">
                                    <img src="../../images/image_product/start.png">
                                    <img src="../../images/image_product/start.png">
                                </div>
                            </div>
                            <div class="item_content">
                                <div class="item-content-main-content  ">
                                    <div class="item-content-main-content-skuInfo">
                                        <div class="skuInfo-item"><span class="skuInfo-label">Màu:&nbsp;</span><span
                                                class="skuInfo-value">Xanh</span></div>
                                        <div class="skuInfo-item"><span
                                                class="skuInfo-label">Size:&nbsp;</span><span
                                                class="skuInfo-value">L </span></div>
                                    </div>
                                    <div class="item-content-main-content-reviews">
                                        <div class="item-content-main-content-reviews-item"><span>Áo đẹp, mặc mát,
                                                    tôn dáng nha mn, cũng ít chỉ thừa, với giá này thì ok lắm</span>
                                        </div>
                                        <div class="item-content-main-content-reviews-item"><span
                                                class="review-attribute">Chất liệu: </span><span>chất dày vải
                                                    đẹp.</span>
                                        </div>
                                        <div class="item-content-main-content-reviews-item"><span
                                                class="review-attribute">🎨Design:</span><span>rất sang trọng</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Phần ảnh bên phải -->
                    <div class="right-block">

                        <img src="<c:url value='/images/image_product/anh_polo1.png'/>"
                             alt="${rp.product_name}">
                        <img src="<c:url value='/images/image_product/anh_polo2.png'/>"
                             alt="${rp.product_name}">
                    </div>
                </div>
            </div>

            <div class="item">
                <!-- Phần đánh giá bên trái -->
                <div class="review-content">
                    <div class="item_top">
                        <div class="user">
                            <img src="<c:url value='/images/image_product/user.png'/>"
                                 alt="${rp.product_name}">
                            <div class="infos">
                                <p><span class="reviews">H***h</span></p>
                                <p><span class="time">2025-21-11</span></p>
                            </div>
                        </div>
                    </div>

                    <!-- Bao quanh item_mid và item_content để xếp ngang -->
                    <div class="review-details">
                        <div class="item_mid">
                            <div class="rating">
                                <img src="../../images/image_product/start.png">
                                <img src="../../images/image_product/start.png">
                                <img src="../../images/image_product/start.png">
                                <img src="../../images/image_product/start.png">

                            </div>
                        </div>
                        <div class="item_content">
                            <div class="item-content-main-content  ">
                                <div class="item-content-main-content-skuInfo">
                                    <div class="skuInfo-item"><span class="skuInfo-label">Màu:&nbsp;</span><span
                                            class="skuInfo-value">Đỏ</span></div>
                                    <div class="skuInfo-item"><span class="skuInfo-label">Size:&nbsp;</span><span
                                            class="skuInfo-value">XL</span></div>
                                </div>
                                <div class="item-content-main-content-reviews">
                                    <div class="item-content-main-content-reviews-item"><span>Shop giao hàng nhanh,
                                                đón gói cẩn thận, chất liệu áo mềm mịn sờ mát tay, màu áo rất đẹp</span>
                                    </div>
                                    <div class="item-content-main-content-reviews-item"><span
                                            class="review-attribute">Chất liệu: </span><span>chất dày vải
                                                đẹp.</span>
                                    </div>
                                    <div class="item-content-main-content-reviews-item"><span
                                            class="review-attribute">🎨Design:</span><span>rất sang trọng</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Phần ảnh bên phải -->
                <div class="right-block">

                    <img src="<c:url value='/images/image_product/anh1.1.png'/>"
                         alt="${rp.product_name}">
                    <img src="<c:url value='/images/image_product/anh1.1.2.png'/>"
                         alt="${rp.product_name}">
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    </div>

    <div class="re">
        <div class="related">
            <div class="container">
                <div class="row">
                    <div class="col_top">
                        <h3 class="related-title">SẢN PHẨM LIÊN QUAN</h3>
                    </div>
                </div>
                <div class="row">
                    <%-- Vòng lặp tự động lấy từng sản phẩm từ danh sách relatedProducts --%>
                    <div class="col_1">
                        <div class="product_item">
                            <div class="product_item_pic2">
                                <a href="<c:url value='/Product_DetailController?id=${rp.product_id}'/>">
                                    <img src="<c:url value='/images/product_item_nam/1/1.3/trangphuc_nam.png'/>"
                                         alt="${rp.product_name}">
                                </a>
                            </div>
                            <div class="product_item_text">
                                <h6>Quần jeans nam natural form tapered dáng suông </h6>
                                <h5>810.000đ</h5>

                                <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    </div>
                    <div class="col_2">
                        <div class="product_item">
                            <div class="product_item_pic2">
                                <a href="<c:url value='/Product_DetailController?id=${rp.product_id}'/>">
                                    <img src="<c:url value='/images/product_item_nam/7/7.3/trangphuc_nam.png'/>"
                                         alt="${rp.product_name}">
                                </a>
                            </div>
                            <div class="product_item_text">
                                <h6>Quần jeans nam natural form tapered dáng suông </h6>
                                <h5>1.510.000đ</h5>

                                <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    </div>
                    <div class="col_3">
                        <div class="product_item sale">
                            <div class="product_item_pic2">
                                <a href="<c:url value='/Product_DetailController?id=${rp.product_id}'/>">
                                    <img src="<c:url value='/images/product_item_nam/4/4.10/trangphuc_nam.png'/>"
                                         alt="${rp.product_name}">
                                </a>
                            </div>
                            <div class="product_item_text">
                                <h6>Áo Sơ Mi Nam Tay Dài Chất Liệu BAMBOO Cao Cấp</h6>
                                <h5>890.000đ</h5>

                                <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    </div>
                    <div class="col_4">
                        <div class="product_item">
                            <div class="product_item_pic2">
                                <a href="<c:url value='/Product_DetailController?id=${rp.product_id}'/>">
                                    <img src="<c:url value='/images/product_item_nam/5/5.10/trangphuc_nam.png'/>"
                                         alt="${rp.product_name}">
                                </a>
                            </div>
                            <div class="product_item_text">
                                <h6>Quần Short Kaki Nam Cotton Spandex Form Straight</h6>
                                <h5>879.000đ</h5>

                                <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    </div>
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
<script src="${root}/js/add-cart.js"></script>
</body>

</html>