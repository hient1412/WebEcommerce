<%-- 
    Document   : cart
    Created on : Sep 27, 2022, 10:50:21 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "sec" uri = "http://www.springframework.org/security/tags" %>

<c:if test="${cartProducts != null}">
    <c:if test="${cartProducts.size() != 0}">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                        <div class="card-body p-0">
                            <div class="row g-0">
                                <div class="col-lg-8">
                                    <div class="p-5">
                                        <div class="d-flex justify-content-between align-items-center mb-5">
                                            <h3 class="fw-bold mb-0 text-black">GIỎ HÀNG</h3>
                                            <h6 class="mb-0 text-muted">${cartCounter} sản phẩm</h6>
                                        </div>
                                        <hr class="my-4">
                                        <c:forEach items="${cartProducts}" var="c">
                                            <div class="row mb-4 d-flex justify-content-between align-items-center" id="product${c.productId}">
                                                <div class="d-flex">
                                                    <div class="user-2 d-inline-block">
                                                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSellerById(c.seller.id).id}"><img class="rounded-circle img-fluid" src="${seller.getSellerById(c.seller.id).avatar}"></a>
                                                    </div>
                                                    <div class="d-inline">
                                                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSellerById(c.seller.id).id}"><label>${seller.getSellerById(c.seller.id).name}</label></a> <i class="fa fa-comments" aria-hidden="true"></i>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 col-lg-2 col-xl-2">
                                                    <img
                                                        src="${c.img}"
                                                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-3">
                                                    <h6 class="text-muted">Sản phẩm</h6>
                                                    <h6 class="text-black mb-0">${c.productName}</h6>
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-2">
                                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber type="number" maxFractionDigits="3" value="${c.price}" />
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-2 d-flex product-count">
                                                    <form action="# " style="display: flex;">
                                                        <input type="number" id="quantity" class="qty" onblur="updateCart(this, ${c.productId})" value="${c.count}" min="1">
                                                    </form>
                                                </div>
                                                <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                    <a class="text-danger" onclick="deleteItemInCart(${c.productId})" aria-label="Delete">
                                                        <i style="font-size: 22px" class="fa-solid fa-trash-can p-1"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <hr class="my-4">

                                        <div class="pt-5">
                                            <h6 class="mb-0"><a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i>Trở về trang chủ</a></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 bg-grey">
                                    <div class="p-5">
                                        <h4 class="fw-bold mb-5 mt-2 pt-1">HÓA ĐƠN</h4>
                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-4">
                                            <h6 class="text-uppercase">Tiền hàng: </h6>
                                            <h5><span id="cartAmount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartAmount.amount}"/></span> VNĐ</h5>
                                        </div>
                                        <h5 class="text-uppercase mb-3">Voucher</h5>

                                        <div class="mb-5">
                                            <div class="form-outline">
                                                <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                                <label class="form-label" for="form3Examplea2">Nhập mã voucher</label>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-5">
                                            <h5 class="text-uppercase">Tổng tiền: </h5>
                                            <h5><span id="cartAmount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartAmount.amount}"/></span> VNĐ</h5>
                                        </div>
                                        <sec:authorize access="isAuthenticated()">
                                            <sec:authorize access="hasRole('ROLE_CUSTOMER')">
                                                <a class="btn btn-dark btn-block btn-lg" data-mdb-ripple-color="dark" href="<c:url value="/checkout"/>">Thanh toán </a>
                                            </sec:authorize>
                                            <sec:authorize access="!hasRole('ROLE_CUSTOMER')">
                                                <div  class="center text-danger">
                                                    <h4>KHÔNG CÓ QUYỀN THANH TOÁN!!! </h4>
                                                </div>
                                            </sec:authorize>
                                        </sec:authorize>
                                        <sec:authorize access="!isAuthenticated()">
                                            <div>
                                                <h6 class="center">VUI LÒNG <a href="<c:url value="/login"/>">ĐĂNG NHẬP</a> ĐỂ CÓ THỂ THANH TOÁN!!! </h6>
                                            </div>
                                        </sec:authorize>  
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${cartProducts.size() == 0}">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                        <div class="card-body p-0">
                            <div class="row g-0">
                                <div class="col-lg-8">
                                    <div class="p-5">
                                        <div class="d-flex justify-content-between align-items-center mb-5">
                                            <h1 class="fw-bold mb-0 text-black">GIỎ HÀNG</h1>
                                            <h6 class="mb-0 text-muted">0 sản phẩm</h6>
                                        </div>
                                        <hr class="my-4">
                                        <h4 class="text-primary">Bạn chưa thêm sản phẩm vào giỏ hàng</h4>
                                        <hr class="my-4">

                                        <div class="pt-5">
                                            <h6 class="mb-0">
                                                <a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i>Trở về trang chủ</a>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 bg-grey">
                                    <div class="p-5">
                                        <h3 class="fw-bold mb-5 mt-2 pt-1">HÓA ĐƠN</h3>
                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-4">
                                            <h5 class="text-uppercase">Tiền hàng: </h5>
                                            <span style="text-decoration: underline">đ</span> 0
                                        </div>


                                        <h5 class="text-uppercase mb-3">Voucher</h5>

                                        <div class="mb-5">
                                            <div class="form-outline">
                                                <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                                <label class="form-label" for="form3Examplea2">Nhập mã voucher</label>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-5">
                                            <h5 class="text-uppercase">Tổng tiền:</h5>
                                            <span style="text-decoration: underline">đ</span> 0
                                        </div>

                                        <button type="button" class="btn btn-dark btn-block btn-lg"
                                                data-mdb-ripple-color="dark">Thanh toán 
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</c:if>
<c:if test="${cartProducts == null}">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12">
                <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                    <div class="card-body p-0">
                        <div class="row g-0">
                            <div class="col-lg-8">
                                <div class="p-5">
                                    <div class="d-flex justify-content-between align-items-center mb-5">
                                        <h1 class="fw-bold mb-0 text-black">GIỎ HÀNG</h1>
                                        <h6 class="mb-0 text-muted">0 sản phẩm</h6>
                                    </div>
                                    <hr class="my-4">
                                    <h4 class="text-primary">Bạn chưa thêm sản phẩm vào giỏ hàng</h4>
                                    <hr class="my-4">

                                    <div class="pt-5">
                                        <h6 class="mb-0">
                                            <a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i>Trở về trang chủ</a>
                                        </h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 bg-grey">
                                <div class="p-5">
                                    <h3 class="fw-bold mb-5 mt-2 pt-1">HÓA ĐƠN</h3>
                                    <hr class="my-4">

                                    <div class="d-flex justify-content-between mb-4">
                                        <h5 class="text-uppercase">Tiền hàng: </h5>
                                        <span style="text-decoration: underline">đ</span> 0
                                    </div>

                                    <h5 class="text-uppercase mb-3">Voucher</h5>

                                    <div class="mb-5">
                                        <div class="form-outline">
                                            <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                            <label class="form-label" for="form3Examplea2">Nhập mã voucher</label>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <div class="d-flex justify-content-between mb-5">
                                        <h5 class="text-uppercase">Tổng tiền: </h5>
                                        <span style="text-decoration: underline">đ</span> 0
                                    </div>

                                    <button type="button" class="btn btn-dark btn-block btn-lg"
                                            data-mdb-ripple-color="dark">Thanh toán 
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script src="<c:url value="/js/cart.js" />"></script>
