<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <c:set var="pageTitle" value="Electro - Thanh toán" scope="request" />
            <c:set var="pageActive" value="Checkout" scope="request" />

            <jsp:include page="/WEB-INF/jsp/common/header.jsp" />

            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Thanh toán</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="#">Trang</a></li>
                    <li class="breadcrumb-item active text-white">Thanh toán</li>
                </ol>
            </div>
            <!-- Single Page Header End -->

            <!-- Checkout Page Start -->
            <div class="container-fluid py-3">
                <div class="container py-3">
                    <h1 class="mb-4">Thông tin thanh toán</h1>
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="row g-4">
                            <div class="col-md-12 col-lg-7">
                                <div class="row">
                                    <div class="col-md-12 col-lg-6">
                                        <div class="form-item w-100">
                                            <label class="form-label mb-1 mt-2">Tên<sup>*</sup></label>
                                            <input type="text" name="firstName" class="form-control"
                                                value="${(user != null && user.fullName != null) ? user.fullName.split(' ')[0] : ''}"
                                                required>
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-lg-6">
                                        <div class="form-item w-100">
                                            <label class="form-label mb-1 mt-2">Họ<sup>*</sup></label>
                                            <input type="text" name="lastName" class="form-control"
                                                value="${(user != null && user.fullName != null && user.fullName.contains(' ')) ? user.fullName.substring(user.fullName.indexOf(' ') + 1) : ''}"
                                                required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-item">
                                    <label class="form-label mb-1 mt-2">Địa chỉ <sup>*</sup></label>
                                    <input type="text" name="address" class="form-control"
                                        placeholder="Số nhà, tên đường" required>
                                </div>
                                <div class="form-item">
                                    <label class="form-label mb-1 mt-2">Số điện thoại<sup>*</sup></label>
                                    <input type="tel" name="phone" class="form-control" required>
                                </div>
                                <div class="form-item">
                                    <label class="form-label mb-1 mt-2">Email<sup>*</sup></label>
                                    <input type="email" name="email" class="form-control"
                                        value="${user != null ? user.email : ''}" required>
                                </div>
                                <hr>
                                <div class="form-item">
                                    <label class="form-label mb-1 mt-2">Ghi chú đơn hàng (Tùy chọn)</label>
                                    <textarea name="note" class="form-control" spellcheck="false" cols="30" rows="5"
                                        placeholder="Ghi chú về đơn hàng..."></textarea>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-5">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Sản phẩm</th>
                                                <th scope="col">Tên</th>
                                                <th scope="col">Giá</th>
                                                <th scope="col">SL</th>
                                                <th scope="col">Tổng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${cartItems}">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-items-center mt-2">
                                                            <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                                                                class="img-fluid rounded-circle"
                                                                style="width: 50px; height: 50px;" alt="">
                                                        </div>
                                                    </th>
                                                    <td class="py-2 align-middle">${item.product.name}</td>
                                                    <td class="py-2 align-middle">
                                                        <fmt:formatNumber value="${item.product.effectivePrice}"
                                                            type="number" minFractionDigits="0" maxFractionDigits="0" />
                                                        ₫
                                                    </td>
                                                    <td class="py-2 align-middle">${item.quantity}</td>
                                                    <td class="py-2 align-middle">
                                                        <fmt:formatNumber value="${item.totalPrice}" type="number"
                                                            minFractionDigits="0" maxFractionDigits="0" /> ₫
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <th scope="row"></th>
                                                <td class="py-2"></td>
                                                <td class="py-2"></td>
                                                <td class="py-2">
                                                    <p class="mb-0 text-dark py-2">Tạm tính</p>
                                                </td>
                                                <td class="py-2">
                                                    <div class="py-2 border-bottom border-top">
                                                        <p class="mb-0 text-dark">
                                                            <fmt:formatNumber value="${totalPrice}" type="number"
                                                                minFractionDigits="0" maxFractionDigits="0" /> ₫
                                                        </p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"></th>
                                                <td class="py-2">
                                                    <p class="mb-0 text-dark py-2">Vận chuyển</p>
                                                </td>
                                                <td colspan="3" class="py-2">
                                                    <div class="form-check text-start">
                                                        <input type="checkbox"
                                                            class="form-check-input bg-primary border-0" id="Shipping-1"
                                                            name="shipping" value="Free Shipping">
                                                        <label class="form-check-label" for="Shipping-1">Miễn phí vận
                                                            chuyển</label>
                                                    </div>
                                                    <div class="form-check text-start">
                                                        <input type="checkbox"
                                                            class="form-check-input bg-primary border-0" id="Shipping-2"
                                                            name="shipping" value="Flat rate: $15.00">
                                                        <label class="form-check-label" for="Shipping-2">Phí cố định:
                                                            15.000 ₫</label>
                                                    </div>
                                                    <div class="form-check text-start">
                                                        <input type="checkbox"
                                                            class="form-check-input bg-primary border-0" id="Shipping-3"
                                                            name="shipping" value="Local Pickup: $8.00">
                                                        <label class="form-check-label" for="Shipping-3">Nhận tại cửa
                                                            hàng: 8.000 ₫</label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"></th>
                                                <td class="py-2">
                                                    <p class="mb-0 text-dark text-uppercase py-2">TỔNG CỘNG</p>
                                                </td>
                                                <td class="py-2"></td>
                                                <td class="py-2"></td>
                                                <td class="py-2">
                                                    <div class="py-2 border-bottom border-top">
                                                        <p class="mb-0 text-dark">
                                                            <fmt:formatNumber value="${totalPrice}" type="number"
                                                                minFractionDigits="0" maxFractionDigits="0" /> ₫
                                                        </p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div
                                    class="row g-2 text-center align-items-center justify-content-center border-bottom py-2">
                                    <div class="col-12">
                                        <div class="form-check text-start my-2">
                                            <input type="checkbox" class="form-check-input bg-primary border-0"
                                                id="Transfer-1" name="paymentMethod" value="Direct Bank Transfer">
                                            <label class="form-check-label" for="Transfer-1">Chuyển khoản ngân
                                                hàng</label>
                                        </div>
                                        <p class="text-start text-dark small">Thực hiện thanh toán trực tiếp vào tài
                                            khoản ngân hàng của chúng tôi.</p>
                                    </div>
                                </div>
                                <div
                                    class="row g-2 text-center align-items-center justify-content-center border-bottom py-2">
                                    <div class="col-12">
                                        <div class="form-check text-start my-2">
                                            <input type="checkbox" class="form-check-input bg-primary border-0"
                                                id="Payments-1" name="paymentMethod" value="Check Payments">
                                            <label class="form-check-label" for="Payments-1">Thanh toán bằng séc</label>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    class="row g-2 text-center align-items-center justify-content-center border-bottom py-2">
                                    <div class="col-12">
                                        <div class="form-check text-start my-2">
                                            <input type="checkbox" class="form-check-input bg-primary border-0"
                                                id="Delivery-1" name="paymentMethod" value="Cash On Delivery">
                                            <label class="form-check-label" for="Delivery-1">Thanh toán khi nhận
                                                hàng</label>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    class="row g-2 text-center align-items-center justify-content-center border-bottom py-2">
                                    <div class="col-12">
                                        <div class="form-check text-start my-2">
                                            <input type="checkbox" class="form-check-input bg-primary border-0"
                                                id="Paypal-1" name="paymentMethod" value="Paypal">
                                            <label class="form-check-label" for="Paypal-1">Paypal</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row g-2 text-center align-items-center justify-content-center pt-3">
                                    <button type="submit"
                                        class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">Đặt
                                        hàng</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Checkout Page End -->

            <!-- Services Start -->
            <div class="container-fluid px-0">
                <div class="row g-0">
                    <div class="col-6 col-md-4 col-lg-2 border-start border-end wow fadeInUp" data-wow-delay="0.1s">
                        <div class="p-4">
                            <div class="d-inline-flex align-items-center">
                                <i class="fa fa-sync-alt fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Đổi trả miễn phí</h6>
                                    <p class="mb-0">Hoàn tiền trong 30 ngày!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.2s">
                        <div class="p-4">
                            <div class="d-flex align-items-center">
                                <i class="fab fa-telegram-plane fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Miễn phí vận chuyển</h6>
                                    <p class="mb-0">Cho mọi đơn hàng</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.3s">
                        <div class="p-4">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-life-ring fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Hỗ trợ 24/7</h6>
                                    <p class="mb-0">Hỗ trợ trực tuyến 24h</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.4s">
                        <div class="p-4">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-credit-card fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Thẻ quà tặng</h6>
                                    <p class="mb-0">Cho đơn hàng trên $50</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.5s">
                        <div class="p-4">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-lock fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Thanh toán an toàn</h6>
                                    <p class="mb-0">Bảo mật thông tin 100%</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.6s">
                        <div class="p-4">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-certificate fa-2x text-primary"></i>
                                <div class="ms-4">
                                    <h6 class="text-uppercase mb-2">Chính hãng</h6>
                                    <p class="mb-0">Sản phẩm chất lượng</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Services End -->

            <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />