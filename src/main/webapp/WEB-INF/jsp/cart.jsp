<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <c:set var="contextPath" value="${pageContext.request.contextPath}" />
            <c:set var="pageTitle" value="Shop Cart - Electro" scope="request" />
            <c:set var="pageActive" value="Cart" scope="request" />

            <%-- INCLUDE HEADER (Opens <html>,

                <head>,

                <body>) --%>
                    <jsp:include page="/WEB-INF/jsp/common/header.jsp" />

                    <%-- Page-specific CSS --%>
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

                        <%-- Single Page Header start --%>
                            <div class="container-fluid page-header py-5">
                                <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Giỏ hàng
                                </h1>
                                <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                                    <li class="breadcrumb-item"><a href="${contextPath}/">Trang chủ</a></li>
                                    <li class="breadcrumb-item"><a href="#">Trang</a></li>
                                    <li class="breadcrumb-item active text-white">Giỏ hàng</li>
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
                                                            <th scope="col">Hình ảnh</th>
                                                            <th scope="col">Tên sản phẩm</th>
                                                            <th scope="col">Đơn giá</th>
                                                            <th scope="col">Số lượng</th>
                                                            <th scope="col">Thành tiền</th>
                                                            <th scope="col">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%-- LẶP QUA CÁC MỤC TRONG GIỎ HÀNG (cartItems) --%>
                                                            <c:choose>
                                                                <c:when test="${not empty cartItems}">
                                                                    <c:forEach var="item" items="${cartItems}">
                                                                        <tr class="align-middle">
                                                                            <td>
                                                                                <img src="${contextPath}/${item.product.imagePath}"
                                                                                    class="img-fluid rounded"
                                                                                    alt="${item.product.name}">
                                                                            </td>
                                                                            <td>
                                                                                <p class="mb-0">${item.product.name}</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="mb-0 text-primary fw-bold">
                                                                                    <fmt:formatNumber
                                                                                        value="${item.product.effectivePrice}"
                                                                                        pattern="#,##0" /> ₫
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <%-- Form cập nhật số lượng --%>
                                                                                    <form action="${contextPath}/cart"
                                                                                        method="post"
                                                                                        class="d-flex align-items-center">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="update" />
                                                                                        <input type="hidden"
                                                                                            name="productId"
                                                                                            value="${item.product.id}" />
                                                                                        <div class="input-group quantity"
                                                                                            style="width: 130px;">
                                                                                            <input type="number"
                                                                                                name="quantity"
                                                                                                value="${item.quantity}"
                                                                                                min="1"
                                                                                                max="${item.product.stockQuantity > 0 ? item.product.stockQuantity : 100}"
                                                                                                class="form-control form-control-sm text-center border-primary">
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-primary">
                                                                                                <i
                                                                                                    class="fa fa-sync"></i>
                                                                                            </button>
                                                                                        </div>
                                                                                    </form>
                                                                            </td>
                                                                            <td>
                                                                                <p class="mb-0 fw-bold text-danger">
                                                                                    <fmt:formatNumber
                                                                                        value="${item.totalPrice}"
                                                                                        pattern="#,##0" /> ₫
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <%-- Xóa sản phẩm --%>
                                                                                    <a href="${contextPath}/cart?action=remove&pid=${item.product.id}"
                                                                                        class="btn btn-md rounded-circle bg-light border"
                                                                                        title="Xóa">
                                                                                        <i
                                                                                            class="fa fa-times text-danger"></i>
                                                                                    </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr>
                                                                        <td colspan="6" class="text-center py-5">
                                                                            <div class="alert alert-warning">Giỏ hàng
                                                                                của bạn đang trống!</div>
                                                                            <a href="${contextPath}/shop"
                                                                                class="btn btn-primary rounded-pill px-4">Tiếp
                                                                                tục mua sắm</a>
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
                                                        <input type="text"
                                                            class="border-0 border-bottom rounded me-5 py-3 mb-4"
                                                            placeholder="Mã giảm giá">
                                                        <button class="btn btn-primary rounded-pill px-4 py-3"
                                                            type="button">Áp dụng</button>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                                                    <div class="bg-light rounded cart-summary">
                                                        <div class="p-4">
                                                            <h1 class="display-6 mb-4">Tổng <span class="fw-normal">Giỏ
                                                                    hàng</span></h1>

                                                            <div class="d-flex justify-content-between mb-4">
                                                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                                <p class="mb-0 fw-bold">
                                                                    <fmt:formatNumber value="${cartTotal.subtotal}"
                                                                        pattern="#,##0" /> ₫
                                                                </p>
                                                            </div>

                                                            <div class="d-flex justify-content-between">
                                                                <h5 class="mb-0 me-4">Vận chuyển:</h5>
                                                                <div>
                                                                    <p class="mb-0 fw-bold text-success">Miễn phí</p>
                                                                </div>
                                                            </div>
                                                            <p class="mb-0 text-end text-muted small">Chi phí vận chuyển
                                                                được tính miễn phí.</p>
                                                        </div>

                                                        <div
                                                            class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                            <h5 class="mb-0 ps-4 me-4">Tổng cộng</h5>
                                                            <h5 class="mb-0 pe-4 text-danger fw-bold">
                                                                <fmt:formatNumber value="${cartTotal.finalTotal}"
                                                                    pattern="#,##0" /> ₫
                                                            </h5>
                                                        </div>
                                                        <a href="${contextPath}/checkout"
                                                            class="btn btn-primary rounded-pill px-4 py-3 text-uppercase w-100 mb-4">Thanh
                                                            toán</a>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <%-- Cart Page End --%>

                                        <%-- INCLUDE FOOTER (Closes </body>,

                                            </html>) --%>
                                            <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />