package com.electronics.shop.controller;

import com.electronics.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @GetMapping({ "/", "/home" })
    public String home(Model model) {
        model.addAttribute("newArrivals", productService.getNewProducts(8));
        model.addAttribute("featuredProducts", productService.getFeaturedProducts(8));
        model.addAttribute("bestSellerProductsPaged", productService.getTopSellingProducts(8));
        return "index";
    }
}
