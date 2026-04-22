package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.service.ProductService;
import com.clothingshop.styleera.service.VariantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product_detail"})
public class ProductDetailController extends HttpServlet {

    private ProductService productService;
    private VariantService variantService;

    @Override
    public void init() throws ServletException {
        this.productService = new ProductService();
        this.variantService = new VariantService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam);

            // 1. Lấy thông tin sản phẩm (Dùng model Product chuẩn)
            Product product = productService.findById(productId);

            if (product != null) {
                // 2. Lấy các dữ liệu phụ
                List<String> imageList = productService.getImagesByProductId(productId);
                List<Variants> variantList = productService.getVariantsByProductId(productId);
                List<String> colorList = productService.getColorsByProductId(productId);

                // Lấy sản phẩm liên quan (nếu có sub-category)
                List<Product> relatedProducts = null;
                // Lưu ý: Logic này phụ thuộc vào việc query findById có join bảng subcategory hay không
                // Nếu product.getCategory_sub_id() > 0 thì gọi related
                if(product.getCategory_sub_id() > 0) { // Giả sử bạn đã thêm getter này vào Model Product hoặc lấy từ DB
                    relatedProducts = productService.getRelatedProducts(product.getCategory_sub_id(), productId);
                }

                // Xử lý variant mặc định
                Integer defaultVariantId = variantService.getDefaultVariantId(productId);
                product.setDefaultVariantId(defaultVariantId);

                // 3. Đẩy dữ liệu ra JSP
                request.setAttribute("product", product);
                request.setAttribute("imageList", imageList);
                request.setAttribute("variantList", variantList);
                request.setAttribute("colorList", colorList);
                request.setAttribute("relatedProducts", relatedProducts);

                request.getRequestDispatcher("/views/pages/product_detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống");
        }
    }
}