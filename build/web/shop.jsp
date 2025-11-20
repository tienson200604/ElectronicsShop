<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Đặt các biến dùng chung --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageTitle" value="Shop Products - Electro" scope="request"/>
<c:set var="pageActive" value="Shop" scope="request"/>

<jsp:include page="/common/header.jsp" />

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

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">
        Shop Page
    </h1>
    <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
        <li class="breadcrumb-item"><a href="${contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="#">Pages</a></li>
        <li class="breadcrumb-item active text-white">Shop</li>
    </ol>
</div>

<!-- Services Start -->
<div class="container-fluid py-5">
    <div class="row px-xl-5">
        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-sync-alt fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">FREE RETURN</h6>
                    <small>30 days money back guarantee!</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-paper-plane fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">FREE SHIPPING</h6>
                    <small>Miễn phí vận chuyển</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-headset fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">SUPPORT 24/7</h6>
                    <small>Hỗ trợ 24/7</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-gift fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">GIFT CARD</h6>
                    <small>Tặng voucher cho đơn > 1tr</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-lock fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">SECURE PAYMENT</h6>
                    <small>Thanh toán an toàn</small>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-4 col-sm-6 pb-4">
            <div class="d-flex align-items-center service-box mb-4 px-3">
                <div class="service-icon">
                    <i class="fa fa-broadcast-tower fa-lg text-orange"></i>
                </div>
                <div class="d-flex flex-column">
                    <h6 class="font-weight-semi-bold mb-1 service-title">ONLINE SERVICE</h6>
                    <small>Đổi trả trong 30 ngày</small>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Services End -->

<!-- Offer Start -->
<div class="container-fluid pt-3 pb-5">
    <div class="row px-xl-5">
        <div class="col-md-6 mb-3">
            <div class="position-relative overflow-hidden bg-light" style="height: 260px;">
                <img class="img-fluid position-absolute w-100 h-100" src="img/offer-1.jpg" style="object-fit: cover;" alt="">
                <div class="position-absolute d-flex flex-column align-items-start justify-content-center h-100 p-4">
                    <h5 class="text-uppercase">Find The Best Camera for You!</h5>
                    <h2 class="font-weight-bold">Smart Camera</h2>
                    <h3 class="font-weight-bold text-orange">40% Off</h3>
                    <a href="shop" class="btn btn-outline-dark mt-2">Shop Now</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="position-relative overflow-hidden bg-light" style="height: 260px;">
                <img class="img-fluid position-absolute w-100 h-100" src="img/offer-2.jpg" style="object-fit: cover;" alt="">
                <div class="position-absolute d-flex flex-column align-items-start justify-content-center h-100 p-4">
                    <h5 class="text-uppercase">Find The Best Watches for You!</h5>
                    <h2 class="font-weight-bold">Smart Watch</h2>
                    <h3 class="font-weight-bold text-orange">20% Off</h3>
                    <a href="shop" class="btn btn-outline-dark mt-2">Shop Now</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Offer End -->

<!-- Filter & Search Start -->
<div class="container-fluid bg-light py-3">
    <div class="container">
        <form class="row g-3 align-items-center" action="${contextPath}/shop" method="get">

            <!-- Price slider -->
            <div class="col-lg-4 col-md-6">
                <label class="form-label mb-1 fw-semibold">Price</label>
                <input type="range"
                       class="form-range"
                       min="0"
                       max="20000000"
                       step="200000"
                       name="maxPrice"
                       value="${empty param.maxPrice ? 20000000 : param.maxPrice}"
                       oninput="document.getElementById('priceValue').innerText = this.value;">
                <div class="d-flex justify-content-between">
                    <small>0</small>
                    <small>
                        <span id="priceValue">
                            ${empty param.maxPrice ? 20000000 : param.maxPrice}
                        </span> đ
                    </small>
                </div>
            </div>

            <!-- Search by name -->
            <div class="col-lg-5 col-md-6">
                <label class="form-label mb-1 fw-semibold">Search</label>
                <div class="input-group">
                    <input type="text"
                           class="form-control"
                           placeholder="keywords"
                           name="keyword"
                           value="${param.keyword}">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>

            <!-- Sort -->
            <div class="col-lg-3 col-md-6">
                <label class="form-label mb-1 fw-semibold">Sort By:</label>
                <select class="form-select" name="sort">
                    <option value="">Default Sorting</option>
                    <option value="priceAsc"  ${param.sort == 'priceAsc'  ? 'selected' : ''}>Price: Low → High</option>
                    <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Price: High → Low</option>
                </select>
            </div>

        </form>
    </div>
</div>
<!-- Filter & Search End -->

