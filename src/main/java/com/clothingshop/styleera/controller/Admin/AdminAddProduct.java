package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminAddProduct", value = "/AdminAddProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class AdminAddProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("productName");
        int subId = Integer.parseInt(request.getParameter("subCategoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        String shortDesc = request.getParameter("short_desc");
        String detailDesc = request.getParameter("detail_desc");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image");
        String imageName = "";
        String imagePath = "";

        if (filePart != null && filePart.getSize() > 0) {
            imageName = filePart.getSubmittedFileName();
            if (imageName != null && !imageName.isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/images");
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String filePath = uploadPath + java.io.File.separator + imageName;
                filePart.write(filePath);
                imagePath = "/images/" + imageName;
            }
        }

        ProductService service = new ProductService();
        service.addProduct(
                name, subId, price,
                shortDesc, detailDesc,
                size, color, quantity,
                imageName, imagePath
        );

        response.sendRedirect(request.getContextPath() + "/admin-products");
    }
}