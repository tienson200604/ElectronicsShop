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

            // ============================
            // 1. PHÂN TRANG BEST SELLER
            // ============================
            final int RECORDS_PER_PAGE = 8;
            int page = 1;

            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception ignored) {}

            int offset = (page - 1) * RECORDS_PER_PAGE;
            String statusFilter = "topselling";

            int totalRecords = productDAO.countProducts(null, null, null, statusFilter);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            if (totalPages < 1) totalPages = 1;
            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;

            List<Product> bestSellerProductsPaged =
                    productDAO.getProducts(null, null, null, null, offset, RECORDS_PER_PAGE, statusFilter);

            // ============================
            // 2. CÁC KHỐI KHÁC
            // ============================
            List<Product> newArrivals = productDAO.getProductsByStatus("new", 8);
            List<Product> featuredProducts = productDAO.getProductsByStatus("featured", 8);
            List<Product> topSellingMini = productDAO.getProductsByStatus("topselling", 6);
            List<Product> carouselProducts = productDAO.getProductsByStatus("featured", 4);

            // ============================
            // 3. CATEGORY CHO HEADER
            // ============================
            List<Category> categoryList = categoryDAO.getAllWithProductCount();
            request.setAttribute("categoryList", categoryList);

            // ============================
            // 4. SET ATTRIBUTE
            // ============================
            request.setAttribute("bestSellerProductsPaged", bestSellerProductsPaged);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);

            request.setAttribute("newArrivals", newArrivals);
            request.setAttribute("featuredProducts", featuredProducts);
            request.setAttribute("topSellingProducts", topSellingMini);
            request.setAttribute("productsListCarousel", carouselProducts);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu trang chủ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
