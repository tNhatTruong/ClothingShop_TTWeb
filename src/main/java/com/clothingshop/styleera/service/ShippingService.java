package com.clothingshop.styleera.service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

public class ShippingService {

    private String token;
    private String shopId;
    private String apiUrl;

    public ShippingService() {
        try {
            Properties prop = new Properties();
            // Đọc file config.properties từ thư mục src/main/resources
            InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties");

            if (input != null) {
                prop.load(input);
                this.token = prop.getProperty("ghn.api.token");
                this.shopId = prop.getProperty("ghn.api.shopId");
                this.apiUrl = prop.getProperty("ghn.api.url");
            } else {
                System.err.println(" Lỗi: Không tìm thấy file config.properties trong resources!");
            }
        } catch (Exception e) {
            System.err.println(" Lỗi khi đọc file cấu hình: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public long calculateShippingFee(int toDistrictId, String toWardCode, int weightInGrams) throws Exception {

        // Khởi tạo URL và Connection sử dụng biến đã đọc từ file
        URL url = new URL(this.apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Token", this.token);
        conn.setRequestProperty("ShopId", this.shopId);
        conn.setDoOutput(true);

        // Tạo body JSON gửi lên GHN
        String jsonInputString = String.format(
                "{\"service_type_id\": 2, \"to_district_id\": %d, \"to_ward_code\": \"%s\", \"weight\": %d}",
                toDistrictId, toWardCode, weightInGrams
        );

        // Gửi Request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] inputBytes = jsonInputString.getBytes("utf-8");
            os.write(inputBytes, 0, inputBytes.length);
        }

        // Đọc Response trả về
        int responseCode = conn.getResponseCode();
        BufferedReader br;
        if (responseCode >= 200 && responseCode <= 299) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
        }

        StringBuilder response = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) {
            response.append(responseLine.trim());
        }

        // Parse JSON lấy cước phí
        JsonObject jsonObject = JsonParser.parseString(response.toString()).getAsJsonObject();

        if (jsonObject.get("code").getAsInt() == 200) {
            // Trả về số tiền "total"
            return jsonObject.getAsJsonObject("data").get("total").getAsLong();
        } else {
            throw new Exception(jsonObject.get("message").getAsString());
        }
    }
}