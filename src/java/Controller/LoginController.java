package Controller;

import DAO.UserDAO;
import Model.User;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserDAO.checkLogin(username, password);

        if (user == null) {
            request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã xác thực chưa
        if (user.getEmailVerified() == 0) {
            request.setAttribute("errorMessage", "Email chưa được xác thực! Vui lòng kiểm tra hộp thư.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công → tạo session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Phân quyền
        if (user.getRoleId() == 1) {
            // ADMIN
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            // CUSTOMER
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
