package Controller;

import DAO.UserDAO;
import Model.User;
import util.EmailService;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Kiểm tra email hoặc username đã tồn tại
        User existing = UserDAO.getUserByUsername(username);
        if (existing != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Tạo user mới
        int userId = UserDAO.insertNewUser(username, password, fullName, email, phone);

        if (userId <= 0) {
            request.setAttribute("error", "Đăng ký thất bại!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Sinh mã OTP
        String code = generateOTP();
        Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + 10 * 60 * 1000); // +10 phút

        UserDAO.updateVerification(email, code, expiresAt);

        // Gửi email
        EmailService.sendVerificationCode(email, code);

        // Chuyển sang trang nhập OTP
        request.setAttribute("email", email);
        request.getRequestDispatcher("/verify_email.jsp").forward(request, response);
    }

    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000);
        return String.valueOf(otp);
    }
}
