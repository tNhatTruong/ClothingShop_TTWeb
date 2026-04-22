package com.clothingshop.styleera.filter;

import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.service.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; // Cần thêm import này
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "GlobalDataFilter", urlPatterns = {"/*"})
public class GlobalDataFilter implements Filter {

    private final CategoryService categoryService = new CategoryService();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response; // Ép kiểu sang HttpServletResponse
        String path = req.getRequestURI();

        // Setup biến 'root' để dùng trong JSP
        request.setAttribute("root", req.getContextPath());

        // 1. Tối ưu: Bỏ qua file tĩnh (CSS, JS, Ảnh...)
        // Những file này KHÔNG cần chặn cache (để web load nhanh)
        if (path.endsWith(".css") || path.endsWith(".js") ||
                path.endsWith(".png") || path.endsWith(".jpg") ||
                path.endsWith(".jpeg") || path.endsWith(".woff2") ||
                path.endsWith(".gif") || path.endsWith(".avif")) {

            chain.doFilter(request, response);
            return;
        }

        // 2. QUAN TRỌNG: Chặn Cache trình duyệt cho các trang JSP/Servlet
        // Đoạn này giúp khi Back lại sau khi Logout, trình duyệt buộc phải tải lại trang từ Server
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        res.setHeader("Pragma", "no-cache"); // HTTP 1.0
        res.setDateHeader("Expires", 0); // Proxies

        // 3. Load Menu Categories (chỉ load khi chưa có)
        if (request.getAttribute("parents") == null) {
            try {
                List<ParentCategory> listCategories = categoryService.getAllCategories();
                request.setAttribute("parents", listCategories);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        chain.doFilter(request, response);
    }
}