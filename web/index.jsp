<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageTitle" value="Electro - Trang chủ" scope="request"/>
<c:set var="pageActive" value="Home" scope="request"/>
<fmt:setLocale value="vi_VN" scope="session"/>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>${pageTitle}</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="${contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">

    <%-- STYLE PHÂN TRANG + DỊCH VỤ --%>
    <style>
        .text-orange {
            color: #ff7a00;
        }

        .service-box {
            height: 120px;
            border-radius: 14px;
            background: linear-gradient(135deg, #fff3e0, #ffe0b2);
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        .service-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }

        .service-title {
            color: #ff7a00;
        }

        /* ===== Pagination ===== */
        .shop .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .shop .pagination .page-item {
            display: inline-block;
        }

        .shop .pagination .page-link {
            min-width: 42px;
            height: 42px;
            padding: 0;
            line-height: 40px;
            text-align: center;
            border-radius: 16px;
            border: 2px solid #ff7a00;
            background-color: #ffffff;
            color: #ff7a00;
            font-weight: 500;
        }

        .shop .pagination .page-item.active .page-link {
            background-color: #ff7a00;
            color: #ffffff;
        }

        .shop .pagination .page-item.disabled .page-link {
            border-color: #ffd0a0;
            color: #ccc;
        }

        /* ===== Sidebar Categories ===== */
        .category-widget {
            border-radius: 18px;
            background: #ffffff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            padding: 20px 18px;
        }
        .category-title {
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 16px;
            color: #ff7a00;
        }
        .category-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 0;
        }
        .category-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 6px 4px;
            margin-bottom: 4px;
            border-radius: 10px;
            transition: background 0.2s, transform 0.1s;
        }
        .category-item a {
            text-decoration: none;
            color: #444;
            display: flex;
            align-items: center;
            flex: 1;
        }
        .category-item i {
            color: #ff7a00;
            margin-right: 8px;
            font-size: 14px;
        }
        .category-badge {
            font-size: 13px;
            color: #ff7a00;
        }
        .category-item:hover {
            background: #fff3e0;
            transform: translateX(2px);
        }
        .category-item.active {
            background: #ff7a00;
        }
        .category-item.active a,
        .category-item.active .category-badge {
            color: #fff;
            font-weight: 600;
        }
    </style>

</head>

<body>

