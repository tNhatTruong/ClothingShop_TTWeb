<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>

<%--Định dạng tiền tệ VNĐ--%>
<fmt:setLocale value="vi_VN"/>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>StyleEra - Giỏ hàng</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/css/header-footer.css"/>
    <link rel="stylesheet" href="${root}/css/cartstyle.css"/>

</head>
<body>

<jsp:include page="/views/layout/header.jsp"/>

<main class="container product-page">
    <nav aria-label="breadcrumb" class="mt-3 mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
            <li class="breadcrumb-item active" id="breadcrumb-category">Giỏ hàng</li>
        </ol>
    </nav>
    <div class="container-md text-center mt-3 mb-3">
        <div class="header">
            <div class="row">
                <div class="col-lg-8 form-left">
                    <div class="table_shopping_cart">
                        <table class="table">
                            <thead>
                            <tr class="table-dark">
                                <th><input type="checkbox" class="form-check-input" id="checkAllCart"/></th>
                                <th>STT</th>
                                <th>Hình Ảnh</th>
                                <th>SẢN PHẨM</th>
                                <th>GIÁ TIỀN</th>
                                <th>SỐ LƯỢNG</th>
                                <th>TỔNG GIÁ TIỀN</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--                            Hiển thị danh sách sản phẩm được thêm vào giỏ hàng--%>
                            <c:choose>
                                <c:when test="${sessionScope.cart == null || sessionScope.cart.item.size() == 0}">
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <i class="fa-solid fa-cart-shopping fa-2x mb-2"></i>
                                            <p class="mt-2 mb-0 fw-bold">Giỏ hàng của bạn đang trống</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="count" value="1"/>
                                    <c:forEach items="${sessionScope.cart.item}" var="item">
                                        <tr>
                                                <%--                                            tạo checkbox để chọn thanh toán--%>
                                            <td><input type="checkbox" class="form-check-input cart-item-checkbox"/>
                                            </td>
                                            <td>${count}</td>
                                            <td>
                                                <div class="product-item img_product">
                                                    <img src="${pageContext.request.contextPath}${item.variant.product.thumbnail}"
                                                         alt="${item.variant.product.product_name}"
                                                         style="width: 100px"/>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="product-item">
                                                    <p>${item.variant.product.product_name}</p>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="product-item">
                                                    <h6><fmt:formatNumber value="${item.variant.product.price}"
                                                                          pattern="#,##0 'VNĐ'"/></h6>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="quantity-item">
                                                    <button type="button"
                                                            class="qty-btn"
                                                            onclick="updateCart(${item.variant.variantId},'decrease',this)">
                                                        <i class="fa-solid fa-minus"></i>
                                                    </button>

                                                    <input type="text" name="quantity" class="qty-input"
                                                           value="${item.quantity}" size="2" readonly/>

                                                    <button type="button"
                                                            class="qty-btn"
                                                            onclick="updateCart(${item.variant.variantId},'increase',this)">
                                                        <i class="fa-solid fa-plus"></i>
                                                    </button>

                                                </div>

                                            </td>
                                            <td>
                                                <div class="price-item">
                                                    <div class="cart_price"><fmt:formatNumber
                                                            value=" ${item.quantity * item.variant.product.price }"
                                                            pattern="#,##0 'VNĐ'"/></div>
                                                </div>
                                            </td>
                                                <%--Chức năng xoá sản phẩm ra khỏi giỏ hàng--%>
                                            <td>
                                                <button type="button" class="btn-remove"
                                                        onclick="if(confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?')) { removeItem(${item.variant.variantId}, this); }">
                                                    <i class="fa-solid fa-circle-xmark closed"
                                                       style="color: #b61111ff"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <%--                                        tăng biến count lên 1 khi thêm nhiều vào giỏ hàng--%>
                                        <c:set var="count" value="${count + 1}"/>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-12 col-lg-12 col-sm-12">
                        <div class="my_button">
                            <a href="${root}/home" class="continute_btn">TIẾP TỤC MUA SẮM</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 col-lg-4 col-sm-6 form-right">
                    <div class="cart_total">
                        <h5>ĐƠN HÀNG CỦA BẠN</h5>
                        <ul>
                            <li>
                                <span class="label">TỔNG ĐƠN HÀNG:</span>
                                <span class="value"><strong
                                        id="total-quantity">${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}</strong></span>
                            </li>
                            <li>
                                <span class="label">TỔNG GIÁ TIỀN:</span>
                                <span class="value"><strong id="total-price"> <fmt:formatNumber
                                        value="${ sessionScope.cart != null ? sessionScope.cart.total() : 0}"
                                        pattern="#,##0 'VNĐ'"/></strong></span>
                            </li>
                        </ul>
                        <div class="cart-actions">
                            <%-- NÚT THANH TOÁN--%>
                            <a href="checkout.jsp" class="btn btn-success">MUA HÀNG</a>
                            <a href="order_status.jsp" class="btn btn-danger">TRẠNG THÁI ĐƠN HÀNG</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/views/layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${root}/js/main.js"></script>
<%--Truyền contextPath của web app từ JSP sang JavaScript--%>
<script> const contextPath = "<%= request.getContextPath() %>";</script>
<!-- Xử lý xoá sản phẩm khỏi giỏ hàng -->
<script src="${root}/js/remove-cart.js"></script>
<!-- Xử lý cập nhật số lượng sản phẩm trong giỏ hàng -->
<script src="${root}/js/update-cart.js"></script>
<%--Xử lý checkbox nếu chọn All sản phẩm và ngược lại--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const checkAll = document.getElementById("checkAllCart");
        if (!checkAll) return;

        checkAll.addEventListener("change", function () {
            document.querySelectorAll(".cart-item-checkbox").forEach(cb => {
                cb.checked = this.checked;
            });
        });

        document.addEventListener("change", function (e) {
            if (e.target.classList.contains("cart-item-checkbox")) {
                const all = document.querySelectorAll(".cart-item-checkbox");
                const checked = document.querySelectorAll(".cart-item-checkbox:checked");
                checkAll.checked = all.length === checked.length;
            }
        });
    });
</script>
</body>
</html>
