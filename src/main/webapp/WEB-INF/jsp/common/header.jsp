<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <title>${pageTitle != null ? pageTitle : "Electro - Cửa hàng điện tử"}</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="" name="keywords">
            <meta content="" name="description">

            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap"
                rel="stylesheet">

            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- giữ nguyên đường dẫn như bản đang chạy -->
            <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css"
                rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

            <style>
                .header-categories .btn {
                    font-weight: 600;
                    font-size: 16px;
                    background-color: #f58b0a;
                    border-color: #f58b0a;
                }

                .header-categories .btn:hover {
                    background-color: #ff9f1a;
                    border-color: #ff9f1a;
                }

                .header-categories .dropdown-menu {
                    border-radius: 0 0 10px 10px;
                    max-height: 360px;
                    overflow-y: auto;
                }

                .header-categories .dropdown-item {
                    padding: 10px 16px;
                }

                .header-categories .dropdown-item:hover {
                    background-color: #fff3e0;
                }

                .logo-img {
                    height: 60px;
                    width: auto;
                    margin-right: 10px;
                }

                .logo-text {
                    font-size: 28px;
                    font-weight: 700;
                    color: var(--bs-primary);
                }
            </style>
        </head>

        <body>

            <!-- SPINNER (như cũ) -->
            <div id="spinner"
                class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center"
                style="opacity:0; visibility:hidden;">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>

            <!-- THANH TRÊN CÙNG -->
            <div class="container-fluid px-5 d-none border-bottom d-lg-block">
                <div class="row gx-0 align-items-center">
                    <div class="col-lg-4 text-center text-lg-start mb-lg-0">
                        <div class="d-inline-flex align-items-center" style="height: 45px;">
                            <a href="#" class="text-muted me-2">Trợ giúp</a><small> / </small>
                            <a href="${pageContext.request.contextPath}/contact" class="text-muted mx-2">Hỗ
                                trợ</a><small> / </small>
                            <a href="${pageContext.request.contextPath}/contact" class="text-muted ms-2">Liên hệ</a>
                        </div>
                    </div>
                    <div class="col-lg-4 text-center d-flex align-items-center justify-content-center">
                        <small class="text-dark">Gọi cho chúng tôi:</small>
                        <a href="#" class="text-muted">(+012) 1234 567890</a>
                    </div>

                    <div class="col-lg-4 text-center text-lg-end">
                        <div class="d-inline-flex align-items-center" style="height: 45px;">
                            <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

                                <div class="dropdown">
                                    <a href="#" class="dropdown-toggle text-muted ms-2" data-bs-toggle="dropdown">
                                        <small>
                                            <i class="fa fa-home me-2"></i>
                                            <sec:authorize access="isAuthenticated()">
                                                Xin chào,
                                                <sec:authentication property="name" />
                                            </sec:authorize>
                                            <sec:authorize access="!isAuthenticated()">
                                                Tài khoản
                                            </sec:authorize>
                                        </small>
                                    </a>

                                    <div class="dropdown-menu rounded">
                                        <!-- ĐÃ ĐĂNG NHẬP -->
                                        <sec:authorize access="isAuthenticated()">
                                            <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">
                                                Thông tin cá nhân
                                            </a>
                                            <sec:authorize access="hasRole('ADMIN')">
                                                <a href="${pageContext.request.contextPath}/admin"
                                                    class="dropdown-item">
                                                    Trang quản trị
                                                </a>
                                            </sec:authorize>
                                            <div class="dropdown-divider"></div>
                                            <a href="${pageContext.request.contextPath}/logout"
                                                class="dropdown-item text-danger">
                                                Đăng xuất
                                            </a>
                                        </sec:authorize>

                                        <!-- CHƯA ĐĂNG NHẬP -->
                                        <sec:authorize access="!isAuthenticated()">
                                            <a href="${pageContext.request.contextPath}/login" class="dropdown-item">
                                                Đăng nhập
                                            </a>
                                            <a href="${pageContext.request.contextPath}/register" class="dropdown-item">
                                                Đăng ký
                                            </a>
                                        </sec:authorize>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- LOGO + TÌM KIẾM + GIỎ HÀNG -->
            <div class="container-fluid px-5 py-4 d-none d-lg-block">
                <div class="row gx-0 align-items-center text-center">
                    <div class="col-md-4 col-lg-3 text-center text-lg-start">
                        <div class="d-inline-flex align-items-center">
                            <h1 class="m-0 d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/img/logo-electro.png" alt="Logo"
                                    class="logo-img">
                                <span class="logo-text">Electronics Shop</span>
                            </h1>
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-6 text-center">
                        <div class="position-relative ps-4">
                            <form action="${pageContext.request.contextPath}/shop" method="get">
                                <div class="position-relative">
                                    <input class="form-control border rounded-pill w-100 py-3 ps-5 bg-light" type="text"
                                        name="keyword" placeholder="Bạn muốn mua gì hôm nay?">
                                    <button type="submit"
                                        class="btn position-absolute top-50 start-0 translate-middle-y ms-2 border-0 bg-transparent text-muted">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-3 text-center text-lg-end">
                        <div class="d-inline-flex align-items-center">
                            <a href="#" class="text-muted d-flex align-items-center justify-content-center me-3">
                                <span class="rounded-circle btn-md-square border">
                                    <i class="fas fa-random"></i>
                                </span>
                            </a>
                            <a href="#" class="text-muted d-flex align-items-center justify-content-center me-3">
                                <span class="rounded-circle btn-md-square border">
                                    <i class="fas fa-heart"></i>
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/cart"
                                class="text-muted d-flex align-items-center justify-content-center">
                                <span class="rounded-circle btn-md-square border">
                                    <i class="fas fa-shopping-cart"></i>
                                </span>
                                <span class="text-dark ms-2">0₫</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- NAVBAR + ALL CATEGORIES (giữ y nguyên cấu trúc dropdown) -->
            <div class="container-fluid nav-bar p-0">
                <div class="row gx-0 bg-primary px-5 align-items-center">

                    <!-- Cột trái: All Categories -->
                    <div class="col-lg-3 d-none d-lg-block">
                        <div class="header-categories dropdown">
                            <button class="btn btn-primary w-100 d-flex align-items-center justify-content-between py-3"
                                type="button" id="dropdownCategories" data-bs-toggle="dropdown" aria-expanded="false">
                                <span>
                                    <i class="fa fa-bars me-2"></i>
                                    Tất cả danh mục
                                </span>
                                <i class="fa fa-angle-down"></i>
                            </button>

                            <ul class="dropdown-menu w-100 border-0 shadow-sm mt-0"
                                aria-labelledby="dropdownCategories">

                                <c:choose>
                                    <c:when test="${not empty categoryList}">
                                        <c:forEach var="cat" items="${categoryList}">
                                            <c:url var="catUrl" value="/shop">
                                                <c:param name="categoryId" value="${cat.id}" />
                                            </c:url>

                                            <li>
                                                <a class="dropdown-item d-flex justify-content-between align-items-center"
                                                    href="${catUrl}">
                                                    <span>${cat.name}</span>
                                                    <span class="text-muted small">
                                                        (${cat.productCount})
                                                    </span>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <span class="dropdown-item text-muted">Chưa có danh mục</span>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>

                    <!-- Cột phải: menu chính -->
                    <div class="col-12 col-lg-9">
                        <nav class="navbar navbar-expand-lg navbar-light bg-primary ">
                            <a href="${pageContext.request.contextPath}/" class="navbar-brand d-block d-lg-none">
                                <h1 class="m-0 d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/img/logo-electro.png" alt="Logo"
                                        class="logo-img">
                                    <span class="logo-text">Electronics Shop</span>
                                </h1>
                            </a>
                            <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarCollapse">
                                <span class="fa fa-bars fa-1x"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarCollapse">
                                <div class="navbar-nav ms-auto py-0">
                                    <a href="${pageContext.request.contextPath}/"
                                        class="nav-item nav-link ${pageActive == 'Home' ? 'active' : ''}">
                                        Trang chủ
                                    </a>
                                    <a href="${pageContext.request.contextPath}/shop"
                                        class="nav-item nav-link ${pageActive == 'Shop' ? 'active' : ''}">
                                        Cửa hàng
                                    </a>
                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="nav-item nav-link ${pageActive == 'Cart' ? 'active' : ''}">
                                        Giỏ hàng
                                    </a>
                                    <a href="${pageContext.request.contextPath}/checkout"
                                        class="nav-item nav-link ${pageActive == 'Checkout' ? 'active' : ''}">
                                        Thanh toán
                                    </a>
                                    <a href="${pageContext.request.contextPath}/contact"
                                        class="nav-item nav-link me-2 ${pageActive == 'Contact' ? 'active' : ''}">
                                        Liên hệ
                                    </a>
                                </div>
                                <a href="#"
                                    class="btn btn-secondary rounded-pill py-2 px-4 px-lg-3 mb-3 mb-md-3 mb-lg-0">
                                    <i class="fa fa-mobile-alt me-2"></i> +0123 456 7890
                                </a>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- END NAVBAR -->