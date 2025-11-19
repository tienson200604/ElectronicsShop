package Controller;

import DAO.ProductDAO;
import DAO.CategoryDao; 
import Model.Product;
import Model.Category; 
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {
    
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDao categoryDAO = new CategoryDao(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            request.setAttribute("pageTitle", "Electro - Trang Chủ");
            request.setAttribute("pageActive", "Home");
            
            // --- 1. LOGIC PHÂN TRANG CHO TAB BEST SELLER (Tab 1) ---
            final int RECORDS_PER_PAGE = 8; 
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                try { page = Integer.parseInt(pageStr); } catch (NumberFormatException ignored) {}
            }
            int offset = (page - 1) * RECORDS_PER_PAGE;
            
            String statusFilter = "topselling"; 

            // Tính tổng số lượng sản phẩm Bestseller
            // Gọi hàm countProducts với tham số status
            int totalRecords = productDAO.countProducts(null, null, null, statusFilter);
            int totalPages = (int) Math.ceil(totalRecords / (double) RECORDS_PER_PAGE);
            if (totalPages < 1) totalPages = 1;
            
            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;
            
            // Lấy danh sách sản phẩm Bestseller cho trang hiện tại (Tab 1)
            // Gọi hàm getProducts với tham số status
            List<Product> bestSellerProductsPaged = productDAO.getProducts(null, null, null, null, offset, RECORDS_PER_PAGE, statusFilter);
            
            // --- 2. LOGIC CHO CÁC TAB VÀ KHỐI KHÁC (Không phân trang) ---
            List<Product> newArrivals = productDAO.getProductsByStatus("new", 8); 
            List<Product> featuredProducts = productDAO.getProductsByStatus("featured", 8);
            List<Product> topSellingProducts = productDAO.getProductsByStatus("topselling", 8);
            List<Product> productsListCarousel = productDAO.getProductsByStatus("featured", 4); 
            List<Product> bestSellerMini = productDAO.getProductsByStatus("topselling", 6);

            // --- 3. Đặt Attributes vào Request ---
            request.setAttribute("bestSellerProductsPaged", bestSellerProductsPaged);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            
            request.setAttribute("newArrivals", newArrivals);
            request.setAttribute("featuredProducts", featuredProducts);
            request.setAttribute("topSellingProducts", topSellingProducts);
            request.setAttribute("productsListCarousel", productsListCarousel);
            request.setAttribute("bestSellerProducts", bestSellerMini);
            
            request.setAttribute("categoryList", categoryDAO.getAllWithProductCount());

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu trang chủ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}