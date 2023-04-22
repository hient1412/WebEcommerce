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
                    <button class="border-dark p-2"><i class="fa fa-comments" aria-hidden="true"></i> <spring:message code="label.chat"/></button>
                </div>
            </div>
            <hr>
            <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">
                <div class="row align-items-center">
                    <div class="col text-center">
                        <div class="product-img-4">
                            <div class="mb-2">
                                <img src="${od.idProduct.imageCollection.get(0).image}">
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
                            <label><span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${od.idProduct.price}" maxFractionDigits="3" type="number"/></label>
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
                    <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.trans.fee"/></b></td>
                    <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="0" maxFractionDigits="3" type="number"/><br></td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.total.amount"/></b></td>
                    <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
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
        </div>
    </c:if>
    <c:if test="${order.active == 5}">  <!-- Đặt hàng thành công -->
        <div class="p-4">
            <a class="btn btn-outline-success" ><spring:message code="label.buy.again"/></a>
        </div>
    </c:if>
    <c:if test="${order.active == 4}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/customer/order-detail/${order.id}/confirm"/>"><spring:message code="label.order.finish"/></a>
        </div>
    </c:if>
</div>
<div class="modal fade" id="reasonCancel" tabindex="-1" aria-labelledby="reasonCancel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><spring:message code="label.give.reason.order.cancellation"/></h5>
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