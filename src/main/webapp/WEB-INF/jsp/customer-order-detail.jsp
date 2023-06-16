<%--
    Document   : customer-order-detail
    Created on : Feb 21, 2023, 7:43:36 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<c:if test="${errMessage != null}">
    <div class="text-danger pt-4 text-center" style="font-size: 20px;">
        ${errMessage}
    </div>
</c:if>
<div class="center p-4">
    <h3 class="text-center"><spring:message code="label.order.details"/></h3>
    <span><spring:message code="label.order.id"/>: ${order.id}</span>
    <br>
    <span><spring:message code="label.order.date"/>: <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy hh:mm:ss" /></span>
    <c:if test="${order.active != 5}">
        <c:if test="${order.daySend != null}">
            <br>
            <h5 class="text-danger"><spring:message code="label.seller.must.send"/>: <fmt:formatDate value="${order.daySend}" pattern="dd-MM-yyyy" /></h5>
        </c:if>
    </c:if>
    <c:if test="${order.active != 0}">
        <h5 class="text-success"><spring:message code="label.order.status"/>:
            <c:if test="${order.active == 1}">
                <spring:message code="label.order.status.one"/>
            </c:if>
            <c:if test="${order.active == 2}">
                <spring:message code="label.order.status.two"/>
            </c:if>
            <c:if test="${order.active == 3}">
                <spring:message code="label.order.status.three"/>
            </c:if>
            <c:if test="${order.active == 4}">
                <spring:message code="label.order.status.four"/>
            </c:if>
            <c:if test="${order.active == 5}">
                <spring:message code="label.order.status.five"/> (<spring:message code="label.at"/>: <fmt:formatDate value="${order.orderReceived}" pattern="dd-MM-yyyy hh:mm:ss" />)
            </c:if>
        </h5>
    </c:if>
    <c:if test="${order.active == 0}">
        <h5 class="text-danger"><spring:message code="label.order.status"/>: <spring:message code="label.order.status.six"/> </h5>
        <a href="<c:url value="/customer/cancel/${order.id}"/>"><spring:message code="label.order.cancel.detail"/> </a>
        <br>
    </c:if>

    <span><spring:message code="label.Estimated.delivery.date"/>: <fmt:formatDate value="${order.requiredDate}" pattern="dd-MM-yyyy" /></span>
    <br>
</div>

<div class="mt-3">
    <div class="border border-dark">
        <div class="p-4">
            <h4><spring:message code="label.address"/></h4>
            <div class="row pt-3">
                <div class="col-md-12">
                    <b>${order.idShipAdress.name}</b> <span> | </span><label> ${order.idShipAdress.phone}</label>
                    <p class="capitalizeText">${order.idShipAdress.address}</p>
                    <p><span class="capitalizeText">${order.idShipAdress.ward}</span><span class="capitalizeText">, ${order.idShipAdress.district}</span><span>, ${order.idShipAdress.city.name} </span>
                </div>
            </div>
        </div>
    </div>
