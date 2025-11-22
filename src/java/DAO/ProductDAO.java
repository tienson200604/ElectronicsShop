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

    // ===== Các cột luôn luôn có trong mọi truy vấn =====
    product.setId(rs.getInt("id"));
    product.setName(rs.getString("name"));

    // short_description (có thể không SELECT ở một số query)
    if (hasColumn(rs, "short_description")) {
        product.setShortDescription(rs.getString("short_description"));
    }

    // description
    if (hasColumn(rs, "description")) {
        product.setDescription(rs.getString("description"));
    }

    // category_id
    if (hasColumn(rs, "category_id")) {
        product.setCategoryId(rs.getInt("category_id"));
    }

    // category_name (có alias từ bảng categories)
    if (hasColumn(rs, "category_name")) {
        product.setCategoryName(rs.getString("category_name"));
    }
    if (hasColumn(rs, "stock_quantity")) {
        product.setStockQuantity(rs.getInt("stock_quantity"));
    }
    // warranty_months
    if (hasColumn(rs, "warranty_months")) {
        product.setWarrantyMonths(rs.getInt("warranty_months"));
    }

    // brandName (alias từ bảng brands)
    if (hasColumn(rs, "brandName")) {
        String bn = rs.getString("brandName");   // có thể null
        product.setBrandName(bn);
    }

    // ===== Giá bán =====
    double price = 0;
    if (hasColumn(rs, "price")) {
        price = rs.getDouble("price");
    }
    product.setPrice(price);

    double salePrice = 0;
    if (hasColumn(rs, "sale_price")) {
        salePrice = rs.getDouble("sale_price");
        if (rs.wasNull()) {
            salePrice = 0; // nếu sale_price null thì để 0
        }
    }
    product.setSalePrice(salePrice);

    // ===== Ảnh sản phẩm =====
    String imageDbPath = null;
    if (hasColumn(rs, "image_path")) {
        imageDbPath = rs.getString("image_path");
    }

    if (imageDbPath == null || imageDbPath.isEmpty()) {
        imageDbPath = "img/default-product.png";  // ảnh mặc định
    }
    product.setImagePath(imageDbPath);

    return product;
}

    private boolean hasColumn(ResultSet rs, String columnName) {
    try {
        rs.findColumn(columnName);
        return true;
    } catch (SQLException e) {
        return false;
    }
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
    String query =
        "SELECT " +
        "  p.id, " +
        "  p.name, " +
        "  p.short_description, " +
        "  p.description, " +
        "  p.warranty_months, " +
        "  p.stock_quantity, " +
        "  p.category_id, " +
        "  p.is_active, " +
        "  p.is_top_selling, " +
        "  p.is_featured, " +
        "  p.is_new, " +
        "  c.name AS category_name, " +
        "  b.name AS brandName, " +
        "  pp.price, " +
        "  pp.sale_price, " +
        "  pi_main.image_url AS image_path " +
        "FROM products p " +
        "JOIN categories c ON p.category_id = c.id " +
        "LEFT JOIN brands b ON p.brand_id = b.id " +
        "JOIN product_prices pp ON p.id = pp.product_id " +
        "LEFT JOIN product_images pi_main " +
        "       ON p.id = pi_main.product_id AND pi_main.is_main = 1 " +
        "WHERE p.id = ? AND p.is_active = 1";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, id);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        }

    } catch (SQLException e) {
        System.err.println("❌ SQL Error in getProductById(" + id + "): " + e.getMessage());
        e.printStackTrace();
    }

    return null;
}

}
