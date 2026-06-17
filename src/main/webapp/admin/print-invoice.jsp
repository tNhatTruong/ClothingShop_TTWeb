<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <c:choose>
        <c:when test="${fn:length(invoiceList) == 1}">
            <title>Hoa_Don_${invoiceList[0].order.id}_StyleEra</title>
        </c:when>
        <c:otherwise>
            <title>Hoa_Don_Hang_Loat_StyleEra</title>
        </c:otherwise>
    </c:choose>
    <!-- Mượn Bootstrap để layout nhanh -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f3f4f6;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
        }

        /* Định dạng chung cho khối hóa đơn (A4) */
        .invoice-box {
            background: #fff;
            max-width: 210mm; /* Khổ A4 */
            margin: 0 auto 20px auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            font-size: 14px;
            line-height: 24px;
            position: relative;
        }

        /* Tiêu đề bảng */
        .table th {
            background-color: #f8f9fa !important;
            font-weight: 600;
        }

        .header-logo {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: 2px;
            color: #000;
            text-transform: uppercase;
        }

        .header-logo span {
            font-weight: 300;
        }

        .invoice-title {
            text-transform: uppercase;
            font-weight: bold;
            color: #555;
            margin-bottom: 0;
        }

        .footer-note {
            margin-top: 40px;
            text-align: center;
            font-size: 13px;
            color: #777;
            border-top: 1px dashed #ccc;
            padding-top: 15px;
        }

        /* Cấu hình đặc biệt khi IN MÁY (Browser Print) */
        @media print {
            body {
                background-color: #fff;
                padding: 0;
                margin: 0;
            }
            .invoice-box {
                margin: 0;
                padding: 0;
                box-shadow: none;
                max-width: 100%;
                width: 100%;
                border: none;
            }
            /* Cắt trang giấy nếu in nhiều hóa đơn */
            .page-break {
                page-break-after: always;
            }
            /* Ẩn hoàn toàn các nút thao tác UI khi in */
            .no-print {
                display: none !important;
            }
        }
        
        @page {
            size: A4;
            margin: 15mm;
        }
    </style>
</head>