<jsp:include page="/common/header.jsp" />
<%-- Lấy ra 1 sản phẩm cho banner phải, 2 sản phẩm cho Offer --%>
<c:set var="bannerProduct" value="${not empty bestSellerProductsPaged ? bestSellerProductsPaged[0] : null}" />
<c:set var="offer1" value="${not empty featuredProducts ? featuredProducts[0] : null}" />
<c:set var="offer2" value="${fn:length(featuredProducts) > 1 ? featuredProducts[1] : null}" />
<%-- CAROUSEL START --%>
<div class="container-fluid carousel bg-light px-0">
    <div class="row g-0 justify-content-end">
        <div class="col-12 col-lg-7 col-xl-9">
            <div class="header-carousel owl-carousel bg-light py-5">
                <div class="row g-0 header-carousel-item align-items-center">
                    <div class="col-xl-6 carousel-img wow fadeInLeft" data-wow-delay="0.1s">
                        <img src="${contextPath}/img/carousel-1.png" class="img-fluid w-100" alt="Image">
                    </div>
                    <div class="col-xl-6 carousel-content p-4">
                        <h4 class="text-uppercase fw-bold mb-4 wow fadeInRight"
                            data-wow-delay="0.1s" style="letter-spacing: 3px;">
                            Tiết kiệm tới 4.000.000₫
                        </h4>
                        <h1 class="display-3 text-capitalize mb-4 wow fadeInRight" data-wow-delay="0.3s">
                            Ưu đãi cho laptop, PC & smartphone chọn lọc
                        </h1>
                        <p class="text-dark wow fadeInRight" data-wow-delay="0.5s">
                            Áp dụng điều kiện & điều khoản
                        </p>
                        <a class="btn btn-primary rounded-pill py-3 px-5 wow fadeInRight"
                           data-wow-delay="0.7s" href="${contextPath}/shop">
                            Mua ngay
                        </a>
                    </div>
                </div>
                <div class="row g-0 header-carousel-item align-items-center">
                    <div class="col-xl-6 carousel-img wow fadeInLeft" data-wow-delay="0.1s">
                        <img src="${contextPath}/img/carousel-2.png" class="img-fluid w-100" alt="Image">
                    </div>
                    <div class="col-xl-6 carousel-content p-4">
                        <h4 class="text-uppercase fw-bold mb-4 wow fadeInRight"
                            data-wow-delay="0.1s" style="letter-spacing: 3px;">
                            Giảm tới 2.000.000₫
                        </h4>
                        <h1 class="display-3 text-capitalize mb-4 wow fadeInRight" data-wow-delay="0.3s">
                            Combo thiết bị công nghệ giá tốt
                        </h1>
                        <p class="text-dark wow fadeInRight" data-wow-delay="0.5s">
                            Số lượng có hạn – nhanh tay kẻo lỡ
                        </p>
                        <a class="btn btn-primary rounded-pill py-3 px-5 wow fadeInRight"
                           data-wow-delay="0.7s" href="${contextPath}/shop">
                            Mua ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%-- Banner bên phải --%>
        <div class="col-12 col-lg-5 col-xl-3 wow fadeInRight" data-wow-delay="0.1s">
            <div class="carousel-header-banner h-100">
                <img src="${contextPath}/img/header-img.jpg" class="img-fluid w-100 h-100"
                     style="object-fit: cover;" alt="Image">
                <div class="carousel-banner-offer">
                    <p class="bg-primary text-white rounded fs-5 py-2 px-4 mb-0 me-3">Tiết kiệm 480.000₫</p>
                    <p class="text-primary fs-5 fw-bold mb-0">Ưu đãi đặc biệt</p>
                </div>
                <div class="carousel-banner">
                    <div class="carousel-banner-content text-center p-4">
                        <a href="${contextPath}/shop" class="d-block mb-2">Điện thoại</a>
                        <a href="${contextPath}/product-detail?id=1"
                           class="d-block text-white fs-3">
                            Apple iPad Mini <br> G2356
                        </a>
                        <del class="me-2 text-white fs-5">12.500.000₫</del>
                        <span class="text-primary fs-5">10.500.000₫</span>
                    </div>
                    <a href="${contextPath}/cart?action=add&pid=1"
                       class="btn btn-primary rounded-pill py-2 px-4">
                        <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- Services Start --%>
<div class="container-fluid py-5">
    <div class="row px-xl-5">
        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-sync-alt fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">ĐỔI TRẢ MIỄN PHÍ</h6>
                    <small>Hoàn tiền trong 30 ngày</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-paper-plane fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">MIỄN PHÍ GIAO HÀNG</h6>
                    <small>Áp dụng cho đơn nội thành</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-headset fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">HỖ TRỢ 24/7</h6>
                    <small>Giải đáp mọi thắc mắc</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-gift fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">VOUCHER QUÀ TẶNG</h6>
                    <small>Tặng mã giảm giá đơn &gt; 1 triệu</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-lock fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">THANH TOÁN AN TOÀN</h6>
                    <small>Bảo mật 100% thông tin</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-broadcast-tower fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">MUA SẮM ONLINE</h6>
                    <small>Đặt hàng, giao tận nơi</small>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- Services End --%>

<%-- Offer Start --%>
<div class="container-fluid pt-3 pb-5">
    <div class="row px-xl-5">
        <div class="col-md-6 mb-3">
            <div class="position-relative overflow-hidden bg-light" style="height: 260px;">
                <img class="img-fluid position-absolute w-100 h-100"
                     src="${contextPath}/img/offer-1.jpg" style="object-fit: cover;" alt="">
                <div class="position-absolute d-flex flex-column align-items-start justify-content-center h-100 p-4">
                    <h5 class="text-uppercase">Chọn chiếc máy ảnh phù hợp nhất!</h5>
                    <h2 class="font-weight-bold">Smart Camera</h2>
                    <h3 class="font-weight-bold text-orange">Giảm 40%</h3>
                    <a href="${contextPath}/shop" class="btn btn-outline-dark mt-2">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="position-relative overflow-hidden bg-light" style="height: 260px;">
                <img class="img-fluid position-absolute w-100 h-100"
                     src="${contextPath}/img/offer-2.jpg" style="object-fit: cover;" alt="">
                <div class="position-absolute d-flex flex-column align-items-start justify-content-center h-100 p-4">
                    <h5 class="text-uppercase">Tìm chiếc đồng hồ dành cho bạn!</h5>
                    <h2 class="font-weight-bold">Smart Watch</h2>
                    <h3 class="font-weight-bold text-orange">Giảm 20%</h3>
                    <a href="${contextPath}/shop" class="btn btn-outline-dark mt-2">Mua ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- Offer End --%>

