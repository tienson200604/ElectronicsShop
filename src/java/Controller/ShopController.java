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

@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {
    
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDao categoryDAO = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final int PAGE_SIZE = 9;

        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");
        String maxPriceStr = request.getParameter("maxPrice");
        String categoryIdStr = request.getParameter("categoryId");

        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try { maxPrice = Double.parseDouble(maxPriceStr); } catch (NumberFormatException ignored) {}
        }

        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try { categoryId = Integer.parseInt(categoryIdStr); } catch (NumberFormatException ignored) {}
        }

        try {
            String pageStr = request.getParameter("page");
            int currentPage = 1;
            if (pageStr != null) {
                try { currentPage = Integer.parseInt(pageStr); } catch (NumberFormatException ignored) {}
            }
            
            // SỬ DỤNG HÀM COUNT MỚI (Thêm null cho tham số status, vì ShopController không lọc theo trạng thái)
            int totalProducts = productDAO.countProducts(keyword, maxPrice, categoryId, null); 
            int totalPages = (int) Math.ceil(totalProducts / (double) PAGE_SIZE);
            if (totalPages < 1) totalPages = 1;

            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            int offset = (currentPage - 1) * PAGE_SIZE;
            
            // SỬ DỤNG HÀM GET MỚI (Thêm null cho tham số status)
            List<Product> productList =
                    productDAO.getProducts(keyword, maxPrice, sort, categoryId, offset, PAGE_SIZE, null);

            List<Category> categoryList = categoryDAO.getAllWithProductCount();

            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("keyword", keyword);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("sort", sort);
            request.setAttribute("categoryId", categoryId);

            request.setAttribute("categoryList", categoryList);

            request.getRequestDispatcher("shop.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                    "Đã xảy ra lỗi khi tải sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}