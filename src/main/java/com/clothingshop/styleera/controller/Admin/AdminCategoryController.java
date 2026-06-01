package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.service.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryController", urlPatterns = "/admin-category")
public class AdminCategoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();

        String parentCategory = request.getParameter("parentCategory");
        String subCategory = request.getParameter("subCategory");
        String search = request.getParameter("search");

        // Lấy tất cả danh mục để hiển thị
        List<ParentCategory> allCategories = categoryService.getAllCategories();
        request.setAttribute("parentCategoryList", allCategories);

        // Lọc dữ liệu theo bộ lọc và từ khóa tìm kiếm
        List<ParentCategory> filteredList = categoryService.filterCategories(parentCategory, subCategory, search);

        request.setAttribute("filteredCategoryList", filteredList);
        request.setAttribute("parentCategoryValue", parentCategory != null ? parentCategory : "");
        request.setAttribute("subCategoryValue", subCategory != null ? subCategory : "");
        request.setAttribute("searchValue", search != null ? search : "");

        request.getRequestDispatcher("admin/admin-category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}