</div>
<div>
    <div class="border-left border-right border-dark bg-light">
        <div class="p-3">
            <div class="d-flex">
                <div >
                    <div class="user-3 d-inline-block">
                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}"><img class="rounded-circle img-fluid" src="${seller.getSeller(order.id)[1]}"></a>
                    </div>
                    <div class="d-inline" style="font-size: 24px;">
                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}"><label>${seller.getSeller(order.id)[0]}</label></a>
                    </div>
                </div>
                <div class="ml-auto">
                    <button class="border-dark p-2"> <spring:message code="label.see.shop"/></button>
                </div>
            </div>
            <hr>
            <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">
                <div class="row align-items-center">
                    <div class="col text-center">
                        <div class="product-img-4">
                            <div class="mb-2">
                                <a href="<c:url value="/product-detail/${od.idProduct.id}"/>"><img src="${od.idProduct.imageCollection.get(0).image}"></a>
                            </div>
                        </div>
                        <div class="mt-3">
                            <div class="mb-3">
                                <label>${od.idProduct.name}</label>
                            </div>
                        </div>
                    </div>
                    <div class="col center">
                        <div class="mb-3">
                            <label>x ${od.quantity}</label>
                        </div>
                    </div>
                    <div class="col center">
                        <div class="mb-3">
                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                <span id="vndPrice" name="vndPrice">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${od.idProduct.price}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                <span id="usdPrice" name="usdPrice" >
                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(od.idProduct.price)}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<div class="mb-3">
    <div class="border border-dark bg-light">
        <table class="table table-bordered p-0 m-0">
            <tbody>
                <tr class="text-right">
                    <td><b><spring:message code="label.total.amount"/></b></td>
                    <td>
                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                            <span id="vndPrice" name="vndPrice">
                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                        <c:if test="${pageContext.response.locale.language == 'en'}">
                            <span id="usdPrice" name="usdPrice" >
                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(order.amount)}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                        <br>
                    </td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.trans.fee"/></b></td>
                    <td>
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
                        <br>
                    </td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.total.amount"/></b></td>
                    <td>
                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                            <span id="vndPrice" name="vndPrice">
                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                        <c:if test="${pageContext.response.locale.language == 'en'}">
                            <span id="usdPrice" name="usdPrice" >
                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(order.amount)}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                        <br>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="border border-dark text-right bg-light">
    <div class="p-2">
        <h5><spring:message code="label.payment.type"/></h5>
        <c:if test="${order.paymentType == 1}">
            <h6 style="color: #267bd1"><spring:message code="label.payment.home"/></h6>
        </c:if>
        <c:if test="${order.paymentType == 2}">
            <h6 style="color: #267bd1"><spring:message code="label.payment.online"/></h6>
        </c:if>
    </div>