<%-- OUR PRODUCTS START --%>
<div class="container-fluid product py-5">
    <div class="container py-5">
        <div class="tab-class">
            <div class="row g-4">
                <div class="col-lg-4 text-start wow fadeInLeft" data-wow-delay="0.1s">
                    <h1>Sản phẩm</h1>
                </div>
                <div class="col-lg-8 text-end wow fadeInRight" data-wow-delay="0.1s">
                    <ul class="nav nav-pills d-inline-flex text-center mb-5">
                        <li class="nav-item mb-4">
                            <a class="d-flex mx-2 py-2 bg-light rounded-pill active"
                               data-bs-toggle="pill" href="#tab-1">
                                <span class="text-dark" style="width: 130px;">Bán chạy</span>
                            </a>
                        </li>
                        <li class="nav-item mb-4">
                            <a class="d-flex py-2 mx-2 bg-light rounded-pill"
                               data-bs-toggle="pill" href="#tab-2">
                                <span class="text-dark" style="width: 130px;">Hàng mới về</span>
                            </a>
                        </li>
                        <li class="nav-item mb-4">
                            <a class="d-flex mx-2 py-2 bg-light rounded-pill"
                               data-bs-toggle="pill" href="#tab-3">
                                <span class="text-dark" style="width: 130px;">Đề xuất</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="tab-content">

                <%-- TAB 1: BEST SELLER --%>
                <div id="tab-1" class="tab-pane fade show p-0 active">
                    <div class="row g-4">
                        <c:if test="${empty bestSellerProductsPaged}">
                            <div class="col-12">
                                <p class="alert alert-info text-center">
                                    Không có sản phẩm bán chạy nào.
                                </p>
                            </div>
                        </c:if>
                        <c:forEach var="p" items="${bestSellerProductsPaged}">
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="product-item-inner border rounded">
                                        <div class="product-item-inner-item">
                                            <img src="${contextPath}/${p.imagePath}"
                                                 class="img-fluid w-100 rounded-top" alt="${p.name}">
                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <div class="product-sale">Sale</div>
                                            </c:if>
                                            <div class="product-details">
                                                <a href="${contextPath}/product-detail?id=${p.id}">
                                                    <i class="fa fa-eye fa-1x"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="text-center rounded-bottom p-4">
                                            <a href="${contextPath}/shop?categoryId=${p.categoryId}"
                                               class="d-block mb-2">${p.categoryName}</a>
                                            <a href="${contextPath}/product-detail?id=${p.id}"
                                               class="d-block h4">${p.name}</a>

                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <del class="me-2 fs-5 text-danger">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0"/> ₫
                                                </del>
                                            </c:if>
                                            <span class="text-primary fs-5">
                                                <fmt:formatNumber value="${p.effectivePrice}" pattern="#,##0"/> ₫
                                            </span>
                                        </div>
                                    </div>
                                    <div class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                        <a href="${contextPath}/cart?action=add&pid=${p.id}"
                                           class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                            <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex">
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <div class="d-flex">
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-random"></i>
                                                    </span>
                                                </a>
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-heart"></i>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <%-- Phân trang Best Seller --%>
                    <c:if test="${totalPages > 1}">
                        <div class="d-flex justify-content-center mt-4 shop">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <c:url var="prevUrl" value="/">
                                        <c:param name="page" value="${currentPage - 1}" />
                                    </c:url>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${prevUrl}">&laquo;</a>
                                    </li>

                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <c:url var="pageUrl" value="/">
                                            <c:param name="page" value="${i}" />
                                        </c:url>
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="${pageUrl}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:url var="nextUrl" value="/">
                                        <c:param name="page" value="${currentPage + 1}" />
                                    </c:url>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${nextUrl}">&raquo;</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:if>
                </div>

                <%-- TAB 2: NEW ARRIVALS --%>
                <div id="tab-2" class="tab-pane fade show p-0">
                    <div class="row g-4">
                        <c:forEach var="p" items="${newArrivals}">
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="product-item-inner border rounded">
                                        <div class="product-item-inner-item">
                                            <img src="${contextPath}/${p.imagePath}"
                                                 class="img-fluid w-100 rounded-top" alt="${p.name}">
                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <div class="product-sale">Sale</div>
                                            </c:if>
                                            <div class="product-details">
                                                <a href="${contextPath}/product-detail?id=${p.id}">
                                                    <i class="fa fa-eye fa-1x"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="text-center rounded-bottom p-4">
                                            <a href="${contextPath}/shop?categoryId=${p.categoryId}"
                                               class="d-block mb-2">${p.categoryName}</a>
                                            <a href="${contextPath}/product-detail?id=${p.id}"
                                               class="d-block h4">${p.name}</a>
                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <del class="me-2 fs-5 text-danger">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0"/> ₫
                                                </del>
                                            </c:if>
                                            <span class="text-primary fs-5">
                                                <fmt:formatNumber value="${p.effectivePrice}" pattern="#,##0"/> ₫
                                            </span>
                                        </div>
                                    </div>
                                    <div class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                        <a href="${contextPath}/cart?action=add&pid=${p.id}"
                                           class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                            <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex">
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <div class="d-flex">
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-random"></i>
                                                    </span>
                                                </a>
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-heart"></i>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <%-- TAB 3: FEATURED --%>
                <div id="tab-3" class="tab-pane fade show p-0">
                    <div class="row g-4">
                        <c:forEach var="p" items="${featuredProducts}">
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="product-item-inner border rounded">
                                        <div class="product-item-inner-item">
                                            <img src="${contextPath}/${p.imagePath}"
                                                 class="img-fluid w-100 rounded-top" alt="${p.name}">
                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <div class="product-sale">Sale</div>
                                            </c:if>
                                            <div class="product-details">
                                                <a href="${contextPath}/product-detail?id=${p.id}">
                                                    <i class="fa fa-eye fa-1x"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="text-center rounded-bottom p-4">
                                            <a href="${contextPath}/shop?categoryId=${p.categoryId}"
                                               class="d-block mb-2">${p.categoryName}</a>
                                            <a href="${contextPath}/product-detail?id=${p.id}"
                                               class="d-block h4">${p.name}</a>
                                            <c:if test="${p.salePrice > 0 && p.salePrice < p.price}">
                                                <del class="me-2 fs-5 text-danger">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0"/> ₫
                                                </del>
                                            </c:if>
                                            <span class="text-primary fs-5">
                                                <fmt:formatNumber value="${p.effectivePrice}" pattern="#,##0"/> ₫
                                            </span>
                                        </div>
                                    </div>
                                    <div class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                        <a href="${contextPath}/cart?action=add&pid=${p.id}"
                                           class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                            <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex">
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <div class="d-flex">
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-random"></i>
                                                    </span>
                                                </a>
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0">
                                                    <span class="rounded-circle btn-sm-square border">
                                                        <i class="fas fa-heart"></i>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<%-- OUR PRODUCTS END --%>

