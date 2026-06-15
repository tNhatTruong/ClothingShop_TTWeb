package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

@WebServlet(name = "AdminAddProduct", value = "/AdminAddProduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminAddProduct extends HttpServlet {

    private String uploadPath;

    @Override
    public void init() throws ServletException {
        Properties properties = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                properties.load(input);
                this.uploadPath = properties.getProperty("upload.directory");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (this.uploadPath == null || this.uploadPath.trim().isEmpty()) {
            this.uploadPath = "D:/ttweb/ClothingShop/src/main/webapp/images";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/admin-add-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy thông tin cơ bản
        String name = request.getParameter("productName");
        int subId = Integer.parseInt(request.getParameter("subCategoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        String shortDesc = request.getParameter("short_desc");
        String detailDesc = request.getParameter("detail_desc");

        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");
        String[] quantities = request.getParameterValues("quantity");

        // Xử lý lưu đa file ảnh
        File uploadDir = new File(this.uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        List<String> listImageNames = new ArrayList<>();
        List<String> listImagePaths = new ArrayList<>();

        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String imageName = part.getSubmittedFileName();
                if (imageName != null && !imageName.isEmpty()) {

                    String uniqueImageName = System.currentTimeMillis() + "_" + imageName;

                    // Tạo đối tượng Path tuyệt đối đến thư mục ngoài
                    java.nio.file.Path targetPath = Paths.get(this.uploadPath).resolve(uniqueImageName);

                    // Ghi trực tiếp luồng dữ liệu (InputStream) vào ổ cứng ngoài, không qua trung gian Tomcat
                    try (InputStream fileContent = part.getInputStream()) {
                        Files.copy(fileContent, targetPath, StandardCopyOption.REPLACE_EXISTING);
                    }

                    // Đường dẫn ảo dùng hiển thị ảnh trên JSP
                    String imagePath = request.getContextPath() + "/uploads/" + uniqueImageName;

                    listImageNames.add(uniqueImageName);
                    listImagePaths.add(imagePath);
                }
            }
        }

        ProductService service = new ProductService();
        service.addProduct(
                name, subId, price,
                shortDesc, detailDesc,
                sizes, colors, quantities,
                listImageNames, listImagePaths
        );

        response.sendRedirect(request.getContextPath() + "/admin-products");
    }
}