<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>StyleEra - Liên hệ</title>
    <link rel="icon" type="image/png" href="${root}/images/logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${root}/css/header-footer.css"/>
    <link rel="stylesheet" href="${root}/css/contact.css"/>
</head>
<body>
<!--Header-->
<jsp:include page="/views/layout/header.jsp" />

<main class="container product-page">
    <nav aria-label="breadcrumb" class="mt-3 mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
            <li class="breadcrumb-item active" id="breadcrumb-category">Liên hệ</li>
        </ol>
    </nav>
    <div class="form">
        <div class="container">
            <div class="row g-3 g-md-4">
                <!--contact_text-->
                <div class="col-12 col-lg-6 px-3 px-lg-4">
                    <div class="contact_text">
                        <h5 class="title_small mt-2">
                            <i class="fa-solid fa-address-card"></i> Thông tin
                        </h5>
                        <h1 class="title">LIÊN HỆ VỚI CHÚNG TÔI</h1>
                        <p class="description_text mt-3">
                            Chúng tôi luôn sẵn sàng lắng nghe ý kiến của bạn. Nếu bạn có
                            bất kỳ thắc mắc nào về sản phẩm áo thời trang hoặc đơn hàng,
                            hãy liên hệ ngay để được hỗ trợ nhanh chóng. Xin cảm ơn Khách
                            hàng ủng hộ
                        </p>
                    </div>
                    <div class="mt-3 mt-md-4">
                        <!--contact_form-->
                        <div class="contact_form">
                            <form action="${root}/ContactController" method="post" class="contact-form">
                                <div class="row g-3 g-md-3">
                                    <div class="col-12 col-sm-6">
                                        <input class="input_txt" type="text" id="userName" name="name"
                                               placeholder="Tên của bạn" required/>
                                        <c:if test="${not empty nameError}">
                                            <span class="text-danger" style="font-weight: bold">${nameError}</span>
                                        </c:if>
                                    </div>

                                    <div class="col-12 col-sm-6">
                                        <input class="input_txt" type="email" id="userEmail" name="email"
                                               placeholder="Nhập Email liên hệ của trang" required/>
                                        <c:if test="${not empty emailError}">
                                            <span class="text-danger" style="font-weight: bold">${emailError}</span>
                                        </c:if>
                                    </div>

                                    <div class="col-12">
                                    <textarea class="input_textArea" id="userMessage" name="message"
                                              placeholder="Nội dung tin nhắn" required></textarea>
                                        <c:if test="${not empty messageError}">
                                            <span class="text-danger" style="font-weight: bold">${messageError}</span>
                                        </c:if>
                                    </div>
                                    <div class="col-12">
                                        <button class="mybutton" type="submit">
                                            <i class="fas fa-paper-plane"></i> Gửi thông tin
                                        </button>
                                    </div>
                                    <c:if test="${success}">
                                        <div class="text-success mt-3" style="font-weight: bold">
                                            Đã gửi thông tin thành công!
                                        </div>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6 px-3 px-lg-4">
                    <div class="mt-3 mt-md-4">
                        <h4 class="title">Chi nhánh Tp.HCM</h4>
                        <p class="address">
                            <strong><i class="fa-solid fa-house"></i> Địa chỉ:</strong>
                            376, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam
                        </p>
                        <p class="telephone">
                            <strong><i class="fa-solid fa-phone-volume"></i> Số Điện Thoại:</strong>0904899626
                        </p>
                        <p class="address">
                            <strong><i class="fa-solid fa-envelope"></i> Email liên hệ:</strong>22130306@st.hcmuaf.edu.vn
                        </p>
                    </div>
                    <div id="gg_map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5488.065716817417!2d106.79212642177389!3d10.873288603147373!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175276398969f7b%3A0x9672b7efd0893fc4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6JtIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1761562316225!5m2!1svi!2s"
                                width="100%" height="100%" style="border: 0" allowfullscreen="" loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!--Footer-->
<jsp:include page="/views/layout/footer.jsp" />
<script src="${root}/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
