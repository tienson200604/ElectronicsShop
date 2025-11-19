package DAO;

import Model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public List<Category> getAllWithProductCount() {
        List<Category> list = new ArrayList<>();

        String sql = "SELECT c.id, c.name, " +
                     "       COUNT(DISTINCT p.id) AS product_count " +
                     "FROM categories c " +
                     "LEFT JOIN products p ON p.category_id = c.id AND p.is_active = 1 " +
                     "GROUP BY c.id, c.name " +
                     "ORDER BY c.id ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setProductCount(rs.getInt("product_count"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
