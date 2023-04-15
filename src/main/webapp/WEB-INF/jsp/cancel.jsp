<%-- 
    Document   : cancel
    Created on : Apr 1, 2023, 9:10:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="text-center my-4">
    <div class="border border-dark">
        <h3 class="text-danger">Đã hủy đơn hàng</h3>
        <p>vào lúc <fmt:formatDate value="${cancel.cancelDate}" pattern="dd-MM-yyyy hh:mm:ss" /></p>
    </div>
</div>
<div class="text-center my-4">
    <div class="border border-dark bg-light">
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
                    <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}" class="btn border-dark p-2">Xem shop</a>
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
                            <label><fmt:formatNumber value="${od.idProduct.price}" maxFractionDigits="3" type="number"/></label>
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
                    <td><b>Yêu cầu bởi</b></td>
                    <td>
                        <c:if test="${cancel.idAccount.role == 'ROLE_CUSTOMER'}">
                            <span>Người mua</span> 
                        </c:if>
                        <c:if test="${cancel.idAccount.role == 'ROLE_SELLER'}">
                            <span>Người bán</span> 
                        </c:if>
                        <c:if test="${cancel.idAccount.role == 'ROLE_ADMIN'}">
                            <span>Hệ thống Webecommerce</span> 
                        </c:if>
                    </td>
                </tr>
                <tr class="text-right">
                    <td><b>Yêu cầu vào</b></td>
                    <td> <fmt:formatDate value="${cancel.cancelDate}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                </tr>
                <tr class="text-right">
                    <td><b>Lý do</b></td>
                    <td> <span>${cancel.cancelDescription}</span> </td>
                </tr>
                <tr class="text-right">
                    <td><b>Phương thức thanh toán</b></td>
                    <td> 
                        <c:if test="${order.paymentType == 1}">
                            <span>Thanh toán tại nhà</span> 
                        </c:if>
                        <c:if test="${order.paymentType == 2}">
                            <span>Thanh toán online</span> 
                        </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>