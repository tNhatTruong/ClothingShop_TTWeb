package com.clothingshop.styleera.util;

import com.clothingshop.styleera.model.Google;
import com.google.gson.Gson;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class GoogleUtils {

    // Khai báo biến static (không gán giá trị cứng nữa)
    public static final String GOOGLE_CLIENT_ID;
    public static final String GOOGLE_CLIENT_SECRET;
    public static final String GOOGLE_REDIRECT_URI;
    public static final String GOOGLE_LINK_GET_TOKEN;
    public static final String GOOGLE_LINK_GET_USER_INFO;
    public static final String GOOGLE_GRANT_TYPE;

    // Khối static này sẽ chạy ĐẦU TIÊN khi class được gọi
    static {
        Properties props = new Properties();
        try (InputStream input = GoogleUtils.class.getClassLoader().getResourceAsStream("google.properties")) {
            if (input == null) {
                throw new RuntimeException("Không tìm thấy file google.properties");
            }
            props.load(input);
        } catch (IOException e) {
            throw new RuntimeException("Lỗi đọc file cấu hình Google", e);
        }

        // Gán giá trị đọc được từ file vào biến Java
        GOOGLE_CLIENT_ID = props.getProperty("google.client.id");
        GOOGLE_CLIENT_SECRET = props.getProperty("google.client.secret");
        GOOGLE_REDIRECT_URI = props.getProperty("google.redirect.uri");
        GOOGLE_LINK_GET_TOKEN = props.getProperty("google.link.get.token");
        GOOGLE_LINK_GET_USER_INFO = props.getProperty("google.link.get.user.info");
        GOOGLE_GRANT_TYPE = props.getProperty("google.grant.type");
    }

    // ... Các hàm getToken và getUserInfo giữ nguyên như cũ ...
    public String getToken(final String code) throws ClientProtocolException, IOException {
        // Code cũ giữ nguyên, nó sẽ tự dùng biến GOOGLE_CLIENT_ID đã được nạp ở trên
        String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", GOOGLE_CLIENT_ID)
                        .add("client_secret", GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", GOOGLE_GRANT_TYPE)
                        .build())
                .execute().returnContent().asString();

        Gson gson = new Gson();
        TokenPojo token = gson.fromJson(response, TokenPojo.class);
        return token.getAccess_token();
    }

    public Google getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, Google.class);
    }

    private class TokenPojo {
        private String access_token;
        public String getAccess_token() { return access_token; }
    }
}