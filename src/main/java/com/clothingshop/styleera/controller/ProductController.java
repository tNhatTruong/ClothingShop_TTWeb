package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.service.ProductService;
import com.clothingshop.styleera.service.VariantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Khởi tạo Service/DAO
        ProductService productService = new ProductService();
        com.clothingshop.styleera.dao.ProductDAO productDAO = new com.clothingshop.styleera.dao.ProductDAO();
        com.clothingshop.styleera.dao.CategoryDAO categoryDAO = new com.clothingshop.styleera.dao.CategoryDAO();
        com.clothingshop.styleera.dao.VariantDAO variantDAO = new com.clothingshop.styleera.dao.VariantDAO();
        VariantService variantService = new VariantService();

        List<Product> fullList = new ArrayList<>(); // Danh sách gốc đầy đủ
        String title = "Tất cả sản phẩm";

        // 2. Lấy tham số từ URL
        String parentIdParam = request.getParameter("parentId");
        String cateIdParam = request.getParameter("cateId");
        String sortParam = request.getParameter("sort");
        String searchParam = request.getParameter("search");

        // Lấy trang hiện tại
        String pageParam = request.getParameter("page");
        int page = 1; // Mặc định trang 1
        int pageSize = 9; // 9 sản phẩm mỗi trang
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        // 3. Logic lọc sản phẩm
        try {
            if (searchParam != null && !searchParam.isEmpty()) {
                // Xử lý tìm kiếm
                fullList = productService.findAll();

                title = "Kết quả tìm kiếm: " + searchParam;
            }
            else if (cateIdParam != null) {
                // Lọc theo danh mục con
                int cateId = Integer.parseInt(cateIdParam);
                fullList = productService.findBySubCategoryId(cateId);
                title = categoryDAO.getSubNameById(cateId);
            }
            else if (parentIdParam != null) {
                // Lọc theo danh mục cha
                int parentId = Integer.parseInt(parentIdParam);
                fullList = productService.findByParentCategoryId(parentId);
                title = categoryDAO.getParentNameById(parentId);
            }
            else if (sortParam != null) {
                // Sắp xếp
                fullList = productDAO.findAllSorted(sortParam);
                if(sortParam.equals("newest")) title = "Hàng Mới Về";
                else if(sortParam.equals("bestseller")) title = "Sản Phẩm Bán Chạy";
                else title = "Tất cả sản phẩm";
            }
            else {
                // Mặc định lấy tất cả
                fullList = productService.findAll();
            }
        } catch (NumberFormatException e) {
            fullList = productService.findAll();
        }

        // 4. XỬ LÝ PHÂN TRANG (PAGINATION LOGIC)
        // Nếu danh sách null, khởi tạo rỗng để tránh lỗi
        if (fullList == null) fullList = new ArrayList<>();

        int totalProducts = fullList.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Kiểm tra trang hợp lệ
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;

        // Tính vị trí cắt danh sách (subList)
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalProducts);

        // Lấy danh sách con cho trang hiện tại
        List<Product> productsForPage = new ArrayList<>();
        if (start <= end && totalProducts > 0) {
            productsForPage = fullList.subList(start, end);
        }

        // Set Default Variant cho danh sách trang hiện tại
        if (!productsForPage.isEmpty()) {
            for (Product p : productsForPage) {
                Integer defaultVariantId = variantService.getDefaultVariantId(p.getProduct_id());
                p.setDefaultVariantId(defaultVariantId);
            }
        }

        // 5. Đẩy dữ liệu ra JSP
        request.setAttribute("products", productsForPage); // Chỉ gửi 9 sản phẩm
        request.setAttribute("categoryTitle", title);

        // Dữ liệu hỗ trợ phân trang & bộ lọc
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentSort", sortParam);
        request.setAttribute("currentCate", cateIdParam);
        request.setAttribute("currentParent", parentIdParam);
        request.setAttribute("currentSearch", searchParam);

        request.setAttribute("listSizes", variantDAO.getAllSizes());
        request.setAttribute("listColors", variantDAO.getAllColors());

        request.getRequestDispatcher("/views/pages/product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiện tại chưa xử lý POST
    }
}