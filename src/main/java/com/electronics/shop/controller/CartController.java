package com.electronics.shop.controller;

import com.electronics.shop.entity.Product;
import com.electronics.shop.model.Cart;
import com.electronics.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    private ProductService productService;

    @Autowired
    private com.electronics.shop.repository.CategoryRepository categoryRepository;

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model,
            @RequestParam(required = false) String action,
            @RequestParam(required = false, name = "pid") Integer productId) {

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action) && productId != null) {
            Product product = productService.getProductById(productId);
            if (product != null) {
                // Default quantity 1 for GET request (quick add)
                cart.addItem(product, 1);
            }
            return "redirect:/cart";
        }

        if ("remove".equals(action) && productId != null) {
            cart.removeItem(productId);
            return "redirect:/cart";
        }

        // Refresh cart items to ensure products are attached and up-to-date
        // This avoids LazyInitializationException and stale data issues
        java.util.List<com.electronics.shop.model.CartItem> itemsToRemove = new java.util.ArrayList<>();
        for (com.electronics.shop.model.CartItem item : cart.getItems()) {
            Product freshProduct = productService.getProductById(item.getProduct().getId());
            if (freshProduct != null) {
                item.setProduct(freshProduct);
            } else {
                itemsToRemove.add(item);
            }
        }
        cart.getItems().removeAll(itemsToRemove);

        model.addAttribute("cartItems", cart.getItems());
        model.addAttribute("cartTotal", cart); // Pass cart object to access totals
        model.addAttribute("categoryList", categoryRepository.findAll());
        return "cart";
    }

    @GetMapping("/cart/add")
    public String addToCart(@RequestParam("pid") Integer productId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        Product product = productService.getProductById(productId);
        if (product != null) {
            cart.addItem(product, quantity);
        }

        return "redirect:/cart";
    }

    @PostMapping("/cart")
    public String updateCart(@RequestParam("action") String action,
            @RequestParam("productId") Integer productId,
            @RequestParam("quantity") Integer quantity,
            HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null && "update".equals(action)) {
            cart.updateItem(productId, quantity);
        }
        return "redirect:/cart";
    }
}
