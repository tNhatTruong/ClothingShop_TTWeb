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

        java.util.List<String> imageNames = new java.util.ArrayList<>();
        java.util.List<String> imagePaths = new java.util.ArrayList<>();
        
        for (Part part : request.getParts()) {
            if ("images".equals(part.getName()) && part.getSize() > 0) {
                if (imageNames.size() >= 15) {
                    break; // limit to 15 images max
                }
                String imgName = part.getSubmittedFileName();
                if (imgName != null && !imgName.isEmpty()) {
                    String uploadPath = request.getServletContext().getRealPath("/images");
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + java.io.File.separator + imgName;
                    part.write(filePath);
                    
                    imageNames.add(imgName);
                    imagePaths.add("/images/" + imgName);
                }
            }
        }

        ProductService service = new ProductService();
        service.addProduct(
                name, subId, price,
                shortDesc, detailDesc,
                size, color, quantity,
                imageNames, imagePaths
        );

        response.sendRedirect(request.getContextPath() + "/admin-products");
    }
}