<%-- PRODUCT BANNER START --%>
<div class="container-fluid py-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-6 wow fadeInLeft" data-wow-delay="0.1s">
                <a href="${contextPath}/shop">
                    <div class="bg-primary rounded position-relative">
                        <img src="${contextPath}/img/product-banner.jpg"
                             class="img-fluid w-100 rounded" alt="">
                        <div class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column justify-content-center rounded p-4"
                             style="background: rgba(255, 255, 255, 0.5);">
                            <h3 class="display-5 text-primary">EOS Rebel <br> <span>T7i Kit</span></h3>
                            <p class="fs-4 text-muted">Từ 8.999.000₫</p>
                            <a href="${contextPath}/shop"
                               class="btn btn-primary rounded-pill align-self-start py-2 px-4">Mua ngay</a>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-6 wow fadeInRight" data-wow-delay="0.2s">
                <a href="${contextPath}/shop">
                    <div class="text-center bg-primary rounded position-relative">
                        <img src="${contextPath}/img/product-banner-2.jpg"
                             class="img-fluid w-100" alt="">
                        <div class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column justify-content-center rounded p-4"
                             style="background: rgba(242, 139, 0, 0.5);">
                            <h2 class="display-2 text-secondary">SALE</h2>
                            <h4 class="display-5 text-white mb-4">Giảm giá tới 50%</h4>
                            <a href="${contextPath}/shop"
                               class="btn btn-secondary rounded-pill align-self-center py-2 px-4">Mua ngay</a>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
<%-- PRODUCT BANNER END --%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/lib/wow/wow.min.js"></script>
<script src="${contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

<jsp:include page="/common/footer.jsp" />

<script src="${contextPath}/js/main.js"></script>
</body>
</html>
