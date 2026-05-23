package com.clothingshop.styleera.JDBiConnector;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Properties;

public class JDBIConnector {
    private static Jdbi jdbi;

    // Singleton Pattern: Đảm bảo chỉ có duy nhất 1 instance Jdbi được tạo ra
    public static Jdbi getJdbi() {
        if (jdbi == null) {
            synchronized (JDBIConnector.class) {
                if (jdbi == null) {
                    connect();
                }
            }
        }
        return jdbi;
    }

    private static void connect() {
        Properties prop = new Properties();

        // Đọc file db.properties từ thư mục resources
        try (InputStream input = JDBIConnector.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Lỗi: Không tìm thấy file 'db.properties'. Hãy chắc chắn file này nằm trong thư mục 'src/main/resources'.");
            }
            prop.load(input);

            // Cấu hình Datasource từ thông tin trong file properties hoặc biến môi trường (Docker)
            MysqlDataSource dataSource = new MysqlDataSource();

            String dbUrl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : prop.getProperty("db.url");
            String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : prop.getProperty("db.username");
            String dbPass = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : prop.getProperty("db.password");

            dataSource.setUrl(dbUrl);
            dataSource.setUser(dbUser);
            dataSource.setPassword(dbPass);

            try {
                dataSource.setAutoReconnect(true);
                dataSource.setUseCompression(true);
            } catch (SQLException e) {
                throw new RuntimeException("Lỗi cấu hình MySQL DataSource: " + e.getMessage(), e);
            }

            // Tạo Jdbi instance
            jdbi = Jdbi.create(dataSource);

        } catch (IOException e) {
            throw new RuntimeException("Lỗi đọc file db.properties: " + e.getMessage(), e);
        }
    }

    public static void main(String[] args) {
        try {
            System.out.println("Đang thử kết nối Database...");
            Jdbi db = getJdbi();

            // Chạy thử câu lệnh SQL để kiểm tra
            String dbVersion = db.withHandle(handle ->
                    handle.createQuery("SELECT VERSION()").mapTo(String.class).one()
            );

            System.out.println("Kết nối THÀNH CÔNG!");
            System.out.println("Phiên bản MySQL: " + dbVersion);

        } catch (Exception e) {
            System.err.println("Kết nối THẤT BẠI: " + e.getMessage());
            e.printStackTrace();
        }
    }
}