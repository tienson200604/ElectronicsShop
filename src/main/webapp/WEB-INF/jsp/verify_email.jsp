<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Xác thực email - Electro</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

        <style>
            body {
                min-height: 100vh;
                background: linear-gradient(135deg, #eceff1, #fafafa);
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: "Roboto", sans-serif;
            }
            .auth-card {
                max-width: 420px;
                width: 100%;
                border-radius: 18px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
                background-color: #fff;
            }
            .auth-header {
                background: #ff7a00;
                color: #fff;
                padding: 18px 24px;
            }
            .auth-header h4 {
                margin: 0;
                font-weight: 600;
            }
            .auth-body {
                padding: 22px 24px 26px;
            }
            .form-control:focus {
                border-color: #ff7a00;
                box-shadow: 0 0 0 0.15rem rgba(255,122,0,0.25);
            }
            .btn-primary-custom {
                background: #ff7a00;
                border-color: #ff7a00;
                font-weight: 600;
            }
            .btn-primary-custom:hover {
                background: #e86e00;
                border-color: #e86e00;
            }
            .otp-input {
                letter-spacing: 0.35em;
                text-align: center;
                font-size: 1.3rem;
                font-weight: 600;
            }
        </style>
    </head>
    <body>

        <div class="auth-card">
            <div class="auth-header d-flex align-items-center">
                <span class="me-3 fs-3"><i class="fas fa-envelope-circle-check"></i></span>
                <div>
                    <h4 class="mb-0">Xác thực email</h4>
                    <small>Nhập mã OTP đã gửi tới hộp thư của bạn</small>
                </div>
            </div>

            <div class="auth-body">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 mb-3">
                        <i class="fas fa-circle-exclamation me-2"></i>${error}
                    </div>
                </c:if>

                <form action="${contextPath}/verify-email" method="post">
                    <!-- Email ẩn + hiển thị -->
                    <input type="hidden" name="email" value="${email}">
                    <p class="small text-muted mb-2">
                        Mã đã được gửi đến:
                    </p>
                    <p class="fw-semibold mb-3">
                        <i class="fas fa-at me-1"></i>${email}
                    </p>

                    <div class="mb-3">
                        <label class="form-label" for="code">Mã xác thực (6 chữ số)</label>
                        <input type="text" maxlength="6" class="form-control otp-input" id="code"
                               name="code" placeholder="______" required autocomplete="off">
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-2">
                        <i class="fas fa-check-circle me-2"></i>Xác nhận
                    </button>

                    <p class="text-center small mb-1">
                        Không nhận được mã?
                        <span class="text-muted">Bạn có thể gửi lại sau ít phút.</span>
                        <!-- Sau này bạn có thể thêm nút gửi lại ở đây -->
                    </p>

                    <p class="text-center small mb-0">
                        <a href="${contextPath}/login" class="text-decoration-none" style="color:#ff7a00;">
                            Quay lại đăng nhập
                        </a>
                    </p>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
