<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- Include Header -->
            <jsp:include page="common/header.jsp" />

            <!-- Profile Start -->
            <div class="container-fluid pt-5">
                <div class="row px-xl-5">
                    <!-- Sidebar -->
                    <div class="col-lg-3 mb-5">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist"
                                    aria-orientation="vertical">
                                    <a class="nav-link active py-3 px-4" id="v-pills-account-tab" data-bs-toggle="pill"
                                        href="#v-pills-account" role="tab" aria-controls="v-pills-account"
                                        aria-selected="true">
                                        <i class="fas fa-user-circle mr-2"></i> Thông tin tài khoản
                                    </a>
                                    <a class="nav-link py-3 px-4" id="v-pills-orders-tab" data-bs-toggle="pill"
                                        href="#v-pills-orders" role="tab" aria-controls="v-pills-orders"
                                        aria-selected="false">
                                        <i class="fas fa-history mr-2"></i> Lịch sử mua hàng
                                    </a>
                                    <a class="nav-link py-3 px-4" id="v-pills-warranty-tab" data-bs-toggle="pill"
                                        href="#v-pills-warranty" role="tab" aria-controls="v-pills-warranty"
                                        aria-selected="false">
                                        <i class="fas fa-shield-alt mr-2"></i> Chính sách bảo hành
                                    </a>
                                    <div class="dropdown-divider m-0"></div>
                                    <a class="nav-link py-3 px-4 text-danger"
                                        href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Area -->
                    <div class="col-lg-9 mb-5">
                        <div class="tab-content" id="v-pills-tabContent">

                            <!-- Account Info Tab -->
                            <div class="tab-pane fade show active" id="v-pills-account" role="tabpanel"
                                aria-labelledby="v-pills-account-tab">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-primary border-0">
                                        <h4 class="font-weight-semi-bold m-0 text-white">Thông tin tài khoản</h4>
                                    </div>
                                    <div class="card-body">
                                        <c:if test="${not empty success}">
                                            <div class="alert alert-success">${success}</div>
                                        </c:if>

                                        <form action="${pageContext.request.contextPath}/profile/update" method="post">
                                            <div class="row">
                                                <div class="col-md-6 form-group mb-3">
                                                    <label class="form-label">Họ và tên</label>
                                                    <input type="text" class="form-control" name="fullName"
                                                        value="${user.fullName}" required>
                                                </div>
                                                <div class="col-md-6 form-group mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" class="form-control bg-light"
                                                        value="${user.email}" readonly>
                                                </div>
                                                <div class="col-md-6 form-group mb-3">
                                                    <label class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" name="phone"
                                                        value="${user.phone}">
                                                </div>
                                                <div class="col-md-12 form-group mb-3">
                                                    <label class="form-label">Địa chỉ</label>
                                                    <textarea class="form-control" name="address"
                                                        rows="3">${user.address}</textarea>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary py-2 px-4">Cập nhật thông
                                                tin</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Order History Tab -->
                            <div class="tab-pane fade" id="v-pills-orders" role="tabpanel"
                                aria-labelledby="v-pills-orders-tab">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-primary border-0">
                                        <h4 class="font-weight-semi-bold m-0 text-white">Lịch sử đơn hàng</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover text-center mb-0">
                                                <thead class="bg-light text-dark">
                                                    <tr>
                                                        <th>Mã đơn</th>
                                                        <th>Ngày đặt</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                        <th>Chi tiết</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="align-middle">
                                                    <c:choose>
                                                        <c:when test="${not empty orders}">
                                                            <c:forEach var="order" items="${orders}">
                                                                <tr>
                                                                    <td class="align-middle">#${order.id}</td>
                                                                    <td class="align-middle">
                                                                        <fmt:formatDate value="${order.orderDate}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
                                                                    </td>
                                                                    <td class="align-middle">
                                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                                            type="currency" currencySymbol="₫" />
                                                                    </td>
                                                                    <td class="align-middle">
                                                                        <span
                                                                            class="badge badge-info">${order.status}</span>
                                                                    </td>
                                                                    <td class="align-middle">
                                                                        <a href="#"
                                                                            class="btn btn-sm btn-primary">Xem</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="5" class="text-center py-4">Bạn chưa có đơn
                                                                    hàng nào.</td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Warranty Policy Tab -->
                            <div class="tab-pane fade" id="v-pills-warranty" role="tabpanel"
                                aria-labelledby="v-pills-warranty-tab">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-primary border-0">
                                        <h4 class="font-weight-semi-bold m-0 text-white">Chính sách bảo hành</h4>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="text-primary mb-3"><i class="fas fa-check-circle me-2"></i>1. Thời
                                            gian bảo hành</h5>
                                        <p>Tất cả các sản phẩm điện tử bán ra tại <strong>Electro</strong> đều được bảo
                                            hành chính hãng <strong>12 tháng</strong> kể từ ngày mua hàng. Đối với phụ
                                            kiện, thời gian bảo hành là <strong>6 tháng</strong>.</p>

                                        <h5 class="text-primary mb-3 mt-4"><i class="fas fa-clipboard-list me-2"></i>2.
                                            Điều kiện bảo hành hợp lệ</h5>
                                        <ul class="list-group list-group-flush mb-3">
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-angle-right text-secondary me-2"></i>Sản phẩm còn
                                                trong thời hạn bảo hành căn cứ vào tem dán trên sản phẩm và hóa đơn mua
                                                hàng.</li>
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-angle-right text-secondary me-2"></i>Sản phẩm bị lỗi
                                                kỹ thuật do nhà sản xuất (lỗi màn hình, lỗi mainboard, lỗi pin...).</li>
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-angle-right text-secondary me-2"></i>Tem bảo hành, số
                                                Serial/IMEI trên sản phẩm phải còn nguyên vẹn, không bị rách, tẩy xóa,
                                                cạo sửa.</li>
                                        </ul>

                                        <h5 class="text-primary mb-3 mt-4"><i class="fas fa-ban me-2"></i>3. Trường hợp
                                            từ chối bảo hành</h5>
                                        <ul class="list-group list-group-flush mb-3">
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-times text-danger me-2"></i>Sản phẩm bị hư hỏng do tác
                                                động cơ học (rơi vỡ, va đập, trầy xước, móp méo...).</li>
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-times text-danger me-2"></i>Sản phẩm bị ngấm nước hoặc
                                                các chất lỏng khác.</li>
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-times text-danger me-2"></i>Sản phẩm đã bị tự ý tháo
                                                dỡ, sửa chữa bởi các cá nhân hoặc đơn vị không được ủy quyền.</li>
                                            <li class="list-group-item border-0 px-0"><i
                                                    class="fas fa-times text-danger me-2"></i>Hư hỏng do sử dụng sai
                                                điện áp hoặc do thiên tai, hỏa hoạn.</li>
                                        </ul>

                                        <h5 class="text-primary mb-3 mt-4"><i class="fas fa-sync-alt me-2"></i>4. Chính
                                            sách đổi trả</h5>
                                        <p>Khách hàng được đổi mới sản phẩm cùng loại trong vòng <strong>30
                                                ngày</strong> đầu tiên nếu sản phẩm gặp lỗi do nhà sản xuất. Sản phẩm
                                            đổi trả phải còn nguyên vẹn, đầy đủ hộp và phụ kiện đi kèm.</p>

                                        <div class="alert alert-info mt-4 mb-0">
                                            <i class="fas fa-info-circle me-2"></i>Mọi thắc mắc về bảo hành, quý khách
                                            vui lòng liên hệ Hotline: <strong>1800 2097</strong> (Miễn phí).
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Profile End -->

            <style>
                .nav-pills .nav-link {
                    color: #333;
                    border-bottom: 1px solid #f0f0f0;
                    border-radius: 0;
                    transition: all 0.3s;
                }

                .nav-pills .nav-link:hover {
                    background-color: #f8f9fa;
                    color: var(--bs-primary);
                    padding-left: 1.8rem !important;
                    /* Slide effect */
                }

                .nav-pills .nav-link.active {
                    background-color: #fff3e0;
                    color: var(--bs-primary);
                    border-left: 4px solid var(--bs-primary);
                    font-weight: 600;
                }

                .nav-pills .nav-link i {
                    width: 20px;
                    text-align: center;
                }
            </style>

            <!-- Include Footer -->
            <jsp:include page="common/footer.jsp" />