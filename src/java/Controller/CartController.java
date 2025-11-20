package Controller;

import DAO.CartDAO;
import DAO.ProductDAO;
import Model.Cart;
import Model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {
    
    private final ProductDAO productDAO = new ProductDAO();
    private final CartDAO cartDAO = new CartDAO(); // Thêm CartDAO

    private Cart getCart(HttpSession session, int customerId) {
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null) {
            // Nếu có Customer ID (Đã đăng nhập), cố gắng tải từ DB
            if (customerId > 0) {
                try {
                    cart = cartDAO.loadCartByCustomerId(customerId);
                } catch (Exception e) {
                    System.err.println("Error loading cart from DB: " + e.getMessage());
                }
            }
            
            if (cart == null) {
                cart = new Cart();
            }
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private int getCustomerId(HttpSession session) {
        // GIẢ ĐỊNH: Bạn đã lưu customerId sau khi đăng nhập
        // Thay thế bằng logic thực tế của bạn (ví dụ: User user = (User) session.getAttribute("user"); return user.getId();)
        return (session.getAttribute("customerId") != null) ? (int) session.getAttribute("customerId") : 0; 
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int customerId = getCustomerId(session);
        Cart cart = getCart(session, customerId);
        
        String action = request.getParameter("action");
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("pid"));
        } catch (NumberFormatException ignored) {}

        if ("add".equals(action)) {
            Product productToAdd = productDAO.getProductById(productId);
            if (productToAdd != null) {
                cart.addItem(productToAdd, 1);
                // Sau khi thay đổi Session Cart, lưu lại vào DB nếu đăng nhập
                if (customerId > 0) {
                     try { cartDAO.saveCart(customerId, cart); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
            
        } else if ("remove".equals(action)) {
            cart.removeItem(productId);
            // Sau khi thay đổi Session Cart, lưu lại vào DB nếu đăng nhập
            if (customerId > 0) {
                 try { cartDAO.saveCart(customerId, cart); } catch (SQLException e) { e.printStackTrace(); }
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Hiển thị giỏ hàng
        request.setAttribute("cartItems", cart.getItems().values());
        request.setAttribute("cartTotal", cart); 
        
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int customerId = getCustomerId(session);
        Cart cart = getCart(session, customerId);

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            int productId = 0;
            int quantity = 0;
            try {
                productId = Integer.parseInt(request.getParameter("productId"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
            } catch (NumberFormatException ignored) {}
            
            cart.updateQuantity(productId, quantity);
            
            // Lưu lại vào DB nếu đăng nhập
            if (customerId > 0) {
                 try { cartDAO.saveCart(customerId, cart); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}