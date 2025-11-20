package DAO;

import Model.Cart;
import Model.CartItem;
import Model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class CartDAO {
    
    private final ProductDAO productDAO = new ProductDAO();

    // 1. Tải giỏ hàng từ DB (Dùng khi người dùng đăng nhập)
    public Cart loadCartByCustomerId(int customerId) {
        Cart cart = new Cart();
        int cartId = -1;

        // BƯỚC 1: Lấy cart_id hiện tại (status=1 là active/đang sử dụng)
        String sqlCart = "SELECT id FROM carts WHERE customer_id = ? AND status = 1 LIMIT 1";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement psCart = conn.prepareStatement(sqlCart)) {
            
            psCart.setInt(1, customerId);
            try (ResultSet rsCart = psCart.executeQuery()) {
                if (rsCart.next()) {
                    cartId = rsCart.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return cart;
        }

        if (cartId == -1) return cart; // Chưa có giỏ hàng active

        // BƯỚC 2: Lấy các mặt hàng trong giỏ hàng
        String sqlItems = "SELECT product_id, quantity FROM cart_items WHERE cart_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement psItems = conn.prepareStatement(sqlItems)) {
            
            psItems.setInt(1, cartId);
            try (ResultSet rsItems = psItems.executeQuery()) {
                while (rsItems.next()) {
                    int productId = rsItems.getInt("product_id");
                    int quantity = rsItems.getInt("quantity");
                    
                    // Lấy chi tiết sản phẩm từ ProductDAO
                    Product product = productDAO.getProductById(productId);
                    if (product != null) {
                        cart.addItem(product, quantity);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    // 2. Lưu/Cập nhật giỏ hàng vào DB
    public void saveCart(int customerId, Cart cart) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            int cartId = -1;

            // Kiểm tra và lấy cart_id hiện có
            String sqlCheck = "SELECT id FROM carts WHERE customer_id = ? AND status = 1 LIMIT 1";
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                psCheck.setInt(1, customerId);
                try (ResultSet rsCheck = psCheck.executeQuery()) {
                    if (rsCheck.next()) {
                        cartId = rsCheck.getInt("id");
                    }
                }
            }

            // Nếu chưa có, tạo giỏ hàng mới
            if (cartId == -1) {
                String sqlInsertCart = "INSERT INTO carts (customer_id, status) VALUES (?, 1)";
                try (PreparedStatement psInsertCart = conn.prepareStatement(sqlInsertCart, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    psInsertCart.setInt(1, customerId);
                    psInsertCart.executeUpdate();
                    try (ResultSet rsGeneratedKeys = psInsertCart.getGeneratedKeys()) {
                        if (rsGeneratedKeys.next()) {
                            cartId = rsGeneratedKeys.getInt(1);
                        }
                    }
                }
            }

            // Xóa tất cả các item cũ trước khi INSERT mới (đơn giản hóa logic cập nhật)
            String sqlDeleteItems = "DELETE FROM cart_items WHERE cart_id = ?";
            try (PreparedStatement psDeleteItems = conn.prepareStatement(sqlDeleteItems)) {
                psDeleteItems.setInt(1, cartId);
                psDeleteItems.executeUpdate();
            }

            // INSERT các item mới
            String sqlInsertItem = "INSERT INTO cart_items (cart_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psInsertItem = conn.prepareStatement(sqlInsertItem)) {
                for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                    CartItem item = entry.getValue();
                    psInsertItem.setInt(1, cartId);
                    psInsertItem.setInt(2, item.getProduct().getId());
                    psInsertItem.setInt(3, item.getQuantity());
                    psInsertItem.setDouble(4, item.getProduct().getEffectivePrice());
                    psInsertItem.addBatch();
                }
                psInsertItem.executeBatch();
            }

            conn.commit(); // Hoàn tất Transaction
            
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // Rollback nếu có lỗi
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}