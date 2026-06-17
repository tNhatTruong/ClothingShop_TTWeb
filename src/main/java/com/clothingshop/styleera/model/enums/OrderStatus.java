package com.clothingshop.styleera.model.enums;

public enum OrderStatus {
    PENDING_APPROVAL("Chờ duyệt"),
    PENDING_PAYMENT("Chờ thanh toán"),
    PAID("Đã Thanh Toán"),
    READY_TO_SHIP("Chờ vận chuyển"),
    SHIPPING("Đang vận chuyển"),
    DELIVERED("Đã Giao"),
    CANCELED("Đã hủy"),
    CANCELED_BY_USER("Hủy (Bởi người dùng)"),
    EXPIRED("Hủy (Quá hạn thanh toán)"),
    ADMIN_CONFIRMED("Đã Xác Nhận (Bởi Admin)"),
    PAID_AT_COUNTER("Thanh Toán Tại Quầy"),
    DELIVERY_FAILED("Giao thất bại"),
    RETURN_REQUESTED("Yêu cầu trả hàng"),
    RETURN_PROCESSING("Đang xử lý trả hàng"),
    REFUNDED("Đã hoàn tiền"),
    RETURN_REJECTED("Từ chối trả hàng");

    private final String value;

    OrderStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static OrderStatus fromString(String text) {
        for (OrderStatus b : OrderStatus.values()) {
            if (b.value.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }
}