</div>
<div class="d-flex">
    <div class="py-4">
        <a class="btn btn-dark" href="<c:url value="/customer/list-cus-order"/>"><i class="fa-solid fa-arrow-left"></i> <spring:message code="label.back"/></a>
    </div>
    <c:if test="${order.active == 1 || order.active == 2}">  <!-- Đặt hàng hoặc chờ lấy hàng -->
        <div class="p-4">
            <a class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#reasonCancel"><spring:message code="label.cancel.order"/></a>
            <div class="modal fade" id="reasonCancel" tabindex="-1" aria-labelledby="reasonCancel" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="exampleModalLabel"><spring:message code="label.give.reason.order.cancellation"/></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form:form action="" modelAttribute="cancel" method="post">
                            <div class="modal-body">
                                <form:select path="cancelDescription" >
                                    <c:if test="${order.active == 1}">
                                        <form:option value="Đổi ý, không muốn mua nữa" label="Đổi ý, không muốn mua nữa"/>
                                    </c:if>
                                    <c:if test="${order.active == 2}">
                                        <form:option value="Người bán gửi hàng lâu" label="Người bán gửi hàng lâu"/>
                                    </c:if>
                                    <form:option value="Muốn thay đổi sản phẩm" label="Muốn thay đổi sản phẩm"/>
                                    <form:option value="Muốn thay đổi phương thức thanh toán" label="Muốn thay đổi phương thức thanh toán"/>
                                    <form:option value="Khác" label="Khác"/>
                                </form:select>

                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary"><spring:message code="label.done"/></button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${order.active == 5}">  <!-- Đặt hàng thành công -->
        <div class="p-4">
            <a data-bs-toggle="modal" data-bs-target="#reviewModal" class="btn btn-outline-success" ><spring:message code="label.review"/></a>

            <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModal" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="reviewModal"><spring:message code="label.review"/></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">

                                <div class="row align-items-center">
                                    <div class="col-md-3">
                                        <div class="product-img-4">
                                            <div class="mb-2">
                                                <a href="<c:url value="/product-detail/${od.idProduct.id}"/>"><img src="${od.idProduct.imageCollection.get(0).image}"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="mb-3">
                                            <label>${od.idProduct.name}</label>
                                        </div>
                                    </div>
                                    <c:if test="${productService.checkExistReview(od.idProduct.id, pageContext.session.getAttribute('current').getId()) != 1}">
                                        <div id="rating">
                                            <input type="radio" id="rate1" name="rating" value="1" />
                                            <label for="rate1" >&#9733;</label>

                                            <input type="radio" id="rate2" name="rating" value="2" />
                                            <label for="rate2" >&#9733;</label>

                                            <input type="radio" id="rate3" name="rating" value="3" />
                                            <label for="rate3" >&#9733;</label>

                                            <input type="radio" id="rate4" name="rating" value="4" />
                                            <label for="rate4" >&#9733;</label>

                                            <input type="radio" id="rate5" name="rating" value="5" />
                                            <label for="rate5" >&#9733;</label>

                                        </div>
                                        <c:url value="/api/product/${od.idProduct.id}/review" var="endpoint"/>
                                        <div class="d-flex flex-row mb-4">
                                            <textarea type="text" maxlength="200" id="inputReview${od.idProduct.id}" class="form-control mr-3" placeholder='<spring:message code="label.enter.review"/>!!!'></textarea>
                                            <input onclick="addReviews('${endpoint}',${od.idProduct.id})" class="btn btn-primary text-light" type="submit" value="<spring:message code="label.done"/>"/>
                                        </div>
                                    </c:if> 
                                    <c:if test="${productService.checkExistReview(od.idProduct.id, pageContext.session.getAttribute('current').getId()) == 1}">
                                        <div class="col-md-4 text-center">
                                            <a href="<c:url value="/product-detail/${od.idProduct.id}#review"/>"><spring:message code="label.see.review"/></a>
                                        </div>
                                    </c:if> 
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${order.active == 5}">  <!-- Đặt hàng thành công -->
        <div class="py-4">
            <a data-bs-toggle="modal" data-bs-target="#buyAgainModal" class="btn btn-outline-success" ><spring:message code="label.buy.again"/></a>
            <div class="modal fade p-0" id="buyAgainModal" tabindex="-1" aria-labelledby="buyAgainModal" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered" >
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="buyAgainModal"><spring:message code="label.confirm.information"/></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5><spring:message code="label.customer.information"/></h5>
                            <p for="fname"><i class="fa fa-user"></i> <spring:message code="label.customer.firstname"/></p>
                            <input type="text" class="w-100" id="fname" name="firstname" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getName()}" disabled>

                            <p for="email"><i class="fa fa-phone"></i> <spring:message code="label.phone"/></p>
                            <input type="text" class="w-100" id="phone" name="phone" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getPhone()}" disabled>

                            <p for="email"><i class="fa fa-envelope"></i> <spring:message code="label.email"/></p>
                            <input type="text" class="w-100" id="email" name="email" value="${pageContext.session.getAttribute('currentCustomer').getEmail()}" disabled>

                            <p for="adr"><i class="fa fa-address-card-o"></i> <spring:message code="label.address"/></p>

                            <input type="text" class="w-100" id="adr" name="address" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getAddress()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getWard()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getDistrict()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getCity().getName()} " disabled >
                            <h5 class="py-2"><spring:message code="label.product.information"/></h5>
                            <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">
                                <div class="row align-items-center">
                                    <div class="col text-center">
                                        <div class="product-img-4">
                                            <div class="mb-2">
                                                <a href="<c:url value="/product-detail/${od.idProduct.id}"/>"><img src="${od.idProduct.imageCollection.get(0).image}"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col center">
                                        <div class="mb-3">
                                            <label>${od.idProduct.name}</label>
                                        </div>
                                    </div>
                                    <div class="col center">
                                        <div class="mb-3">
                                            <label>x ${od.quantity}</label>
                                        </div>
                                    </div>
                                    <div class="col text-right">
                                        <div class="mb-3">
                                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                <span id="vndPrice" name="vndPrice">
                                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${od.idProduct.price}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                                <span id="usdPrice" name="usdPrice" >
                                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(od.idProduct.price)}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="row">
                                <div class="col-md-9 text-right">
                                    <p><strong class="px-4"><spring:message code="label.total.amount"/></strong></p>
                                    <p><strong class="px-4"><spring:message code="label.trans.fee"/></strong></p>
                                    <p><strong class="px-4"><spring:message code="label.order.total"/></strong></p>
                                </div>
                                <div class="col-md-3 text-right">
                                    <div class="mb-3">
                                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                                            <span id="vndPrice" name="vndPrice">
                                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${pageContext.response.locale.language == 'en'}">
                                            <span id="usdPrice" name="usdPrice" >
                                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(order.amount)}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="mb-3">
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
                                    <div class="mb-3">
                                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                                            <span id="vndPrice" name="vndPrice">
                                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${pageContext.response.locale.language == 'en'}">
                                            <span id="usdPrice" name="usdPrice" >
                                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(order.amount)}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="<c:url value="/customer/order-detail/${order.id}/buyAgain"/>" class="btn btn-primary"><spring:message code="label.done"/></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>