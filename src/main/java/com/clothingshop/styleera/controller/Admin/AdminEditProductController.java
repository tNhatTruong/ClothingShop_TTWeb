package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ProductDAO;
import com.clothingshop.styleera.dao.ImageDao;
import com.clothingshop.styleera.model.Image;
import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.model.SubCategory;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.service.CategoryService;
import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet(name = "AdminEditProductController", value = "/AdminEditProduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminEditProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                idStr = request.getParameter("productId");
            }

            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin-products");
                return;
            }

            int productId = Integer.parseInt(idStr);
            ProductService productService = new ProductService();
            CategoryService categoryService = new CategoryService();
            ImageDao imageDao = new ImageDao();

            Product product = productService.getProductEditById(productId);
            List<Variants> variants = productService.getVariantsByProductId(productId);
            List<ParentCategory> parents = categoryService.getAllCategories();

            List<Image> productImages = imageDao.findByProductId(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin-products");
                return;
            }

            int totalQuantity = 0;
            if (variants != null && !variants.isEmpty()) {
                for (Variants v : variants) {
                    totalQuantity += v.getQuantity();
                }
                product.setVariants(variants);
            }

            request.setAttribute("parents", parents);
            request.setAttribute("product", product);
            request.setAttribute("totalQuantity", totalQuantity);
            request.setAttribute("productImages", productImages);

            request.getRequestDispatcher("/admin/admin-form.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        ProductDAO productDAO = new ProductDAO();
        ImageDao imageDao = new ImageDao();

        // Khai báo biến giữ ID phục vụ cho catch block điều hướng khi xảy ra sự cố lỗi
        int errorRedirectId = -1;

        try {
            // Lấy ngay giá trị ID thực tế và gán vào một biến hiệu dụng hằng (effectively final)
            final int productId = Integer.parseInt(request.getParameter("productId"));
            errorRedirectId = productId;

            int subCategoryId = Integer.parseInt(request.getParameter("subCategoryId"));
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            String shortDesc = request.getParameter("short_desc");
            String detailDesc = request.getParameter("detail_desc");

            SubCategory sub = new SubCategory();
            sub.setId(subCategoryId);

            Product product = new Product();
            product.setProduct_id(productId);
            product.setProduct_name(productName);
            product.setPrice(price);
            product.setShort_description(shortDesc);
            product.setDetail_description(detailDesc);
            product.setSubcategory(sub);

            // 1. Cập nhật thông tin cơ bản sản phẩm
            productDAO.updateProducts(product);

            // 2. Cập nhật / Thêm / Xóa Biến thể đồng bộ
            String[] variantIds = request.getParameterValues("variantId");
            String[] sizes = request.getParameterValues("size");
            String[] colors = request.getParameterValues("color");
            String[] quantities = request.getParameterValues("quantity");

            if (variantIds != null && sizes != null && colors != null && quantities != null) {
                List<Variants> currentDbVariants = productDAO.findVariantsByProductId(productId);
                List<Integer> submittedVariantIds = new ArrayList<>();

                int safeLength = Math.min(
                        Math.min(variantIds.length, sizes.length),
                        Math.min(colors.length, quantities.length)
                );

                for (int i = 0; i < safeLength; i++) {
                    int vId = Integer.parseInt(variantIds[i]);
                    String size = sizes[i];
                    String color = colors[i];
                    int qty = Integer.parseInt(quantities[i]);

                    if (vId == 0) {
                        productDAO.addVariant(productId, size, color, qty);
                    } else {
                        productDAO.updateVariant(vId, size, color, qty);
                        submittedVariantIds.add(vId); // Giữ lại ID biến thể cũ
                    }
                }

                // Xóa những biến thể bị admin gỡ khỏi giao diện
                for (Variants dbV : currentDbVariants) {
                    if (!submittedVariantIds.contains(dbV.getVariantId())) {
                        productDAO.deleteVariantById(dbV.getVariantId());
                    }
                }
            }

            // 3. Xử lý xóa các ảnh được Admin chọn xóa trên giao diện
            String[] deletedImageIds = request.getParameterValues("deletedImageIds");
            if (deletedImageIds != null) {
                for (String imgIdStr : deletedImageIds) {
                    if (imgIdStr != null && !imgIdStr.trim().isEmpty()) {
                        int imgId = Integer.parseInt(imgIdStr);
                        productDAO.deleteProductImageById(imgId);
                    }
                }
            }

            // 4. Xử lý tải lên thêm nhiều ảnh mới (Nút chọn tệp đa file)
            Collection<Part> parts = request.getParts();
            String uploadPath = request.getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            for (Part part : parts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String imageName = part.getSubmittedFileName();
                    if (imageName != null && !imageName.isEmpty()) {
                        String filePath = uploadPath + File.separator + imageName;
                        part.write(filePath);

                        String imagePath = "/images/" + imageName;
                        productDAO.addProductImage(productId, imageName, imagePath);
                    }
                }
            }

            // 5. Kiểm tra bằng ImageDao và cập nhật lại Thumbnail nếu bị trống ảnh đại diện chính
            List<Image> remainImages = imageDao.findByProductId(productId);
            if (!remainImages.isEmpty()) {

                // Truy vấn xem trường image_id hiện tại của sản phẩm có NULL hoặc bằng 0 không
                Integer currentImageId = com.clothingshop.styleera.JDBiConnector.JDBIConnector.getJdbi().withHandle(h ->
                        h.createQuery("SELECT image_id FROM products WHERE id = :pId")
                                .bind("pId", productId)
                                .mapTo(Integer.class)
                                .findOne()
                                .orElse(null)
                );

                // Nếu sản phẩm bị trống ảnh đại diện, lấy ID ảnh đầu tiên còn sót lại trong danh sách Model Image điền vào
                if (currentImageId == null || currentImageId == 0) {
                    int fallbackImgId = remainImages.get(0).getImageId();

                    com.clothingshop.styleera.JDBiConnector.JDBIConnector.getJdbi().useHandle(h ->
                            h.createUpdate("UPDATE products SET image_id = :imgId WHERE id = :pId")
                                    .bind("imgId", fallbackImgId)
                                    .bind("pId", productId)
                                    .execute()
                    );
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
            response.sendRedirect(request.getContextPath() + "/admin-products");

        } catch (Exception e) {
            e.printStackTrace();

            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình cập nhật!");
            if (errorRedirectId != -1) {
                response.sendRedirect(request.getContextPath() + "/AdminEditProduct?id=" + errorRedirectId);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-products");
            }
        }
    }
}