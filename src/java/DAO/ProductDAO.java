package DAO;

import Model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

   // Phương thức ánh xạ ResultSet vào đối tượng Product
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setShortDescription(rs.getString("short_description"));
        
        // Lấy Category ID và Name
        // Chú ý: Các trường này phải được SELECT trong truy vấn SQL
        try {
            product.setCategoryId(rs.getInt("category_id"));
        } catch (SQLException e) {
             // Bỏ qua nếu category_id không có trong ResultSet (để tương thích)
        }
        try {
             product.setCategoryName(rs.getString("category_name"));
        } catch (SQLException e) {
             // Bỏ qua nếu category_name không có trong ResultSet
        }
        try { product.setDescription(rs.getString("description")); } catch (SQLException e) {}
    try { product.setWarrantyMonths(rs.getInt("warranty_months")); } catch (SQLException e) {}
    try { product.setBrandName(rs.getString("brandName")); } catch (SQLException e) {} // Lấy từ alias brandName

        // Gán giá và xử lý NULL
        product.setPrice(rs.getDouble("price"));
        double salePrice = rs.getDouble("sale_price");
        product.setSalePrice(rs.wasNull() ? 0 : salePrice); // Gán 0 nếu NULL

        // Xử lý ảnh mặc định
        String imageDbPath = rs.getString("image_path");
        product.setImagePath((imageDbPath == null || imageDbPath.isEmpty()) 
                                ? "img/default-product.png" 
                                : imageDbPath);
        
        return product;
    }

    public List<Product> getAllProducts() {
        // Phương thức này có thể được sử dụng trong HomeController
        List<Product> list = new ArrayList<>();
        // Đảm bảo truy vấn SELECT có p.category_id và c.name
        String query = "SELECT p.id, p.name, p.short_description, p.category_id, c.name AS category_name, "
                + "pp.price, pp.sale_price, pi_main.image_url AS image_path "
                + "FROM products p "
                + "JOIN categories c ON p.category_id = c.id "
                + "JOIN product_prices pp ON p.id = pp.product_id "
                + "LEFT JOIN product_images pi_main ON p.id = pi_main.product_id AND pi_main.is_main = 1 "
                + "WHERE p.is_active = 1 "
                + "ORDER BY p.id DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllProducts: ");
            e.printStackTrace();
        }
        return list;
    }
    
    // Phương thức lấy sản phẩm theo trạng thái (New, Featured, Top Selling) - KHÔNG PHÂN TRANG
    public List<Product> getProductsByStatus(String status, int limit) {
        List<Product> list = new ArrayList<>();
        String condition = "";
        String orderBy = "p.id DESC";
        
        switch (status.toLowerCase()) {
            case "new":
                condition = " AND p.is_new = 1 "; 
                orderBy = "p.created_at DESC"; 
                break;
            case "featured":
                condition = " AND p.is_featured = 1 ";
                break;
            case "topselling":
                condition = " AND p.is_top_selling = 1 ";
                break;
        }
        
        String query = "SELECT p.id, p.name, p.short_description, p.category_id, c.name AS category_name, "
                + "pp.price, pp.sale_price, pi_main.image_url AS image_path "
                + "FROM products p "
                + "JOIN categories c ON p.category_id = c.id "
                + "JOIN product_prices pp ON p.id = pp.product_id "
                + "LEFT JOIN product_images pi_main ON p.id = pi_main.product_id AND pi_main.is_main = 1 "
                + "WHERE p.is_active = 1 "
                + condition
                + "ORDER BY " + orderBy
                + " LIMIT ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getProductsByStatus: " + status);
            e.printStackTrace();
        }
        return list;
    }

    public int countAllProducts() {
        String sql = "SELECT COUNT(DISTINCT p.id) AS total FROM products p WHERE p.is_active = 1";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductsByPage(int offset, int limit) {
        List<Product> list = new ArrayList<>();

        String query = "SELECT "
                + "p.id, p.name, p.short_description, pp.price, pp.sale_price, "
                + "pi_main.image_url AS image_path "
                + "FROM products p "
                + "JOIN product_prices pp ON p.id = pp.product_id "
                + "LEFT JOIN product_images pi_main ON p.id = pi_main.product_id AND pi_main.is_main = 1 "
                + "WHERE p.is_active = 1 "
                + "GROUP BY p.id, p.name, p.short_description, pp.price, pp.sale_price, pi_main.image_url "
                + "ORDER BY p.id DESC "
                + "LIMIT ?, ?";       // MySQL

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, offset);
            ps.setInt(2, limit);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setShortDescription(rs.getString("short_description"));

                    product.setPrice(rs.getDouble("price"));
                    double salePrice = rs.getDouble("sale_price");
                    product.setSalePrice(rs.wasNull() ? 0 : salePrice);

                    String imageDbPath = rs.getString("image_path");
                    product.setImagePath(
                            (imageDbPath == null || imageDbPath.isEmpty())
                            ? "img/default-product.png"
                            : imageDbPath
                    );

                    list.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    // PHƯƠNG THỨC ĐẾM SẢN PHẨM (MỞ RỘNG THÊM TRẠNG THÁI 'STATUS' CHO BESTSELLER)
    public int countProducts(String keyword, Double maxPrice, Integer categoryId, String status) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(DISTINCT p.id) AS total " +
            "FROM products p " +
            "JOIN product_prices pp ON p.id = pp.product_id " +
            "WHERE p.is_active = 1"
        );

        List<Object> params = new ArrayList<>();

        if (categoryId != null) {
            sql.append(" AND p.category_id = ?");
            params.add(categoryId);
        }
        
        if ("topselling".equals(status)) {
            sql.append(" AND p.is_top_selling = 1"); // Giả định cột is_top_selling tồn tại
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (maxPrice != null) {
            sql.append(" AND (CASE " +
                        "WHEN pp.sale_price IS NOT NULL AND pp.sale_price > 0 THEN pp.sale_price " +
                        "ELSE pp.price END) <= ?");
            params.add(maxPrice);
        }

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


public List<Product> getProducts(String keyword, Double maxPrice,
                                     String sort, Integer categoryId,
                                     int offset, int limit, String status) {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT p.id, p.name, p.short_description, p.category_id, c.name AS category_name, " + // THÊM category_id, category_name
            "pp.price, pp.sale_price, " +
            "pi_main.image_url AS image_path, " +
            "(CASE " +
            "WHEN pp.sale_price IS NOT NULL AND pp.sale_price > 0 THEN pp.sale_price " +
            "ELSE pp.price END) AS effective_price " +
            "FROM products p " +
            "JOIN categories c ON p.category_id = c.id " +
            "JOIN product_prices pp ON p.id = pp.product_id " +
            "LEFT JOIN product_images pi_main " +
            "ON p.id = pi_main.product_id AND pi_main.is_main = 1 " +
            "WHERE p.is_active = 1"
        );

        List<Object> params = new ArrayList<>();

        if (categoryId != null) {
            sql.append(" AND p.category_id = ?");
            params.add(categoryId);
        }
        
        if ("topselling".equals(status)) {
            sql.append(" AND p.is_top_selling = 1"); 
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (maxPrice != null) {
            sql.append(" AND (CASE " +
                        "WHEN pp.sale_price IS NOT NULL AND pp.sale_price > 0 THEN pp.sale_price " +
                        "ELSE pp.price END) <= ?");
            params.add(maxPrice);
        }

        if ("priceAsc".equals(sort)) {
            sql.append(" ORDER BY effective_price ASC");
        } else if ("priceDesc".equals(sort)) {
            sql.append(" ORDER BY effective_price DESC");
        } else {
            sql.append(" ORDER BY p.id DESC");
        }

        sql.append(" LIMIT ?, ?");
        params.add(offset);
        params.add(limit);

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public Product getProductById(int id) {
    String query = "SELECT p.id, p.name, p.short_description, p.description, p.warranty_months, p.stock_quantity, "
            + "p.category_id, p.is_active, p.is_top_selling, p.is_featured, p.is_new, "
            + "c.name AS category_name, "
            + "b.name AS brandName, " // Lấy tên thương hiệu
            + "pp.price, pp.sale_price, "
            + "pi_main.image_url AS image_path "
            + "FROM products p "
            + "JOIN categories c ON p.category_id = c.id "
            + "LEFT JOIN brands b ON p.brand_id = b.id " // THÊM JOIN BẢNG BRANDS
            + "JOIN product_prices pp ON p.id = pp.product_id "
            + "LEFT JOIN product_images pi_main ON p.id = pi_main.product_id AND pi_main.is_main = 1 "
            + "WHERE p.id = ? AND p.is_active = 1";

    // ... (logic try-catch, setInt, executeQuery) ...
    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToProduct(rs); 
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

}
