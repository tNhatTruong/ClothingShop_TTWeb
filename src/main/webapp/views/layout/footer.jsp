<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="site-footer">
    <div class="footer-main-content">
        <div class="footer-columns">
            <!-- Cột 1: Thông tin thương hiệu & Liên hệ -->
            <div class="footer-column brand-column">
                <h2 class="footer-brand">STYLEERA</h2>
                <p class="footer-desc">Định hình phong cách thời trang của riêng bạn với những thiết kế độc quyền từ StyleEra. Nâng tầm phong cách, khẳng định chất riêng.</p>
                <div class="footer-contact-info">
                    <p><i class="fas fa-map-marker-alt"></i> 123 Đường Thời Trang, Quận 1, TP.HCM</p>
                    <p><i class="fas fa-phone-alt"></i> Hotline: +84 000 000 000</p>
                    <p><i class="fas fa-envelope"></i> contact@styleera.com</p>
                </div>
            </div>

            <!-- Cột 2: Menu Hỗ Trợ -->
            <div class="footer-column">
                <h3 class="footer-column-title">Hỗ Trợ Khách Hàng</h3>
                <ul class="footer-menu-list">
                    <!-- Issue STT 02 applied here -->
                    <li><a href="${root}/contact"><i class="fas fa-chevron-right"></i> Chính Sách Đổi Trả</a></li>
                    <li><a href="${root}/contact"><i class="fas fa-chevron-right"></i> Chính Sách Bảo Hành</a></li>
                    <li><a href="${root}/contact"><i class="fas fa-chevron-right"></i> Hướng Dẫn Chọn Size</a></li>
                    <li><a href="${root}/contact"><i class="fas fa-chevron-right"></i> Câu Hỏi Thường Gặp</a></li>
                </ul>
            </div>

            <!-- Cột 3: Nhận Bản Tin & Mạng Xã Hội -->
            <div class="footer-column newsletter-column">
                <h3 class="footer-column-title">Đăng Ký Nhận Tin</h3>
                <p class="footer-desc">Nhận ngay thông tin về các bộ sưu tập mới nhất và ưu đãi đặc biệt.</p>
                <form class="newsletter-form" action="${root}/contact" method="post">
                    <div class="newsletter-input-wrapper">
                        <input required type="email" name="email" class="newsletter-email-input" placeholder="Nhập email của bạn...">
                        <button class="newsletter-submit-btn" type="submit" aria-label="Đăng ký">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </form>
                <div class="social-links-list">
                    <a href="https://facebook.com" aria-label="Facebook" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://instagram.com" aria-label="Instagram" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://tiktok.com" aria-label="TikTok" target="_blank"><i class="fab fa-tiktok"></i></a>
                    <a href="https://youtube.com" aria-label="Youtube" target="_blank"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- Thanh Bản Quyền -->
    <div class="footer-bottom-bar">
        <p><i class="far fa-copyright"></i> 2025 StyleEra. All rights reserved. Designed for Fashion.</p>
    </div>

    <!-- Nút Lên Đầu Trang -->
    <button id="backToTopBtn" title="Lên đầu trang">
        <i class="fas fa-arrow-up"></i>
    </button>
</footer>
<script src="${root}/js/toast-utils.js"></script>