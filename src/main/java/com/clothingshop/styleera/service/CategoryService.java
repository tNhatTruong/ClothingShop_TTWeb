package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.CategoryDAO;
import com.clothingshop.styleera.model.ParentCategory;

import java.util.List;

public class CategoryService {
    private CategoryDAO categoryDAO = new CategoryDAO();

    public List<ParentCategory> getAllCategories() {
        return categoryDAO.getAllParentCategoriesWithSubs();
    }
    // xoá danh mục dựa vào subId parentcategory
    public void deleteSubCategory(int subId) {
        categoryDAO.deleteSubCategory(subId);
    }
    // thống kê danh mục cha
    public List<ParentCategory> getParentCategoryStats() {
        return categoryDAO.getParentCategoryStats();
    }

    // xử lý bộ lọc Danh Mục theo phân loại và tên danh mục
    public List<ParentCategory> filterCategories(String parentCategory, String subCategory) {
        List<ParentCategory> allCategories = getAllCategories();

        // Nếu không có trả về tất cả
        if ((parentCategory == null || parentCategory.isEmpty()) && (subCategory == null || subCategory.isEmpty())) {
            return allCategories;
        }
        // Lọc dữ liệu
        for (ParentCategory parent : allCategories) {
            parent.getSubCategories().removeIf(sub -> {
                boolean keepSubCategory = true;
                // Lọc theo ParentCategory
                if (parentCategory != null && !parentCategory.isEmpty()) {
                    if (!parent.getName().equals(parentCategory)) {
                        keepSubCategory = false;
                    }
                }
                // Lọc theo Subcategory
                if (keepSubCategory && subCategory != null && !subCategory.isEmpty()) {
                    if (!sub.getName().equalsIgnoreCase(subCategory)) {
                        keepSubCategory = false;
                    }
                }
                return !keepSubCategory;
            });
        }

        allCategories.removeIf(parent -> parent.getSubCategories().isEmpty());

        return allCategories;
    }

}
