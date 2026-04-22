package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ProductDAO;
import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.model.Product;
import com.clothingshop.styleera.service.CategoryService;
import com.clothingshop.styleera.service.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryController", urlPatterns = "/admin-category")
public class AdminCategoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();

        String parentCategory = request.getParameter("parentCategory");
        String subCategory = request.getParameter("subCategory");
        
        // Lấy tất cả danh mục để hiển thị
        List<ParentCategory> allCategories = categoryService.getAllCategories();
        request.setAttribute("parentCategoryList", allCategories);
        
        // Nếu có filter, lọc dữ liệu
        List<ParentCategory> filteredList;
        if ((parentCategory != null && !parentCategory.isEmpty()) || (subCategory != null && !subCategory.isEmpty())) {
            filteredList = categoryService.filterCategories(parentCategory, subCategory);
        } else {
            filteredList = allCategories;
        }
        
        request.setAttribute("filteredCategoryList", filteredList);
        request.setAttribute("parentCategoryValue", parentCategory != null ? parentCategory : "");
        request.setAttribute("subCategoryValue", subCategory != null ? subCategory : "");
        
        request.getRequestDispatcher("admin/admin-category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}