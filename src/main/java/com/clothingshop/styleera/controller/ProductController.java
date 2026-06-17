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
        String[] selectedSizes = request.getParameterValues("size");
        String[] selectedColors = request.getParameterValues("color");
        System.out.println("====== FILTER DEBUG ======");
        System.out.println("Sizes received: " + (selectedSizes != null ? java.util.Arrays.toString(selectedSizes) : "null"));
        System.out.println("Colors received: " + (selectedColors != null ? java.util.Arrays.toString(selectedColors) : "null"));

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

            // BƯỚC 2.5: LỌC THEO SIZE VÀ COLOR
            if ((selectedSizes != null && selectedSizes.length > 0) || (selectedColors != null && selectedColors.length > 0)) {
                fullList.removeIf(p -> {
                    if (p.getVariants() == null || p.getVariants().isEmpty()) {
                        return true; // Loại bỏ nếu sản phẩm không có biến thể nào
                    }
                    // Giữ lại sản phẩm nếu có ít nhất 1 biến thể khớp với tiêu chí Size và Color
                    boolean hasMatchingVariant = false;
                    for (com.clothingshop.styleera.model.Variants v : p.getVariants()) {
                        boolean matchSize = true;
                        boolean matchColor = true;

                        if (selectedSizes != null && selectedSizes.length > 0) {
                            matchSize = false;
                            for (String s : selectedSizes) {
                                if (s.equalsIgnoreCase(v.getSize())) {
                                    matchSize = true;
                                    break;
                                }
                            }
                        }

                        if (selectedColors != null && selectedColors.length > 0) {
                            matchColor = false;
                            for (String c : selectedColors) {
                                if (c.equalsIgnoreCase(v.getColor())) {
                                    matchColor = true;
                                    break;
                                }
                            }
                        }

                        if (matchSize && matchColor) {
                            hasMatchingVariant = true;
                            break;
                        }
                    }
                    return !hasMatchingVariant; // Xóa nếu không có biến thể nào khớp
                });
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
            System.out.println("====== EXCEPTION CAUGHT ======");
            e.printStackTrace();
            fullList = (productService.findAll() != null) ? new ArrayList<>(productService.findAll()) : new ArrayList<>();
        }

        // 4. XỬ LÝ PHÂN TRANG (PAGINATION LOGIC)
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

        java.util.List<String> currentSizes = new ArrayList<>();
        if (selectedSizes != null) {
            for (String s : selectedSizes) currentSizes.add(s);
        }
        request.setAttribute("currentSizes", currentSizes);

        java.util.List<String> currentColors = new ArrayList<>();
        if (selectedColors != null) {
            for (String c : selectedColors) currentColors.add(c);
        }
        request.setAttribute("currentColors", currentColors);

        request.setAttribute("listSizes", variantDAO.getAllSizes());
        request.setAttribute("listColors", variantDAO.getAllColors());

        request.getRequestDispatcher("/views/pages/product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiện tại chưa xử lý POST
    }
}