<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageTitle" value="Shop Cart - Electro" scope="request"/>
<c:set var="pageActive" value="Cart" scope="request"/>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>${pageTitle}</title> 
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <%-- ĐẢM BẢO CSS VÀ LIBS GIỐNG HEADER --%>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <%-- SỬ DỤNG CONTEXT PATH CHO TÀI NGUYÊN --%>
        <link href="${contextPath}/lib/animate/animate.min.css" rel="stylesheet">
        <link href="${contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${contextPath}/css/style.css" rel="stylesheet">

        <style>
            .table-cart img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }
            .text-primary {
                color: #f58b0a !important;
            }
            .bg-light {
                background-color: #f8f9fa !important;
            }
            .btn-primary {
                background-color: #f58b0a !important;
                border-color: #f58b0a !important;
            }
            .btn-primary:hover {
                background-color: #ff9f1a !important;
                border-color: #ff9f1a !important;
            }
            .cart-summary h1 {
                font-size: 2.25rem;
            }
            .text-danger {
                color: #dc3545 !important;
            }
        </style>
    </head>

    <body>

        <%-- INCLUDE HEADER (Giả định nằm trong WEB-INF/common/) --%>
        <jsp:include page="/common/header.jsp" /> 

        <%-- Single Page Header start --%>
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Cart Page</h1>
            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                <li class="breadcrumb-item"><a href="${contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Pages</a></li>
                <li class="breadcrumb-item active text-white">Cart Page</li>
            </ol>
        </div>
        <%-- Single Page Header End --%>

        <%-- Cart Page Start --%>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="table-responsive">
                    <table class="table table-hover table-cart">
                        <thead>
                            <tr>
                                <th scope="col">Product Image</th>
                                <th scope="col">Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Total</th>
                                <th scope="col">Handle</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- LẶP QUA CÁC MỤC TRONG GIỎ HÀNG (cartItems) --%>
                            <c:choose>
                                <c:when test="${not empty cartItems}">
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr class="align-middle">
                                            <td>
                                                <img src="${contextPath}/${item.product.imagePath}" class="img-fluid rounded" alt="${item.product.name}">
                                            </td>
                                            <td>
                                                <p class="mb-0">${item.product.name}</p>
                                            </td>
                                            <td>
                                                <p class="mb-0 text-primary fw-bold">
                                                    <fmt:formatNumber value="${item.product.effectivePrice}" pattern="#,##0"/> ₫
                                                    <%-- hoặc thêm chữ VNĐ:  /> VNĐ --%>
                                                </p>
                                            </td>
                                            <td>
                                                <%-- Form cập nhật số lượng --%>
                                                <form action="${contextPath}/cart" method="post" class="d-flex align-items-center">
                                                    <input type="hidden" name="action" value="update"/>
                                                    <input type="hidden" name="productId" value="${item.product.id}"/>
                                                    <div class="input-group quantity" style="width: 130px;">
                                                        <input type="number" 
                                                               name="quantity" 
                                                               value="${item.quantity}"
                                                               min="1" 
                                                               max="${item.product.stockQuantity > 0 ? item.product.stockQuantity : 100}"
                                                               class="form-control form-control-sm text-center border-primary" >
                                                        <button type="submit" class="btn btn-sm btn-primary">
                                                            <i class="fa fa-sync"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </td>
                                            <td>
                                                <p class="mb-0 fw-bold text-danger">
                                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/> ₫
                                                </p>
                                            </td>
                                            <td>
                                                <%-- Xóa sản phẩm --%>
                                                <a href="${contextPath}/cart?action=remove&pid=${item.product.id}" class="btn btn-md rounded-circle bg-light border" title="Remove Item">
                                                    <i class="fa fa-times text-danger"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center py-5">
                                            <div class="alert alert-warning">Giỏ hàng của bạn đang trống!</div>
                                            <a href="${contextPath}/shop" class="btn btn-primary rounded-pill px-4">Tiếp tục mua sắm</a>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>

                        </tbody>
                    </table>
                </div>

                <div class="row g-4 justify-content-end mt-5">
                    <div class="col-lg-6">
                        <div class="mt-5">
                            <input type="text" class="border-0 border-bottom rounded me-5 py-3 mb-4" placeholder="Coupon Code">
                            <button class="btn btn-primary rounded-pill px-4 py-3" type="button">Apply Coupon</button>
                        </div>
                    </div>
                    <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                        <div class="bg-light rounded cart-summary">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>

                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">Subtotal:</h5>
                                    <p class="mb-0 fw-bold">
                                        <fmt:formatNumber value="${cartTotal.subtotal}" pattern="#,##0"/> ₫
                                    </p>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Shipping:</h5>
                                    <div>
                                        <p class="mb-0 fw-bold text-success">Free Shipping</p>
                                    </div>
                                </div>
                                <p class="mb-0 text-end text-muted small">Chi phí vận chuyển được tính miễn phí.</p>
                            </div>

                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Total</h5>
                                <h5 class="mb-0 pe-4 text-danger fw-bold">
                                    <fmt:formatNumber value="${cartTotal.finalTotal}" pattern="#,##0"/> ₫
                                </h5>
                            </div>
                            <a href="${contextPath}/checkout" class="btn btn-primary rounded-pill px-4 py-3 text-uppercase w-100 mb-4">Proceed Checkout</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <%-- Cart Page End --%>

        <%-- INCLUDE FOOTER --%>
        <jsp:include page="/common/footer.jsp" /> 

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${contextPath}/lib/wow/wow.min.js"></script>
        <script src="${contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

        <script src="${contextPath}/js/main.js"></script>
    </body>
</html>