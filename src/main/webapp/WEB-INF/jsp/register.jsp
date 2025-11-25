<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đăng ký - Electro</title>

            <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
            <link href="${contextPath}/css/style.css" rel="stylesheet">
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />

            <style>
                body {
                    min-height: 100vh;
                    background: #f5f7fa;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-family: "Roboto", sans-serif;
                }

                .auth-wrapper {
                    width: 100%;
                    max-width: 500px;
                }

                .auth-card {
                    border-radius: 16px;
                    overflow: hidden;
                    background: #fff;
                    box-shadow: 0 8px 28px rgba(0, 0, 0, 0.12);
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

                .logo-img {
                    height: 46px;
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

                .form-control:focus {
                    border-color: #ff7a00;
                    box-shadow: 0 0 0 0.15rem rgba(255, 122, 0, 0.25);
                }

                .btn-register {
                    background: #ff7a00;
                    border-color: #ff7a00;
                    font-weight: 600;
                    transition: 0.2s;
                }

                .btn-register:hover {
                    background: #e86d00;
                    border-color: #e86d00;
                }
            </style>
        </head>

        <body>

            <div class="auth-wrapper">

                <div class="auth-card">

                    <div class="auth-header">
                        <div class="logo-box">
                            <img src="${contextPath}/img/logo-electro.png" alt="Electro Logo" class="logo-img">
                            <span class="logo-text">Electronics Shop</span>
                        </div>
                        <h4 class="m-0">
                            <i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản
                        </h4>
                    </div>

                    <div class="auth-body">

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${contextPath}/register" method="post">

                            <div class="mb-3">
                                <label class="form-label">Họ và tên</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" name="fullName" required
                                        placeholder="Nhập họ và tên của bạn">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" name="email" required
                                        placeholder="Nhập địa chỉ email">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" name="password" required
                                        placeholder="Nhập mật khẩu">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nhập lại mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" name="confirmPassword" required
                                        placeholder="Nhập lại mật khẩu">
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-register text-white py-2">
                                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                                </button>
                            </div>

                            <p class="text-center mt-3 mb-0">
                                Đã có tài khoản?
                                <a href="${contextPath}/login">Đăng nhập ngay</a>
                            </p>

                        </form>
                    </div>

                </div>

            </div>

            <script src="${contextPath}/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>