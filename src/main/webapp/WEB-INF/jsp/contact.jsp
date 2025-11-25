<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="pageTitle" value="Electro - Liên hệ" scope="request" />
        <c:set var="pageActive" value="Contact" scope="request" />

        <jsp:include page="/WEB-INF/jsp/common/header.jsp" />

        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Liên hệ</h1>
            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="#">Trang</a></li>
                <li class="breadcrumb-item active text-white">Liên hệ</li>
            </ol>
        </div>
        <!-- Single Page Header End -->

        <!-- Contact Start -->
        <div class="container-fluid contact py-5">
            <div class="container py-5">
                <div class="p-5 bg-light rounded">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s"
                                style="max-width: 900px;">
                                <h4 class="text-primary border-bottom border-primary border-2 d-inline-block pb-2">Liên
                                    hệ với chúng tôi</h4>
                                <p class="mb-5 fs-5 text-dark">Chúng tôi luôn sẵn sàng hỗ trợ bạn! Hãy cho chúng tôi
                                    biết bạn cần giúp đỡ gì.</p>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <h5 class="text-primary wow fadeInUp" data-wow-delay="0.1s">Kết nối</h5>
                            <h1 class="display-5 mb-4 wow fadeInUp" data-wow-delay="0.3s">Gửi tin nhắn</h1>
                            <form>
                                <div class="row g-4 wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="col-lg-12 col-xl-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="name" placeholder="Họ và tên">
                                            <label for="name">Họ và tên</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-xl-6">
                                        <div class="form-floating">
                                            <input type="email" class="form-control" id="email" placeholder="Email">
                                            <label for="email">Email</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-xl-6">
                                        <div class="form-floating">
                                            <input type="phone" class="form-control" id="phone"
                                                placeholder="Số điện thoại">
                                            <label for="phone">Số điện thoại</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-xl-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="subject" placeholder="Chủ đề">
                                            <label for="subject">Chủ đề</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="Để lại lời nhắn tại đây"
                                                id="message" style="height: 160px"></textarea>
                                            <label for="message">Lời nhắn</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button class="btn btn-primary w-100 py-3" type="button">Gửi tin nhắn</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-lg-5 wow fadeInUp" data-wow-delay="0.2s">
                            <div class="h-100 rounded">
                                <iframe class="rounded w-100" style="height: 100%; min-height: 400px;"
                                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.096814183571!2d105.7800937149326!3d21.02881188599828!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab9bd9861ca1%3A0xe7887f7b72ca17a9!2zSGFub2ksIEhvw6BuIEtp4bq_bSwgSGFub2ksIFZpZXRuYW0!5e0!3m2!1sen!2s!4v1694259649153!5m2!1sen!2s"
                                    loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="row g-4 align-items-center justify-content-center">
                                <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="rounded p-4">
                                        <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                            style="width: 70px; height: 70px;">
                                            <i class="fas fa-map-marker-alt fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h4>Địa chỉ</h4>
                                            <p class="mb-2">123 Đường ABC, Hà Nội</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.3s">
                                    <div class="rounded p-4">
                                        <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                            style="width: 70px; height: 70px;">
                                            <i class="fas fa-envelope fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h4>Email</h4>
                                            <p class="mb-2">info@example.com</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="rounded p-4">
                                        <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                            style="width: 70px; height: 70px;">
                                            <i class="fa fa-phone-alt fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h4>Điện thoại</h4>
                                            <p class="mb-2">(+84) 123 456 789</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.7s">
                                    <div class="rounded p-4">
                                        <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                            style="width: 70px; height: 70px;">
                                            <i class="fab fa-facebook fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h4>Facebook</h4>
                                            <p class="mb-2">facebook.com/electro</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->

        <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />