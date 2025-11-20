// File: Source Packages/Controller/ProductDetailController.java

package Controller;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail", "/detail"})
public class ProductDetailController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("id");
        int productId = 0;
        
        try { // Bắt đầu khối try-catch lớn
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/shop");
                return;
            }

            Product product = productDAO.getProductById(productId);

            if (product != null) {
                // Thiết lập các attribute cần thiết cho trang chi tiết
                request.setAttribute("product", product);
                request.setAttribute("pageTitle", product.getName());
                
                // Forward đến trang JSP chi tiết sản phẩm
                request.getRequestDispatcher("/product_detail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy sản phẩm
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product Not Found.");
            }
        } catch (Exception e) {
             // Bắt lỗi khi xử lý dữ liệu (ví dụ: lỗi DB, lỗi EL khi forward)
             e.printStackTrace();
             response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error loading product detail.");
        }
    }
}