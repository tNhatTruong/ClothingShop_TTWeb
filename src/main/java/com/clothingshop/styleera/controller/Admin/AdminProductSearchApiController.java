package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.VariantDAO;
import com.clothingshop.styleera.model.Variants;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/admin/search-product")
public class AdminProductSearchApiController extends HttpServlet {

    private final VariantDAO variantDAO = new VariantDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        Map<String, Object> result = new HashMap<>();

        try {
            if (keyword == null || keyword.trim().isEmpty()) {
                result.put("status", "error");
                result.put("message", "Keyword is empty");
            } else {
                List<Variants> variantsList = variantDAO.searchVariantsByKeyword(keyword.trim());
                result.put("status", "success");
                result.put("data", variantsList);
            }
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result.put("status", "error");
            result.put("message", "Internal server error: " + e.getMessage());
            response.getWriter().write(gson.toJson(result));
            e.printStackTrace();
        }
    }
}
