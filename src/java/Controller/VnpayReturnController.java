package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/vnpay-return")
public class VnpayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef"); // chính là orderId
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        // TODO: verify lại chữ ký vnp_SecureHash nếu cần (tương tự khi tạo URL)
        // TODO: lưu vào bảng vnpay_transactions & cập nhật trạng thái đơn hàng

        boolean success = "00".equals(vnp_ResponseCode);

        if (success) {
            // update order: PAID
            // OrderDAO.updateStatus(orderId, "PAID");
            request.setAttribute("message", "Thanh toán thành công!");
        } else {
            request.setAttribute("message", "Thanh toán thất bại. Mã lỗi: " + vnp_ResponseCode);
        }

        request.getRequestDispatcher("/payment_result.jsp").forward(request, response);
    }
}
