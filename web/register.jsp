<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Electro</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            max-width: 460px;
            width: 100%;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            background-color: #fff;
        }
        .auth-header {
            background: #ff7a00;
            color: #fff;
            padding: 20px 24px;
            text-align: center;
        }

        .logo-img {
            height: 46px;
            object-fit: contain;
        }

        .logo-text {
            font-weight: 700;
            font-size: 1.3rem;
            margin-left: 10px;
            color: #fff;
        }

        .auth-body {
            padding: 24px 24px 30px;
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
    </style>
</head>

<body>

<div class="auth-card">

    <!-- HEADER + LOGO -->
    <div class="auth-header d-flex flex-column align-items-center justify-content-center">
        <div class="d-flex align-items-center mb-1">
            <img src="${contextPath}/img/logo-electro.png" class="logo-img" alt="logo">
            <span class="logo-text">Electronics Shop</span>
        </div>
        <small>Tạo tài khoản mới</small>
    </div>

    <!-- BODY -->
    <div class="auth-body">

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 mb-3">
                <i class="fas fa-circle-exclamation me-2"></i>${error}
            </div>
        </c:if>

        <!-- Success -->
        <c:if test="${not empty message}">
            <div class="alert alert-success py-2 mb-3">
                <i class="fas fa-circle-check me-2"></i>${message}
            </div>
        </c:if>

        <form action="${contextPath}/register" method="post">

            <div class="mb-3">
                <label class="form-label">Họ và tên</label>
                <input type="text" class="form-control"
                       name="fullName" required
                       placeholder="Nguyễn Văn A"
                       value="${param.fullName}">
            </div>

            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control"
                       name="username" required
                       placeholder="Tên đăng nhập"
                       value="${param.username}">
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control"
                       name="email" required
                       placeholder="email@domain.com"
                       value="${param.email}">
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="text" class="form-control"
                       name="phone"
                       placeholder="090xxxxxxx"
                       value="${param.phone}">
            </div>

            <div class="row mb-3">
                <div class="col-6">
                    <label class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control"
                           name="password" required placeholder="••••••">
                </div>
                <div class="col-6">
                    <label class="form-label">Nhập lại mật khẩu</label>
                    <input type="password" class="form-control"
                           name="confirmPassword" required placeholder="••••••">
                </div>
            </div>

            <!-- Terms -->
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="agree" required>
                <label class="form-check-label small" for="agree">
                    Tôi đồng ý với <span class="text-primary">Điều khoản</span> và
                    <span class="text-primary">Chính sách bảo mật</span>.
                </label>
            </div>

            <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-2">
                <i class="fas fa-user-plus me-2"></i>Đăng ký
            </button>

            <p class="text-center small mb-0">
                Đã có tài khoản?
                <a href="${contextPath}/login" class="fw-semibold" style="color:#ff7a00;">
                    Đăng nhập ngay
                </a>
            </p>

        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
