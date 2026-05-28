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
        String priceRangeParam = request.getParameter("priceRange");

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
            List<Product> baseList;

            // BƯỚC 1: LẤY DANH SÁCH GỐC (Tìm kiếm hoặc Danh mục)
            if (searchParam != null && !searchParam.isEmpty()) {
                baseList = productService.findAll();
                if (baseList != null) {
                    baseList.removeIf(p -> p.getProduct_name() == null ||
                            !p.getProduct_name().toLowerCase().contains(searchParam.toLowerCase()));
                }
                title = "Kết quả tìm kiếm: " + searchParam;
            }
            else if (cateIdParam != null && !cateIdParam.isEmpty()) {
                int cateId = Integer.parseInt(cateIdParam);
                baseList = productService.findBySubCategoryId(cateId);
                title = categoryDAO.getSubNameById(cateId);
            }
            else if (parentIdParam != null && !parentIdParam.isEmpty()) {
                int parentId = Integer.parseInt(parentIdParam);
                baseList = productService.findByParentCategoryId(parentId);
                title = categoryDAO.getParentNameById(parentId);
            }
            else {
                baseList = productService.findAll();
            }

            // Bọc vào ArrayList mới để có thể chỉnh sửa
            fullList = (baseList != null) ? new ArrayList<>(baseList) : new ArrayList<>();

            // BƯỚC 2: LỌC TIẾP THEO GIÁ
            if (priceRangeParam != null && !priceRangeParam.isEmpty()) {
                int rangeType = Integer.parseInt(priceRangeParam);
                fullList.removeIf(p -> {
                    double price = p.getPrice();
                    if (rangeType == 1) return price >= 200000;
                    if (rangeType == 2) return (price < 200000 || price > 500000);
                    if (rangeType == 3) return price <= 500000;
                    return false;
                });
                title += " - Lọc theo giá";
            }

            // BƯỚC 3: SẮP XẾP DANH SÁCH
            if (sortParam != null && !sortParam.isEmpty()) {
                if (sortParam.equals("price_asc")) {
                    fullList.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
                } else if (sortParam.equals("price_desc")) {
                    fullList.sort((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
                } else if (sortParam.equals("newest") || sortParam.equals("bestseller")) {
                    fullList.sort((p1, p2) -> Integer.compare(p2.getProduct_id(), p1.getProduct_id()));
                }
            }

        } catch (NumberFormatException e) {
            fullList = (productService.findAll() != null) ? new ArrayList<>(productService.findAll()) : new ArrayList<>();
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
        request.setAttribute("currentPriceRange", priceRangeParam);

        request.setAttribute("listSizes", variantDAO.getAllSizes());
        request.setAttribute("listColors", variantDAO.getAllColors());

        request.getRequestDispatcher("/views/pages/product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiện tại chưa xử lý POST
    }
}