package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.CategoryDAO;
import com.clothingshop.styleera.model.SubCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Properties;

@WebServlet("/AdminCategoryAction")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class AdminCategoryAction extends HttpServlet {

    private String uploadDir;

    @Override
    public void init() throws ServletException {
        Properties prop = new Properties();

        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                throw new ServletException("Không tìm thấy file cấu hình!");
            }
            prop.load(input);
            uploadDir = prop.getProperty("uploadPath");
        } catch (IOException ex) {
            throw new ServletException("Lỗi khi đọc file cấu hình", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String idStr = request.getParameter("subCategoryId");
        String parentIdStr = request.getParameter("parentId");
        String name = request.getParameter("subCategoryName");
        String description = request.getParameter("description");
        String isImageDeleted = request.getParameter("isImageDeleted");

        // Khởi tạo DAO
        CategoryDAO categoryDAO = new CategoryDAO();

        if ("update".equals(action)) {
            int subId = Integer.parseInt(idStr);
            int parentId = Integer.parseInt(parentIdStr);

            // Lấy ảnh cũ từ DB để dự phòng nếu người dùng không upload ảnh mới
            SubCategory oldSubCategory = categoryDAO.getSubCategoryById(subId);
            String finalImagePath = (oldSubCategory != null && oldSubCategory.getImage() != null)
                    ? oldSubCategory.getImage() : "";

            // Nếu người dùng bấm dấu X trên giao diện để xóa ảnh
            if ("true".equals(isImageDeleted)) {
                finalImagePath = "";
            }

            // Nếu người dùng upload file mới (đè lên ảnh cũ hoặc thêm ảnh mới)
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

                // Lưu vào thư mục Tomcat đang chạy (Hiển thị ngay lập tức)
                String serverPath = request.getServletContext().getRealPath("/images");
                File serverDir = new File(serverPath);
                if (!serverDir.exists()) serverDir.mkdirs();

                String serverFilePath = serverPath + File.separator + uniqueFileName;
                filePart.write(serverFilePath); // Ghi file thẳng vào server

                // Copy từ Tomcat về thư mục Source Code (Để tắt server không mất ảnh)
                File sourceDir = new File(uploadDir);
                if (!sourceDir.exists()) sourceDir.mkdirs();

                try {
                    Files.copy(
                            Paths.get(serverFilePath),
                            Paths.get(uploadDir + File.separator + uniqueFileName),
                            StandardCopyOption.REPLACE_EXISTING
                    );
                } catch (Exception e) {
                    System.out.println("Lỗi backup ảnh update: " + e.getMessage());
                }

                finalImagePath = "/images/" + uniqueFileName;
            }

            // Gọi DAO để lưu vào Database
            categoryDAO.updateSubCategory(subId, parentId, name, description, finalImagePath);

            // Thông báo Toast thành công
            request.getSession().setAttribute("toastMessage", "Cập nhật danh mục thành công!");

            // Trở về trang danh sách
            response.sendRedirect(request.getContextPath() + "/admin-category");

        } else if ("add".equals(action)) {
            int parentId = Integer.parseInt(parentIdStr);
            String finalImagePath = "";

            // Xử lý upload ảnh cho phần thêm mới
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

                // Lưu vào thư mục Tomcat đang chạy
                String serverPath = request.getServletContext().getRealPath("/images");
                File serverDir = new File(serverPath);
                if (!serverDir.exists()) serverDir.mkdirs();

                String serverFilePath = serverPath + File.separator + uniqueFileName;
                filePart.write(serverFilePath);

                // Copy về thư mục Source Code
                File sourceDir = new File(uploadDir);
                if (!sourceDir.exists()) sourceDir.mkdirs();

                try {
                    Files.copy(
                            Paths.get(serverFilePath),
                            Paths.get(uploadDir + File.separator + uniqueFileName),
                            StandardCopyOption.REPLACE_EXISTING
                    );
                } catch (Exception e) {
                    System.out.println("Lỗi backup ảnh add: " + e.getMessage());
                }

                finalImagePath = "/images/" + uniqueFileName;
            }

            // Gọi DAO để insert vào Database
            categoryDAO.addSubCategory(parentId, name, description, finalImagePath);

            // Thông báo Toast thành công cho phần Thêm Mới
            request.getSession().setAttribute("toastMessage", "Thêm danh mục mới thành công!");

            response.sendRedirect(request.getContextPath() + "/admin-category");
        }
    }
}