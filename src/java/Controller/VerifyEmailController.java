package Controller;

import DAO.UserDAO;
import Model.User;

import java.io.IOException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/verify-email")
public class VerifyEmailController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String code = request.getParameter("code");

        User user = UserDAO.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản!");
            request.getRequestDispatcher("/verify_email.jsp").forward(request, response);
            return;
        }

        // Kiểm tra code
        if (!code.equals(user.getVerificationCode())) {
            request.setAttribute("error", "Mã OTP không chính xác!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/verify_email.jsp").forward(request, response);
            return;
        }

        // Kiểm tra hạn
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp expiresAt = Timestamp.valueOf(user.getVerificationExpiresAt());

        if (now.after(expiresAt)) {
            request.setAttribute("error", "Mã OTP đã hết hạn!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/verify_email.jsp").forward(request, response);
            return;
        }

        // Xác thực thành công
        UserDAO.verifyEmail(email);

        request.setAttribute("message", "Xác thực thành công! Hãy đăng nhập.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
