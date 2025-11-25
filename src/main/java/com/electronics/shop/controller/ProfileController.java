package com.electronics.shop.controller;

import com.electronics.shop.entity.Order;
import com.electronics.shop.entity.User;
import com.electronics.shop.repository.OrderRepository;
import com.electronics.shop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProfileController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/profile")
    public String viewProfile(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        User user = userRepository.findByEmail(email).orElse(null);

        if (user != null) {
            model.addAttribute("user", user);
            List<Order> orders = orderRepository.findByUserOrderByOrderDateDesc(user);
            model.addAttribute("orders", orders);
        }

        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String fullName,
            @RequestParam String phone,
            @RequestParam String address,
            Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        User user = userRepository.findByEmail(email).orElse(null);

        if (user != null) {
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            userRepository.save(user);
            model.addAttribute("success", "Cập nhật thông tin thành công!");

            // Refresh data
            model.addAttribute("user", user);
            List<Order> orders = orderRepository.findByUserOrderByOrderDateDesc(user);
            model.addAttribute("orders", orders);
        }

        return "profile";
    }
}
