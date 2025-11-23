<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Electro</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #ffb347, #ffcc33);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Roboto", system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }
        .auth-card {
            max-width: 450px;
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
        .auth-header small {
            opacity: .9;
        }
        .auth-body {
            padding: 22px 24px 26px;
        }
        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
        }
        .form-control:focus, .form-select:focus {
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
        .logo-text {
            font-weight: 700;
            font-size: 1.2rem;
        }
        .logo-dot {
            display: inline-block;
            width: 28px;
            height: 28px;
            border-radius: 8px;
            background: #fff;
            color: #ff7a00;
            text-align: center;
            line-height: 28px;
            margin-right: 8px;
            font-weight: 800;
        }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="auth-header d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <span class="logo-dot"><i class="fas fa-bag-shopping"></i></span>
            <div>
                <h4 class="mb-0">Electro Shop</h4>
                <small>Đăng ký tài khoản mới</small>
            </div>
        </div>
    </div>

    <div class="auth-body">

        <!-- Thông báo lỗi -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 mb-3">
                <i class="fas fa-circle-exclamation me-2"></i>${error}
            </div>
        </c:if>

        <!-- Thông báo thành công (nếu dùng) -->
        <c:if test="${not empty message}">
            <div class="alert alert-success py-2 mb-3">
                <i class="fas fa-circle-check me-2"></i>${message}
            </div>
        </c:if>

        <form action="${contextPath}/register" method="post" novalidate>
            <div class="mb-3">
                <label class="form-label" for="fullName">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName"
                       placeholder="Nguyễn Văn A" required value="${param.fullName}">
            </div>

            <div class="mb-3">
                <label class="form-label" for="username">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" name="username"
                       placeholder="Tên đăng nhập" required value="${param.username}">
            </div>

            <div class="mb-3">
                <label class="form-label" for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email"
                       placeholder="email@domain.com" required value="${param.email}">
            </div>

            <div class="mb-3">
                <label class="form-label" for="phone">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone"
                       placeholder="090xxxxxxx" value="${param.phone}">
            </div>

            <div class="row g-2 mb-3">
                <div class="col-6">
                    <label class="form-label" for="password">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="••••••" required>
                </div>
                <div class="col-6">
                    <label class="form-label" for="confirmPassword">Nhập lại mật khẩu</label>
                    <input type="password" class="form-control" id="confirmPassword"
                           name="confirmPassword" placeholder="••••••" required>
                </div>
            </div>

            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="agree" required>
                <label class="form-check-label small" for="agree">
                    Tôi đồng ý với <span class="text-primary">Điều khoản sử dụng</span> và
                    <span class="text-primary">Chính sách bảo mật</span>.
                </label>
            </div>

            <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-2">
                <i class="fas fa-user-plus me-2"></i>Tạo tài khoản
            </button>

            <p class="text-center small mb-0">
                Đã có tài khoản?
                <a href="${contextPath}/login" class="text-decoration-none fw-semibold" style="color:#ff7a00;">
                    Đăng nhập ngay
                </a>
            </p>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
