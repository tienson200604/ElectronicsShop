package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    // Dữ liệu kết nối (Kiểm tra lại 3 tham số này!)
    private static final String URL = "jdbc:mysql://localhost:3306/electronics_shop?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; // Thay đổi nếu bạn có mật khẩu khác
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Lỗi Driver: Không tìm thấy JDBC Driver.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Lỗi SQL: Không thể kết nối DB hoặc thông tin đăng nhập sai.");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Phương thức kiểm tra kết nối
    public static void main(String[] args) {
        Connection testConn = getConnection();
        if (testConn != null) {
            System.out.println("✅ Kết nối Database thành công!");
            try {
                testConn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ Kết nối Database thất bại.");
        }
    }
}