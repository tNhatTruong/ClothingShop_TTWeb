package com.clothingshop.styleera.controller.Admin;

import com.clothingshop.styleera.dao.ProductDAO;
import com.clothingshop.styleera.model.Variants;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/admin/product-variants")
public class AdminProductVariantsApiController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("[]");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO productDAO = new ProductDAO();
            List<Variants> variantsList = productDAO.findVariantsByProductId(productId);

            JsonArray jsonArray = new JsonArray();
            if (variantsList != null) {
                for (Variants v : variantsList) {
                    JsonObject jo = new JsonObject();
                    jo.addProperty("variantId", v.getVariantId());
                    jo.addProperty("color", v.getColor());
                    jo.addProperty("size", v.getSize());
                    jo.addProperty("quantity", v.getQuantity());
                    jsonArray.add(jo);
                }
            }

            response.getWriter().write(new Gson().toJson(jsonArray));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }
}
