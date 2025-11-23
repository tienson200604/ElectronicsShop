<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="product" value="${requestScope.product}" />

<c:choose>
    <c:when test="${product ne null}">
        <c:set var="pageTitle" value="${product.name}" scope="request"/>
    </c:when>
    <c:otherwise>
        <c:set var="pageTitle" value="Product Detail" scope="request"/>
    </c:otherwise>
</c:choose>
<c:set var="pageActive" value="Shop" scope="request"/>

<jsp:include page="/common/header.jsp" />

<c:if test="${product == null}">
    <c:redirect url="${contextPath}/shop" />
</c:if>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Product Detail</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${contextPath}/shop">Shop</a></li>
        <li class="breadcrumb-item active text-white">${product.name}</li>
    </ol>
</div>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-md-5">
            <div class="border rounded p-3 text-center">
                <img src="${contextPath}/${product.imagePath}"
                     alt="${product.name}"
                     class="img-fluid rounded"
                     style="max-height:420px;object-fit:contain;">
            </div>
        </div>

        <div class="col-md-7">
            <h2 class="fw-bold mb-3">${product.name}</h2>

            <p class="text-muted mb-3">
                ${product.shortDescription}
            </p>

            <div class="mb-3">
                <c:choose>
                    <c:when test="${product.salePrice gt 0}">
                        <del class="text-danger fs-5 me-2">
                            <fmt:formatNumber value="${product.price}" pattern="#,##0"/> ₫
                        </del>
                        <span class="text-primary fs-3 fw-bold">
                            <fmt:formatNumber value="${product.salePrice}" pattern="#,##0"/> ₫
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-primary fs-3 fw-bold">
                            <fmt:formatNumber value="${product.price}" pattern="#,##0"/> ₫
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>


            <form action="${contextPath}/cart" method="get" class="d-flex align-items-center mb-3">
                <input type="hidden" name="action" value="add"/>
                <input type="hidden" name="pid" value="${product.id}"/>

                <div class="input-group" style="width:130px;">
                    <input type="number" class="form-control text-center"
                           name="quantity" value="1" min="1">
                </div>
                <button type="submit"
                        class="btn btn-primary rounded-pill py-2 px-4 ms-3">
                    <i class="fa fa-shopping-cart me-2"></i> Add To Cart
                </button>
            </form>

            <hr/>

            <p class="mb-1"><strong>Product ID:</strong> ${product.id}</p>
            <p class="mb-1"><strong>Brand:</strong> ${product.brandName}</p>
            <p class="mb-1"><strong>Description:</strong> ${product.description}</p>
            <p class="mb-1"><strong>Warranty:</strong> ${product.warrantyMonths} months</p>
            <p class="mb-1"><strong>Stock:</strong> ${product.stockQuantity}</p>
            <p class="mb-1">
                <strong>Category:</strong>
                ${product.categoryName}
            </p>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
