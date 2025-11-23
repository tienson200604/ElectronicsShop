<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    // có thể dùng để debug, nhưng không bắt buộc
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập - Electro</title>

        <!-- Các CSS/JS chung bạn đã đặt trong header.jsp nên ở đây không cần link lại -->
    </head>
    <body>
        <!-- Header chung -->
        <jsp:include page="/common/header.jsp"/>

        <!-- Breadcrumb -->
        <div class="container-fluid bg-light py-3 mb-4">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item">
                            <a href="${contextPath}/home">Trang chủ</a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            Đăng nhập
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Login Section -->
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">

                    <!-- Thông báo lỗi -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-header bg-warning text-white text-center py-3">
                            <h4 class="mb-0">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập tài khoản
                            </h4>
                        </div>

                        <div class="card-body p-4">
                            <form action="${contextPath}/login" method="post">
                                <!-- Username / Email -->
                                <div class="mb-3">
                                    <label for="username" class="form-label">
                                        Tên đăng nhập / Email
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                        <input type="text"
                                               class="form-control"
                                               id="username"
                                               name="username"
                                               placeholder="Nhập tên đăng nhập hoặc email"
                                               required
                                               value="${param.username}">
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="mb-3">
                                    <label for="password" class="form-label">
                                        Mật khẩu
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password"
                                               class="form-control"
                                               id="password"
                                               name="password"
                                               placeholder="Nhập mật khẩu"
                                               required>
                                    </div>
                                </div>

                                <!-- Role -->
                                <div class="mb-3">
                                    <label for="role" class="form-label">
                                        Đăng nhập với tư cách
                                    </label>
                                    <select class="form-select" id="role" name="role">
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

                                <!-- Remember + Forgot -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                        <label class="form-check-label" for="remember">
                                            Ghi nhớ đăng nhập
                                        </label>
                                    </div>
                                    <a href="#" class="text-decoration-none small text-muted">
                                        Quên mật khẩu?
                                    </a>
                                </div>

                                <!-- Button -->
                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-warning text-white fw-semibold py-2">
                                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                    </button>
                                </div>

                                <!-- Link đăng ký -->
                                <p class="text-center mb-0">
                                    Chưa có tài khoản?
                                    <a href="${contextPath}/register" class="text-decoration-none">
                                        Đăng ký ngay
                                    </a>
                                </p>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Footer chung -->
        <jsp:include page="/common/footer.jsp"/>

        <!-- Nếu bạn dùng Bootstrap JS trong footer.jsp rồi thì không cần thêm gì -->
    </body>
</html>
