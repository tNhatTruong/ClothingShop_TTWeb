package com.clothingshop.styleera.util;

import java.io.InputStream;
import java.util.Properties;

public class VnPayConfig {
    public static String vnp_PayUrl;
    public static String vnp_ReturnUrl;
    public static String vnp_TmnCode;
    public static String vnp_HashSecret;
    public static String vnp_ApiUrl;

    static {
        try (InputStream input = VnPayConfig.class.getClassLoader().getResourceAsStream("vnpay.properties")) {
            Properties prop = new Properties();
            if (input != null) {
                prop.load(input);
                vnp_PayUrl = prop.getProperty("vnp_PayUrl");
                vnp_ReturnUrl = prop.getProperty("vnp_ReturnUrl");
                vnp_TmnCode = prop.getProperty("vnp_TmnCode");
                vnp_HashSecret = prop.getProperty("vnp_HashSecret");
                vnp_ApiUrl = prop.getProperty("vnp_ApiUrl");
            } else {
                System.out.println("Sorry, unable to find vnpay.properties");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
