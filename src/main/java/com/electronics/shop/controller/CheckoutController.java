package com.electronics.shop.controller;

import com.electronics.shop.entity.Order;
import com.electronics.shop.entity.OrderDetail;
import com.electronics.shop.entity.Product;
import com.electronics.shop.entity.User;
import com.electronics.shop.model.Cart;
import com.electronics.shop.model.CartItem;
import com.electronics.shop.repository.OrderDetailRepository;
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

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class CheckoutController {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private com.electronics.shop.repository.CategoryRepository categoryRepository;

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            return "redirect:/cart";
        }

        model.addAttribute("cartItems", cart.getItems());
        model.addAttribute("totalPrice", cart.getTotalPrice());

        // Pre-fill user data if logged in
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String email = auth.getName();
            User user = userRepository.findByEmail(email).orElse(null);
            if (user != null) {
                model.addAttribute("user", user);
            }
        }

        model.addAttribute("categoryList", categoryRepository.findAll());

        return "checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String address,
            @RequestParam String phone,
            @RequestParam String email,
            @RequestParam(required = false) String note,
            HttpSession session,
            Model model) {

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            return "redirect:/cart";
        }

        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String userEmail = auth.getName();
            user = userRepository.findByEmail(userEmail).orElse(null);
        }

        // Create Order
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(new Date());
        order.setTotalAmount(cart.getTotalPrice());
        order.setShippingAddress(address);
        order.setPhoneNumber(phone);
        order.setNote(note);
        order.setStatus("PENDING");

        // Save Order
        order = orderRepository.save(order);

        // Save Order Details
        for (CartItem item : cart.getItems()) {
            OrderDetail detail = new OrderDetail();
            detail.setOrder(order);
            detail.setProduct(item.getProduct());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getProduct().getEffectivePrice());
            orderDetailRepository.save(detail);
        }

        // Clear Cart
        session.removeAttribute("cart");

        return "redirect:/?orderSuccess=true";
    }
}
