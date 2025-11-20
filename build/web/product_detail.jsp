<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="product" value="${requestScope.product}" />
<c:set var="pageTitle" value="${product.name != null ? product.name : 'Product Detail'}" scope="request"/>
<c:set var="pageActive" value="Shop" scope="request"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${pageTitle}</title> 
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <%-- ĐÃ SỬA: DÙNG CONTEXT PATH CHO TẤT CẢ LIBS/CSS --%>
    <link href="${contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        .product-detail-img {
            max-height: 450px;
            object-fit: contain;
        }
    </style>
</head>

<body>
    
    <%-- INCLUDE HEADER (Đã sửa để sử dụng contextPath an toàn) --%>
    <jsp:include page="/common/header.jsp" /> 

    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Product Detail</h1>
        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
            <li class="breadcrumb-item"><a href="${contextPath}/">Home</a></li>
            <li class="breadcrumb-item"><a href="${contextPath}/shop">Shop</a></li>
            <li class="breadcrumb-item active text-white">${product.name}</li>
        </ol>
    </div>

    <%-- ======================== PRODUCT DETAIL START ======================== --%>
    <c:if test="${product != null}">
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="border rounded text-center p-4">
                        <img src="${contextPath}/${product.imagePath}" class="img-fluid rounded product-detail-img" alt="${product.name}">
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <h1 class="fw-bold">${product.name}</h1>
                    
                    <p class="mb-4 text-muted">${product.shortDescription}</p>

                    <%-- Hiển thị giá --%>
                    <div class="d-flex align-items-center mb-4">
                        <h4 class="me-3">Price:</h4>
                        <c:if test="${product.salePrice > 0 && product.salePrice < product.price}">
                            <del class="text-danger fs-5 me-3">$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></del>
                        </c:if>
                        <h4 class="text-primary fs-3">$<fmt:formatNumber value="${product.effectivePrice}" pattern="#,##0.00"/></h4>
                    </div>

                    <%-- Đánh giá (Tĩnh) --%>
                    <div class="d-flex mb-4">
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star"></i>
                        <span class="text-muted ms-2">(4.0 / 5.0)</span>
                    </div>

                    <%-- Khu vực thêm vào giỏ hàng --%>
                    <div class="d-flex align-items-center mb-4">
                        <form action="${contextPath}/cart" method="get">
                            <input type="hidden" name="action" value="add"/>
                            <input type="hidden" name="pid" value="${product.id}"/>
                            <div class="input-group quantity" style="width: 130px;">
                                <input type="number" 
                                       name="quantity" 
                                       value="1" 
                                       min="1" 
                                       max="${product.stockQuantity > 0 ? product.stockQuantity : 1}" 
                                       class="form-control text-center border-primary py-2 px-3">
                                
                                <button type="submit" class="btn btn-primary rounded-pill py-2 px-4 ms-3" title="Add to Cart">
                                    <i class="fa fa-shopping-cart me-2"></i> Add To Cart
                                </button>
                            </div>
                        </form>
                    </div>

                    <p class="text-muted">
                        <i class="fa fa-tag me-2"></i> Category: 
                        <a href="${contextPath}/shop?categoryId=${product.categoryId}" class="text-primary">${product.categoryName}</a>
                    </p>
                    <p class="text-muted">
                        <i class="fa fa-warehouse me-2"></i> Stock: 
                        <span class="fw-bold ${product.stockQuantity > 0 ? 'text-success' : 'text-danger'}">
                            ${product.stockQuantity > 0 ? product.stockQuantity : 'Out of Stock'}
                        </span>
                    </p>
                </div>
            </div>

            <%-- Tabs mô tả chi tiết --%>
            <div class="row mt-5">
                <div class="col-12">
                    <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="desc-tab" data-bs-toggle="tab" data-bs-target="#desc" type="button" role="tab">Description</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="spec-tab" data-bs-toggle="tab" data-bs-target="#spec" type="button" role="tab">Specification</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="desc" role="tabpanel">
                            <p>${product.description}</p>
                        </div>
                        <div class="tab-pane fade" id="spec" role="tabpanel">
                            <p>Product ID: ${product.id}</p>
                            <p>Warranty: ${product.warrantyMonths} months</p>
                            <p>Brand: ${product.brandName}</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    </c:if>
    <c:if test="${product == null}">
        <div class="container py-5">
             <div class="alert alert-danger text-center">Không tìm thấy sản phẩm này hoặc sản phẩm không còn hoạt động.</div>
        </div>
    </c:if>
    <%-- ======================== PRODUCT DETAIL END ======================== --%>


    <jsp:include page="/common/footer.jsp" /> 

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${contextPath}/lib/wow/wow.min.js"></script>
    <script src="${contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
    
    <script src="${contextPath}/js/main.js"></script>
</body>
</html>