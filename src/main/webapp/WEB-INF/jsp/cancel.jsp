<%-- 
    Document   : cancel
    Created on : Apr 1, 2023, 9:10:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="text-center my-4">
    <div class="border border-dark">
        <h3 class="text-danger"><spring:message code="label.canceled"/></h3>
        <p><spring:message code="label.at"/> <fmt:formatDate value="${cancel.cancelDate}" pattern="dd-MM-yyyy hh:mm:ss" /></p>
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
                    <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}" class="btn border-dark p-2"><spring:message code="label.see.shop"/></a>
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
                                <span id="usdPrice" name="usdPrice">
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
                    <td><b><spring:message code="label.request.by"/></b></td>
                    <td>
                        <c:if test="${cancel.idAccount.role == 'ROLE_CUSTOMER'}">
                            <span><spring:message code="label.by.customer"/></span> 
                        </c:if>
                        <c:if test="${cancel.idAccount.role == 'ROLE_SELLER'}">
                            <span><spring:message code="label.role.seller"/></span> 
                        </c:if>
                        <c:if test="${cancel.idAccount.role == 'ROLE_ADMIN'}">
                            <span><spring:message code="label.by.admin"/></span> 
                        </c:if>
                    </td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.request.at"/></b></td>
                    <td> <fmt:formatDate value="${cancel.cancelDate}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.reason"/></b></td>
                    <td> <span>${cancel.cancelDescription}</span> </td>
                </tr>
                <tr class="text-right">
                    <td><b><spring:message code="label.payment.type"/></b></td>
                    <td> 
                        <c:if test="${order.paymentType == 1}">
                            <span><spring:message code="label.payment.home"/></span> 
                        </c:if>
                        <c:if test="${order.paymentType == 2}">
                            <span><spring:message code="label.payment.online"/></span> 
                        </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>