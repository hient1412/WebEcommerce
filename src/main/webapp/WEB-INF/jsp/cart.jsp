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
                                            <h3 class="fw-bold mb-0 text-black text-uppercase"><spring:message code="label.cart"/></h3>
                                            <h6 class="mb-0 text-muted">${cartCounter} <spring:message code="label.product"/></h6>
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
                                                <div class="col">
                                                    <img
                                                        src="${c.img}"
                                                        class="img-fluid rounded-3">
                                                </div>
                                                <div class="col">
                                                    <h6 class="text-black mb-0">${c.productName}</h6>
                                                </div>
                                                <div class="col">
                                                    <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                        <span id="vndPrice" name="vndPrice">
                                                            <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${c.price}" maxFractionDigits="3" type="number"/>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${pageContext.response.locale.language == 'en'}">
                                                        <span id="usdPrice" name="usdPrice" >
                                                            <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(c.price)}" maxFractionDigits="3" type="number"/>
                                                        </span>
                                                    </c:if>
                                                </div>
                                                <div class="col d-flex product-count">
                                                    <form action="# " style="display: flex;">
                                                        <input type="number" id="quantity${c.productId}" class="qty" onblur="updateItemCart(this, ${c.productId}, ${product.getProductById(c.productId).quantity})" value="${c.count}" min="1">
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
                                            <h6 class="mb-0"><a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i><spring:message code="label.back.home"/></a></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="p-5 bg-grey">
                                        <h4 class="fw-bold mb-5 mt-2 pt-1 text-uppercase"><spring:message code="label.bill"/></h4>
                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-4">
                                            <h6 class="text-uppercase"><spring:message code="label.product.money"/>: </h6>
                                            <h5>
                                                <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                    <span id="vndPrice" name="vndPrice">
                                                        <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${cartAmount.amount}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                                <c:if test="${pageContext.response.locale.language == 'en'}">
                                                    <span id="usdPrice" name="usdPrice" >
                                                        <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(cartAmount.amount)}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                            </h5>
                                        </div>
                                        <h5 class="text-uppercase mb-3"><spring:message code="label.promotion"/></h5>

                                        <div class="mb-5">
                                            <div class="form-outline">
                                                <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                                <label class="form-label" for="form3Examplea2"><spring:message code="label.promo.code"/></label>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-5">
                                            <h5 class="text-uppercase"><spring:message code="label.total.amount"/>: </h5>
                                            <h5>
                                                <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                    <span id="vndPrice" name="vndPrice">
                                                        <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${cartAmount.amount}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                                <c:if test="${pageContext.response.locale.language == 'en'}">
                                                    <span id="usdPrice" name="usdPrice" >
                                                        <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(cartAmount.amount)}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                            </h5>
                                        </div>
                                        <sec:authorize access="isAuthenticated()">
                                            <sec:authorize access="hasRole('ROLE_CUSTOMER')">
                                                <a class="btn btn-dark btn-block btn-lg" data-mdb-ripple-color="dark" href="<c:url value="/customer/checkout"/>"><spring:message code="label.pay"/> </a>
                                            </sec:authorize>
                                            <sec:authorize access="!hasRole('ROLE_CUSTOMER')">
                                                <div  class="center text-danger">
                                                    <h4 class="text-uppercase"><spring:message code="label.not.right.to.pay"/>!!! </h4>
                                                </div>
                                            </sec:authorize>
                                        </sec:authorize>
                                        <sec:authorize access="!isAuthenticated()">
                                            <div>
                                                <h6 class="center text-uppercase"><spring:message code="label.please"/> <a href="<c:url value="/login"/>"><spring:message code="label.login"/></a> <spring:message code="label.to.pay"/>!!! </h6>
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
                                            <h3 class="fw-bold mb-0 text-black text-uppercase"><spring:message code="label.cart"/></h3>
                                            <h6 class="mb-0 text-muted">0 <spring:message code="label.product"/></h6>
                                        </div>
                                        <hr class="my-4">
                                        <h4 class="text-primary"><spring:message code="label.not.cart"/></h4>
                                        <hr class="my-4">

                                        <div class="pt-5">
                                            <h6 class="mb-0">
                                                <a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i><spring:message code="label.back.home"/></a>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 ">
                                    <div class="p-5 bg-grey">
                                        <h3 class="fw-bold mb-5 mt-2 pt-1 text-uppercase"><spring:message code="label.bill"/></h3>
                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-4">
                                            <h5 class="text-uppercase"><spring:message code="label.product.money"/>: </h5>
                                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                <span id="vndPrice" name="vndPrice">
                                                    <span style="text-decoration: underline">đ</span> 0
                                                </span>
                                            </c:if>
                                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                                <span id="usdPrice" name="usdPrice" >
                                                    <span>$</span> 0
                                                </span>
                                            </c:if>
                                        </div>


                                        <h5 class="text-uppercase mb-3"><spring:message code="label.promotion"/></h5>

                                        <div class="mb-5">
                                            <div class="form-outline">
                                                <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                                <label class="form-label" for="form3Examplea2"><spring:message code="label.promo.code"/></label>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <div class="d-flex justify-content-between mb-5">
                                            <h5 class="text-uppercase"><spring:message code="label.total.amount"/>:</h5>
                                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                <span id="vndPrice" name="vndPrice">
                                                    <span style="text-decoration: underline">đ</span> 0
                                                </span>
                                            </c:if>
                                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                                <span id="usdPrice" name="usdPrice" >
                                                    <span>$</span> 0
                                                </span>
                                            </c:if>
                                        </div>

                                        <button type="button" class="btn btn-dark btn-block btn-lg"
                                                data-mdb-ripple-color="dark"><spring:message code="label.pay"/>
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
                                        <h3 class="fw-bold mb-0 text-black text-uppercase"><spring:message code="label.cart"/></h3>
                                        <h6 class="mb-0 text-muted">0 <spring:message code="label.product"/></h6>
                                    </div>
                                    <hr class="my-4">
                                    <h4 class="text-primary"><spring:message code="label.not.cart"/></h4>
                                    <hr class="my-4">

                                    <div class="pt-5">
                                        <h6 class="mb-0">
                                            <a href="<c:url value="/" />" class="text-body"><i class="fas fa-long-arrow-alt-left me-2"></i><spring:message code="label.back.home"/></a>
                                        </h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="p-5 bg-grey">
                                    <h3 class="fw-bold mb-5 mt-2 pt-1 text-uppercase"><spring:message code="label.bill"/></h3>
                                    <hr class="my-4">

                                    <div class="d-flex justify-content-between mb-4">
                                        <h5 class="text-uppercase"><spring:message code="label.product.money"/>: </h5>
                                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                                            <span id="vndPrice" name="vndPrice">
                                                <span style="text-decoration: underline">đ</span> 0
                                            </span>
                                        </c:if>
                                        <c:if test="${pageContext.response.locale.language == 'en'}">
                                            <span id="usdPrice" name="usdPrice" >
                                                <span>$</span> 0
                                            </span>
                                        </c:if>
                                    </div>

                                    <h5 class="text-uppercase mb-3"><spring:message code="label.promotion"/></h5>

                                    <div class="mb-5">
                                        <div class="form-outline">
                                            <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                            <label class="form-label" for="form3Examplea2"><spring:message code="label.promo.code"/></label>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <div class="d-flex justify-content-between mb-5">
                                        <h5 class="text-uppercase"><spring:message code="label.total.amount"/>: </h5>
                                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                                            <span id="vndPrice" name="vndPrice">
                                                <span style="text-decoration: underline">đ</span> 0
                                            </span>
                                        </c:if>
                                        <c:if test="${pageContext.response.locale.language == 'en'}">
                                            <span id="usdPrice" name="usdPrice" >
                                                <span>$</span> 0
                                            </span>
                                        </c:if>
                                    </div>

                                    <button type="button" class="btn btn-dark btn-block btn-lg"
                                            data-mdb-ripple-color="dark"><spring:message code="label.pay"/>
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
<script>
                                                        function updateItemCart(pThis, pProductId, pQuantity) {
                                                            let pId = 'quantity' + pProductId;
                                                            let pTempCount = document.getElementById(pId).value;
                                                            if (pTempCount > pQuantity) {
                                                                alert("Số lượng hàng bạn đặt vượt quá số lượng hàng còn lại! Vui lòng kiểm tra lại.");
                                                                document.getElementById(pId).value = pQuantity;
                                                            }
                                                            updateCart(pThis, pProductId);
                                                        }
</script>