<div class="container-fluid shop py-5">
    <div class="container py-5">
        <div class="row g-4">

            <!-- SIDEBAR CATEGORIES -->
            <div class="col-lg-3 wow fadeInUp" data-wow-delay="0.1s">
                <div class="category-widget mb-4">
                    <div class="category-title">Products Categories</div>
                    <ul class="category-list">
                        <c:forEach var="cat" items="${categoryList}">

                            <c:set var="iconClass" value="fa-tag" />
                            <c:choose>
                                <c:when test="${cat.id == 1}">
                                    <c:set var="iconClass" value="fa-mobile-alt" />
                                </c:when>
                                <c:when test="${cat.id == 2}">
                                    <c:set var="iconClass" value="fa-laptop" />
                                </c:when>
                                <c:when test="${cat.id == 3}">
                                    <c:set var="iconClass" value="fa-tablet-alt" />
                                </c:when>
                                <c:when test="${cat.id == 4}">
                                    <c:set var="iconClass" value="fa-tv" />
                                </c:when>
                                <c:when test="${cat.id == 5}">
                                    <c:set var="iconClass" value="fa-volume-up" />
                                </c:when>
                                <c:when test="${cat.id == 6}">
                                    <c:set var="iconClass" value="fa-headphones" />
                                </c:when>
                                <c:when test="${cat.id == 7}">
                                    <c:set var="iconClass" value="fa-mouse" />
                                </c:when>
                            </c:choose>

                            <c:url var="catUrl" value="/shop">
                                <c:param name="categoryId" value="${cat.id}" />
                                <c:if test="${not empty param.keyword}">
                                    <c:param name="keyword" value="${param.keyword}" />
                                </c:if>
                                <c:if test="${not empty param.maxPrice}">
                                    <c:param name="maxPrice" value="${param.maxPrice}" />
                                </c:if>
                                <c:if test="${not empty param.sort}">
                                    <c:param name="sort" value="${param.sort}" />
                                </c:if>
                            </c:url>

                            <li class="category-item ${param.categoryId == cat.id ? 'active' : ''}">
                                <a href="${catUrl}">
                                    <i class="fa ${iconClass}"></i>
                                    <span>${cat.name}</span>
                                </a>
                                <span class="category-badge">(${cat.productCount})</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <!-- PRODUCT LIST -->
            <div class="col-lg-9 wow fadeInUp" data-wow-delay="0.1s">
                <div class="tab-content">
                    <div id="tab-5" class="tab-pane fade show p-0 active">
                        <div class="row g-4 product">

                            <c:choose>
                                <c:when test="${not empty productList}">
                                    <c:forEach var="product" items="${productList}">
                                        <div class="col-lg-4">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="${contextPath}/${product.imagePath}"
                                                             class="img-fluid w-100 rounded-top"
                                                             alt="${product.name}">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
    <a href="${contextPath}/product-detail?id=${product.id}"><i class="fa fa-eye fa-1x"></i></a>
</div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="${contextPath}/product-detail?id=${product.id}"
                                                           class="d-block mb-2">
                                                            ${product.shortDescription}
                                                        </a>
                                                        <a href="${contextPath}/product-detail?id=${product.id}"
                                                           class="d-block h4">
                                                            ${product.name}
                                                        </a>

                                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                                        <c:choose>
                                                            <c:when test="${product.salePrice > 0}">
                                                                <del class="me-2 fs-5 text-danger">
                                                                    $<fmt:formatNumber value="${product.price}" pattern="#,###.##"/>
                                                                </del>
                                                                <span class="text-primary fs-5">
                                                                    $<fmt:formatNumber value="${product.salePrice}" pattern="#,###.##"/>
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-primary fs-5">
                                                                    $<fmt:formatNumber value="${product.price}" pattern="#,###.##"/>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                                    <a href="${contextPath}/cart/add?id=${product.id}"
                                                       class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                                        <i class="fas fa-shopping-cart me-2"></i> Add To Cart
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12">
                                        <p class="alert alert-info">Không tìm thấy sản phẩm nào.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="d-flex justify-content-center mt-4">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination mb-0">

                                            <!-- Prev -->
                                            <c:url var="prevUrl" value="/shop">
                                                <c:param name="page" value="${currentPage - 1}" />
                                                <c:if test="${not empty param.keyword}">
                                                    <c:param name="keyword" value="${param.keyword}" />
                                                </c:if>
                                                <c:if test="${not empty param.maxPrice}">
                                                    <c:param name="maxPrice" value="${param.maxPrice}" />
                                                </c:if>
                                                <c:if test="${not empty param.sort}">
                                                    <c:param name="sort" value="${param.sort}" />
                                                </c:if>
                                                <c:if test="${not empty param.categoryId}">
                                                    <c:param name="categoryId" value="${param.categoryId}" />
                                                </c:if>
                                            </c:url>
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${prevUrl}">&laquo;</a>
                                            </li>

                                            <!-- Numbered pages -->
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <c:url var="pageUrl" value="/shop">
                                                    <c:param name="page" value="${i}" />
                                                    <c:if test="${not empty param.keyword}">
                                                        <c:param name="keyword" value="${param.keyword}" />
                                                    </c:if>
                                                    <c:if test="${not empty param.maxPrice}">
                                                        <c:param name="maxPrice" value="${param.maxPrice}" />
                                                    </c:if>
                                                    <c:if test="${not empty param.sort}">
                                                        <c:param name="sort" value="${param.sort}" />
                                                    </c:if>
                                                    <c:if test="${not empty param.categoryId}">
                                                        <c:param name="categoryId" value="${param.categoryId}" />
                                                    </c:if>
                                                </c:url>
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <!-- Next -->
                                            <c:url var="nextUrl" value="/shop">
                                                <c:param name="page" value="${currentPage + 1}" />
                                                <c:if test="${not empty param.keyword}">
                                                    <c:param name="keyword" value="${param.keyword}" />
                                                </c:if>
                                                <c:if test="${not empty param.maxPrice}">
                                                    <c:param name="maxPrice" value="${param.maxPrice}" />
                                                </c:if>
                                                <c:if test="${not empty param.sort}">
                                                    <c:param name="sort" value="${param.sort}" />
                                                </c:if>
                                                <c:if test="${not empty param.categoryId}">
                                                    <c:param name="categoryId" value="${param.categoryId}" />
                                                </c:if>
                                            </c:url>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="${nextUrl}">&raquo;</a>
                                            </li>

                                        </ul>
                                    </nav>
                                </div>
                            </c:if>

                        </div>
                    </div>

                    <div id="tab-6" class="products tab-pane fade show p-0">
                        <%-- tab khác nếu cần --%>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
