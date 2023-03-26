<%-- 
    Document   : sel-order-detail
    Created on : Mar 26, 2023, 11:00:12 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container">
    <div class="center p-4">
        <h1 >CHI TIẾT ĐƠN HÀNG </h1>
        <span>Mã đơn hàng: ${order.id}</span>
    </div>

    <div class="mt-3">
        <div class="border border-dark">
            <div class="p-4">
                <h4>Địa chỉ nhận hàng</h4>
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
    <div class="bg-light">
        <div class="border-left border-right border-dark">
            <div class="p-3">
                <div class="row">
                    <div class="col-md-10">
                        <div class="user-3 d-inline-block">
                            <img class="rounded-circle img-fluid" src="${order.idCustomer.avatar}">
                        </div>
                        <div class="d-inline"  style="font-size: 24px;">
                            <b><label>${order.idCustomer.idAccount.username}</label></b>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button class="border-dark p-2"><i class="fa fa-comments" aria-hidden="true"></i> Liên hệ</button>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-8">
                        <div class="row">
                            <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">
                                <div class="col-md-2">
                                    <div class="product-img-4">
                                        <div class="mb-2">
                                            <img src="${od.idProduct.imageCollection.get(0).image}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label>${od.idProduct.name}</label>
                                    </div>
                                </div>
                                <div class="col-md-3 center">
                                    <div class="mb-3">
                                        <label>x ${od.quantity}</label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-md-6 center">
                                <div>
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br>
                                    <c:if test="${order.paymentType == 1}">
                                        <span style="font-size: 10px;color: #ccc">Thanh toán tại nhà</span>
                                    </c:if>
                                    <c:if test="${order.paymentType == 2}">
                                        <span style="font-size: 10px;color: #ccc">Thanh toán qua thẻ</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-6 center">
                                <div>
                                    <c:if test="${order.active == 1}">
                                        <label>Đã đặt hàng</label>
                                    </c:if>
                                    <c:if test="${order.active == 0}">
                                        <label>Đã hủy</label>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mb-3">
        <div class="border border-dark">
            <div class="p-4">
                <h4>Địa chỉ nhận hàng</h4>
                <p>
                    ètghjsadfghj
                </p>
            </div>
        </div>
    </div>
</div>