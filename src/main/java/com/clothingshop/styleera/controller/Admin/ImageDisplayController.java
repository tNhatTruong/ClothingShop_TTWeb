package com.clothingshop.styleera.controller.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Properties;

@WebServlet(name = "ImageDisplayController", urlPatterns = { "/uploads/*" })
public class ImageDisplayController extends HttpServlet {

    private String uploadPath;

    @Override
    public void init() throws ServletException {
        // Tự động đọc đường dẫn từ file config.properties
        Properties properties = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                properties.load(input);
                this.uploadPath = properties.getProperty("upload.directory");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestedImage = request.getPathInfo();

        if (requestedImage == null || requestedImage.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Chỉ định file đích nằm trong thư mục được cấu hình động
        File targetFile = new File(this.uploadPath, requestedImage);

        // Bọc lót trường hợp file không tồn tại: Trả về ảnh no-image.png
        if (!targetFile.exists() || targetFile.isDirectory()) {
            targetFile = new File(this.uploadPath, "no-image.png");
        }

        // Nếu ngay cả file no-image.png trong thư mục images bạn cũng chưa có
        if (!targetFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Xuất dữ liệu byte ảnh ra luồng phản hồi mạng
        String contentType = getServletContext().getMimeType(targetFile.getName());
        if (contentType == null) {
            contentType = "image/jpeg";
        }
        response.setContentType(contentType);
        Files.copy(targetFile.toPath(), response.getOutputStream());
    }
}