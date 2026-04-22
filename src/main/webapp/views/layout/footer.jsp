    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <footer class="site-footer">
        <div class="footer-top-bar">
        <div class="footer-contact-row">
        <div class="footer-contact-item">
        <a href="tel:+84000000000">
        <i class="fas fa-phone-alt"></i>
        <span>Hotline: +84 000 000 000</span>
        </a>
        </div>
        <div class="footer-contact-item">
        <a href="mailto:contact@gmail.com">
        <i class="fas fa-envelope"></i>
        <span>contact@gmail.com</span>
        </a>
        </div>
        </div>
        </div>

        <div class="footer-main-content">
        <div class="footer-columns">
        <div class="footer-social-column">
        <h2 class="footer-column-title">Đăng ký nhận tin khuyến mãi</h2>

        <form class="newsletter-form" action="${root}/account/contact" method="post">
        <input name="form_type" type="hidden" value="customer">
        <input name="utf8" type="hidden" value="✓">
        <input type="hidden" name="contact[tags]" value="khách hàng tiềm năng, bản tin"/>

        <div class="newsletter-input-wrapper">
        <input required type="email" name="contact[email]" class="newsletter-email-input"
        placeholder="Nhập email của bạn">
        <button class="newsletter-submit-btn" type="submit" aria-label="submit form">
        <i class="fas fa-paper-plane"></i>
        </button>
        </div>
        </form>

        <div class="social-links-list">
        <a href="https://www.facebook.com/" aria-label="Facebook" target="_blank"><i
        class="fab fa-facebook-f"></i></a>
        <a href="https://www.linkedin.com/" aria-label="LinkedIn" target="_blank"><i
        class="fab fa-linkedin-in"></i></a>
        <a href="https://www.instagram.com/" aria-label="Instagram" target="_blank"><i
        class="fab fa-instagram"></i></a>
        <a href="https://www.youtube.com/" aria-label="YouTube" target="_blank"><i
        class="fab fa-youtube"></i></a>
        <a href="https://www.tiktok.com/" aria-label="TikTok" target="_blank"><i
        class="fab fa-tiktok"></i></a>
        <a href="https://zalo.me/" aria-label="Zalo" target="_blank"><i class="fas fa-comment-dots"></i></a>
        </div>

        <div class="app-download-section">
        <h3>Tải app</h3>
        <div class="app-download-links">
        <a href="https://apps.apple.com/" target="_blank" class="app-badge">
        <img src="${root}/images/app-download/appstore.png" alt="App Store">
        </a>
        <a href="https://play.google.com/" target="_blank" class="app-badge">
        <img src="${root}/images/app-download/googleplaystore.png" alt="Play Store">
        </a>
        </div>
        </div>
        </div>

        <div class="footer-column">
        <h3 class="footer-column-title">Về StyleEra</h3>
        <ul class="footer-menu-list">
        <li><a href="#"><i class="fas fa-chevron-right"></i> Giới Thiệu</a></li>
        <li><a href="#"><i class="fas fa-chevron-right"></i> Công Nghệ Sản Xuất</a></li>
        <li><a href="#"><i class="fas fa-chevron-right"></i> Cơ Hội Việc Làm</a></li>
        <li><a href="#"><i class="fas fa-chevron-right"></i> Hệ Thống Cửa Hàng</a></li>
        <li><a href="#"><i class="fas fa-chevron-right"></i> Tạp Chí Thời Trang</a></li>
        </ul>
        </div>

        <div class="footer-column">
        <h3 class="footer-column-title">Tài khoản</h3>
        <ul class="footer-menu-list">
        <li><a href="${root}/views/pages/login.jsp"><i class="fas fa-chevron-right"></i> Đăng nhập/Đăng ký</a></li>
        <li><a href="${root}/views/pages/account.jsp"><i class="fas fa-chevron-right"></i> Lịch sử mua hàng</a></li>
        <li><a href="${root}/views/pages/account.jsp"><i class="fas fa-chevron-right"></i> Danh sách địa chỉ</a></li>
        </ul>
        </div>

        <div class="footer-column">
        <h3 class="footer-column-title">Hỗ trợ khách hàng</h3>
        <ul class="footer-menu-list">
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Chính Sách Thành
        Viên</a></li>
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Chính Sách Đổi Hàng</a></li>
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Chính Sách Bảo Hành</a></li>
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Hướng Dẫn Mua Hàng</a></li>
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Hướng Dẫn Chọn Size</a></li>
        <li><a href="${root}/views/pages/contact.jsp"><i class="fas fa-chevron-right"></i> Câu Hỏi Thường Gặp</a></li>
        </ul>
        </div>
        </div>
        </div>

        <div class="footer-bottom-bar">
        <i class="far fa-copyright"></i> 2025 StyleEra. All rights reserved.
        </div>
        </footer>