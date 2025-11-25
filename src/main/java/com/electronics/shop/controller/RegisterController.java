package com.electronics.shop.controller;

import com.electronics.shop.entity.Role;
import com.electronics.shop.entity.User;
import com.electronics.shop.repository.RoleRepository;
import com.electronics.shop.repository.UserRepository;
import com.electronics.shop.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Random;

@Controller
public class RegisterController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private EmailService emailService;

    @GetMapping("/register")
    public String register(Model model) {
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(@RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            Model model,
            HttpSession session) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu không khớp!");
            return "register";
        }

        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email đã tồn tại!");
            return "register";
        }

        // Generate verification code
        String code = String.format("%06d", new Random().nextInt(999999));

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setUsername(email); // Set username to email to satisfy DB constraint
        user.setPassword(password); // Storing plain text as per current config
        user.setPasswordHash(password); // Set passwordHash to satisfy DB constraint
        user.setEnabled(false);
        user.setVerificationCode(code);

        // Handle Role
        Role role = roleRepository.findById(2).orElse(null);
        if (role == null) {
            role = new Role();
            role.setId(2);
            role.setName("USER");
            try {
                role = roleRepository.save(role);
            } catch (Exception e) {
                model.addAttribute("error", "Lỗi hệ thống: Không thể tạo quyền hạn người dùng.");
                return "register";
            }
        }
        user.setRole(role);

        try {
            userRepository.save(user);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi lưu dữ liệu: " + e.getMessage());
            return "register";
        }

        // Send email
        try {
            emailService.sendVerificationEmail(email, code);
        } catch (Exception e) {
            e.printStackTrace();
            // If email fails, delete user to allow retry
            userRepository.delete(user);
            model.addAttribute("error", "Lỗi gửi email: " + e.getMessage() + ". Vui lòng kiểm tra cấu hình email.");
            return "register";
        }

        session.setAttribute("verifyingEmail", email);
        return "redirect:/verify";
    }

    @GetMapping("/verify")
    public String verify(Model model) {
        return "verify";
    }

    @PostMapping("/verify")
    public String processVerify(@RequestParam String code, HttpSession session, Model model) {
        String email = (String) session.getAttribute("verifyingEmail");
        if (email == null) {
            return "redirect:/register";
        }

        User user = userRepository.findByEmail(email).orElse(null);
        if (user == null) {
            return "redirect:/register";
        }

        if (user.getVerificationCode().equals(code)) {
            user.setEnabled(true);
            user.setVerificationCode(null);
            userRepository.save(user);
            session.removeAttribute("verifyingEmail");
            return "redirect:/login?verified=true";
        } else {
            model.addAttribute("error", "Mã xác thực không đúng!");
            return "verify";
        }
    }
}
