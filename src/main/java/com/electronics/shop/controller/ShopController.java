package com.electronics.shop.controller;

import com.electronics.shop.entity.Category;
import com.electronics.shop.entity.Product;
import com.electronics.shop.repository.CategoryRepository;
import com.electronics.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ShopController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryRepository categoryRepository;

    @GetMapping("/shop")
    public String shop(Model model,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "9") int size,
            @RequestParam(defaultValue = "default") String sort) {

        Page<Product> productPage = productService.searchProducts(categoryId, keyword, maxPrice, page - 1, size, sort);
        List<Category> categories = categoryRepository.findAll();

        model.addAttribute("productList", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalItems", productPage.getTotalElements());
        model.addAttribute("categoryList", categories);

        // Keep filter params
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("keyword", keyword);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("sort", sort);

        return "shop";
    }

    @GetMapping("/product-detail")
    public String productDetail(@RequestParam("id") Integer id, Model model) {
        Product product = productService.getProductById(id);
        if (product != null) {
            model.addAttribute("product", product);
            // Related products (same category)
            model.addAttribute("relatedProducts",
                    productService.searchProducts(product.getCategoryId(), null, null, 0, 4, "default").getContent());
        }
        return "product_detail";
    }
}
