package util;

public class VnpayConfig {
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8080/ElectronicsShop/vnpay-return";
    public static String vnp_TmnCode = "YOUR_TMN_CODE";      // điền mã test của bạn
    public static String vnp_HashSecret = "YOUR_SECRET_KEY"; // secret key

    public static String vnp_Version = "2.1.0";
    public static String vnp_Command = "pay";
    public static String orderType = "other";
}
