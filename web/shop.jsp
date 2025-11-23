<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageTitle" value="Electro - Sản phẩm" scope="request"/>
<c:set var="pageActive" value="Shop" scope="request"/>
<fmt:setLocale value="vi_VN" scope="session"/>

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
        Cửa hàng
    </h1>
    <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
        <li class="breadcrumb-item"><a href="${contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="#">Trang</a></li>
        <li class="breadcrumb-item active text-white">Cửa hàng</li>
    </ol>
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
                    <small>Áp dụng điều kiện</small>
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
                    <small>Tư vấn tận tâm</small>
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
                    <small>Mua càng nhiều, ưu đãi càng lớn</small>
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
                    <small>Bảo mật thông tin</small>
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
                    <small>Đặt hàng mọi lúc mọi nơi</small>
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
                    <h5 class="text-uppercase">Chọn máy ảnh phù hợp cho bạn!</h5>
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
                    <h5 class="text-uppercase">Chọn đồng hồ yêu thích!</h5>
                    <h2 class="font-weight-bold">Smart Watch</h2>
                    <h3 class="font-weight-bold text-orange">Giảm 20%</h3>
                    <a href="${contextPath}/shop" class="btn btn-outline-dark mt-2">Mua ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- Offer End --%>

<%-- Filter & Search Start --%>
<div class="container-fluid bg-light py-3">
    <div class="container">
        <form class="row g-3 align-items-center" action="${contextPath}/shop" method="get">

            <div class="col-lg-4 col-md-6">
                <label class="form-label mb-1 fw-semibold">Giá tối đa</label>
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
                        </span> ₫
                    </small>
                </div>
            </div>

            <div class="col-lg-5 col-md-6">
                <label class="form-label mb-1 fw-semibold">Tìm kiếm</label>
                <div class="input-group">
                    <input type="text"
                           class="form-control"
                           placeholder="Nhập từ khóa sản phẩm"
                           name="keyword"
                           value="${param.keyword}">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <label class="form-label mb-1 fw-semibold">Sắp xếp</label>
                <select class="form-select" name="sort">
                    <option value="">Mặc định</option>
                    <option value="priceAsc"  ${param.sort == 'priceAsc'  ? 'selected' : ''}>Giá: Thấp → Cao</option>
                    <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Giá: Cao → Thấp</option>
                </select>
            </div>

        </form>
    </div>
</div>
<%-- Filter & Search End --%>

<div class="container-fluid shop py-5">
    <div class="container py-5">
        <div class="row g-4">

            <%-- SIDEBAR CATEGORIES --%>
            <div class="col-lg-3 wow fadeInUp" data-wow-delay="0.1s">
                <div class="category-widget mb-4">
                    <div class="category-title">Danh mục sản phẩm</div>
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

            <%-- PRODUCT LIST --%>
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
                                                        <div class="product-new">Mới</div>
                                                        <div class="product-details">
                                                            <a href="${contextPath}/product-detail?id=${product.id}">
                                                                <i class="fa fa-eye fa-1x"></i>
                                                            </a>
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

                                                        <c:choose>
                                                            <c:when test="${product.salePrice > 0}">
                                                                <del class="me-2 fs-5 text-danger">
                                                                    <fmt:formatNumber value="${product.price}" pattern="#,##0"/> ₫
                                                                </del>
                                                                <span class="text-primary fs-5">
                                                                    <fmt:formatNumber value="${product.salePrice}" pattern="#,##0"/> ₫
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-primary fs-5">
                                                                    <fmt:formatNumber value="${product.price}" pattern="#,##0"/> ₫
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                                    <%-- SỬA ĐÚNG ĐƯỜNG DẪN ADD TO CART --%>
                                                    <a href="${contextPath}/cart?action=add&pid=${product.id}"
                                                       class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                                        <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ
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

                            <%-- Pagination --%>
                            <c:if test="${totalPages > 1}">
                                <div class="d-flex justify-content-center mt-4">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination mb-0">

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
