<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Electro</title>

    <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>

    <style>
        body {
            min-height: 100vh;
            background: #f5f7fa; /* nền sáng dễ nhìn */
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: "Roboto", sans-serif;
        }

        .auth-wrapper {
            width: 100%;
            max-width: 460px;
        }

        .auth-card {
            border-radius: 16px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 8px 28px rgba(0,0,0,0.12);
        }

        .auth-header {
            background: #ffb300;
            padding: 20px;
            text-align: center;
            color: #333;
        }

        .logo-box {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 6px;
        }

        /* ẢNH LOGO */
        .logo-img {
            height: 46px;          /* chỉnh cao logo */
            object-fit: contain;
        }

        .logo-text {
            font-size: 1.4rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.5px;
            margin-left: 10px;
        }

        .auth-body {
            padding: 28px 26px 32px;
        }

        .form-control:focus, .form-select:focus {
            border-color: #ff7a00;
            box-shadow: 0 0 0 0.15rem rgba(255,122,0,0.25);
        }

        .btn-login {
            background: #ff7a00;
            border-color: #ff7a00;
            font-weight: 600;
            transition: 0.2s;
        }
        .btn-login:hover {
            background: #e86d00;
            border-color: #e86d00;
        }
    </style>
</head>

<body>

<div class="auth-wrapper">

    <div class="auth-card">

        <!-- HEADER + LOGO ẢNH -->
        <div class="auth-header">
            <div class="logo-box">
                <!-- ĐỔI src nếu bạn đặt tên file khác -->
                <img src="${contextPath}/img/logo-electro.png"
                     alt="Electro Logo" class="logo-img">
                <!-- Nếu không muốn chữ "Electro" thì xoá span này -->
                <span class="logo-text">Electronics Shop</span>
            </div>
            <h4 class="m-0">
                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập tài khoản
            </h4>
        </div>

        <div class="auth-body">

            <!-- Hiển thị lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form -->
            <form action="${contextPath}/login" method="post">

                <!-- Username -->
                <div class="mb-3">
                    <label class="form-label">Tên đăng nhập / Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control"
                               name="username" required
                               value="${param.username}"
                               placeholder="Nhập tên đăng nhập hoặc email">
                    </div>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label class="form-label">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control"
                               name="password" required placeholder="Nhập mật khẩu">
                    </div>
                </div>

                <!-- Role -->
                <div class="mb-3">
                    <label class="form-label">Đăng nhập với tư cách</label>
                    <select class="form-select" name="role">
                        <option value="customer"
                            <c:if test="${param.role == 'customer' || empty param.role}">selected</c:if>>
                            Khách hàng
                        </option>
                        <option value="admin"
                            <c:if test="${param.role == 'admin'}">selected</c:if>>
                            Quản trị viên
                        </option>
                    </select>
                </div>

                <!-- Remember -->
                <div class="d-flex justify-content-between mb-3">
                    <div>
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="#" class="small text-muted">Quên mật khẩu?</a>
                </div>

                <!-- Login btn -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-login text-white py-2">
                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                    </button>
                </div>

                <!-- Register redirect -->
                <p class="text-center mt-3 mb-0">
                    Chưa có tài khoản?
                    <a href="${contextPath}/register">Đăng ký ngay</a>
                </p>

            </form>
        </div>

    </div>

</div>

<script src="${contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
