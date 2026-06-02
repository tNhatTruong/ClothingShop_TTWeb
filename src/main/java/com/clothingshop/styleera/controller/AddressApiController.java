package com.clothingshop.styleera.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

@WebServlet({"/api/address/province", "/api/address/district", "/api/address/ward"})
public class AddressApiController extends HttpServlet {

    private String ghnToken = "";

    @Override
    public void init() throws ServletException {
        try {
            Properties prop = new Properties();
            InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties");
            if (input != null) {
                prop.load(input);
                this.ghnToken = prop.getProperty("ghn.api.token");
            } else {
                System.err.println("KHÔNG TÌM THẤY FILE config.properties");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String requestURI = request.getRequestURI();
            String targetUrl = "";

            if (requestURI.contains("/province")) {
                targetUrl = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province";
            } else if (requestURI.contains("/district")) {
                String provinceId = request.getParameter("province_id");
                targetUrl = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=" + provinceId;
            } else if (requestURI.contains("/ward")) {
                String districtId = request.getParameter("district_id");
                targetUrl = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=" + districtId;
            }

            URL url = java.net.URI.create(targetUrl).toURL();
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");

            // Gửi Token, nếu null thì gửi chuỗi rỗng để không bị NullPointerException
            conn.setRequestProperty("Token", this.ghnToken != null ? this.ghnToken : "");

            // Bắt HTTP Status Code từ GHN
            int responseCode = conn.getResponseCode();
            BufferedReader br;

            // Nếu thành công (200) thì đọc InputStream, nếu thất bại (401, 404, 500) thì đọc ErrorStream
            if (responseCode >= 200 && responseCode <= 299) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
            }

            StringBuilder jsonResponse = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                jsonResponse.append(responseLine.trim());
            }

            // Trả JSON về cho Javascript
            out.print(jsonResponse.toString());

        } catch (Exception e) {
            // Lỗi ở Java thì báo thẳng cho Javascript dạng JSON, thay vì sập server ra mã HTML
            e.printStackTrace();
            out.print("{\"code\": 500, \"message\": \"Lỗi Server Java: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }
}