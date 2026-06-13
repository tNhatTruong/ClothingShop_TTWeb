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
import java.nio.file.Paths;
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
            uploadDir = prop.getProperty("upload.directory");
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

            // 1. Lấy ảnh cũ từ DB để dự phòng nếu người dùng không upload ảnh mới
            SubCategory oldSubCategory = categoryDAO.getSubCategoryById(subId);
            String finalImagePath = (oldSubCategory != null && oldSubCategory.getImage() != null)
                    ? oldSubCategory.getImage() : "";

            // 2. Nếu người dùng bấm dấu X trên giao diện để xóa ảnh
            if ("true".equals(isImageDeleted)) {
                finalImagePath = "";
            }

            // 3. Nếu người dùng upload file mới (đè lên ảnh cũ hoặc thêm ảnh mới)
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileSavePath = uploadDir + File.separator + uniqueFileName;
                filePart.write(fileSavePath);

                finalImagePath = "/images/" + uniqueFileName;
            }

            // 4. Gọi DAO để lưu vào Database
            categoryDAO.updateSubCategory(subId, parentId, name, description, finalImagePath);
            request.getSession().setAttribute("toastMessage", "Cập nhật danh mục thành công!");
            // 5. Trở về trang danh sách
            response.sendRedirect(request.getContextPath() + "/admin-category");

        } else if ("add".equals(action)) {

            response.sendRedirect(request.getContextPath() + "/admin-category");
        }
    }
}