<body>
    <!-- Nút hỗ trợ in trên giao diện web (Sẽ bị ẩn khi in ra PDF/Giấy) -->
    <div class="text-center mb-4 no-print">
        <button class="btn btn-primary px-4 py-2" onclick="window.print()">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-printer me-2" viewBox="0 0 16 16" style="position: relative; top: -2px;">
                <path d="M2.5 8a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1z"/>
                <path d="M5 1a2 2 0 0 0-2 2v2H2a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h1v1a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-1h1a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2H5zM4 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2H4V3zm1 5a2 2 0 0 0-2 2v1H2a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1v-1a2 2 0 0 0-2-2H5zm7 2v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1z"/>
            </svg>In Hóa Đơn Bằng Trình Duyệt
        </button>
        <button class="btn btn-secondary px-4 py-2 ms-2" onclick="window.close()">Đóng</button>
        <p class="text-muted mt-2 small">Mẹo: Chọn "Save as PDF" trong mục Destination để lưu file PDF vào máy.</p>
    </div>

    <!-- Vòng lặp in tất cả các hóa đơn (in lẻ hoặc in nhiều) -->
    <c:forEach var="inv" items="${invoiceList}" varStatus="status">
        <c:set var="o" value="${inv.order}" />
        <c:set var="items" value="${inv.items}" />
        
        <!-- Khối Hóa Đơn -->
        <div class="invoice-box ${not status.last ? 'page-break' : ''}">
            
            <!-- HEADER -->
            <div class="row border-bottom pb-3 mb-4">
                <div class="col-6">
                    <div class="header-logo">STYLE<span>ERA</span></div>
                    <div class="text-muted small">Thời trang dành cho bạn</div>
                </div>
                <div class="col-6 text-end">
                    <h3 class="invoice-title">Hóa Đơn Mua Hàng</h3>
                    <div class="fw-bold mt-2">Mã ĐH: #${o.id}</div>
                    <div class="text-muted small">Ngày lập: ${o.formattedCreatedAt}</div>
                </div>
            </div>

            <!-- THÔNG TIN -->
            <div class="row mb-4">
                <div class="col-sm-6">
                    <h6 class="fw-bold mb-2 text-uppercase text-secondary" style="font-size: 12px;">Đơn vị phát hành:</h6>
                    <div class="fw-bold">Cửa Hàng StyleEra</div>
                    <div>123 Đường Thời Trang, Quận 1, TP. HCM</div>
                    <div>Hotline: 0123.456.789</div>
                    <div>Email: support@styleera.vn</div>
                </div>
                <div class="col-sm-6 text-sm-end mt-4 mt-sm-0">
                    <h6 class="fw-bold mb-2 text-uppercase text-secondary" style="font-size: 12px;">Thông tin giao hàng:</h6>
                    <div class="fw-bold">${not empty o.shippingName ? o.shippingName : o.userName}</div>
                    <div>SĐT: ${not empty o.shippingPhone ? o.shippingPhone : 'N/A'}</div>
                    <div style="max-width: 250px; margin-left: auto;">Địa chỉ: ${not empty o.shippingAddress ? o.shippingAddress : 'N/A'}</div>
                </div>
            </div>

            <!-- BẢNG SẢN PHẨM -->
            <table class="table table-bordered table-sm mb-4">
                <thead class="text-center">
                    <tr>
                        <th style="width: 5%">STT</th>
                        <th style="width: 40%">Tên Sản Phẩm</th>
                        <th style="width: 15%">Phân loại</th>
                        <th style="width: 10%">SL</th>
                        <th style="width: 15%">Đơn giá</th>
                        <th style="width: 15%">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${items}" varStatus="itemStatus">
                        <tr>
                            <td class="text-center">${itemStatus.index + 1}</td>
                            <td>${item.productName}</td>
                            <td class="text-center text-muted" style="font-size: 12px;">
                                ${item.color} - Size ${item.size}
                            </td>
                            <td class="text-center">${item.quantity}</td>
                            <td class="text-end"><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                            <td class="text-end fw-bold"><fmt:formatNumber value="${item.total}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- TỔNG KẾT -->
            <div class="row">
                <div class="col-6">
                    <p class="text-muted small"><strong>Ghi chú:</strong><br>
                        Hàng mua rồi có thể đổi trả trong vòng 7 ngày nếu do lỗi nhà sản xuất.<br>
                        Yêu cầu giữ nguyên tem mác khi đổi trả.
                    </p>
                </div>
                <div class="col-6">
                    <table class="table table-sm table-borderless text-end">
                        <tr>
                            <td>Tổng tiền hàng:</td>
                            <td><fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                        </tr>
                        <tr>
                            <td>Phí vận chuyển:</td>
                            <td>Miễn phí</td>
                        </tr>
                        <tr class="border-top border-dark">
                            <td class="fw-bold pt-2">TỔNG THANH TOÁN:</td>
                            <td class="fw-bold pt-2 fs-5 text-danger"><fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-muted small pb-0 pt-1">
                                (Hình thức: Thanh toán khi nhận hàng - COD)
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- CHÂN TRANG -->
            <div class="footer-note">
                <p class="mb-1">Cảm ơn Quý khách đã mua sắm tại <strong>StyleEra</strong>!</p>
                <p class="mb-0">Website: www.styleera.vn</p>
            </div>
            
        </div>
    </c:forEach>

    <script>
        // Tự động bật dialog In ấn khi trang tải xong
        window.onload = function() {
            setTimeout(function() {
                window.print();
            }, 500); // Đợi 500ms để CSS render đầy đủ rồi mới gọi print
        };

        // Sau khi hoàn thành in (lưu/hủy), tự đóng tab (Một số trình duyệt không hỗ trợ event này đầy đủ, nên vẫn có nút Đóng backup)
        // window.onafterprint = function() {
        //     window.close();
        // };
    </script>
</body>
</html>
