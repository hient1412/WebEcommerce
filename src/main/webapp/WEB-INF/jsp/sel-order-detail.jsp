<%--
    Document   : sel-order-detail
    Created on : Mar 26, 2023, 11:00:12 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:url value="/seller/order-detail/${order.id}/send" var="action"/>
<div class="container">
    <div class="center p-4">
        <h3 class="text-uppercase"><spring:message code="label.order.details"/></h3>
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
            <a href="<c:url value="/seller/cancel/${order.id}"/>"><spring:message code="label.order.cancel.detail"/></a>
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
                            <img class="rounded-circle img-fluid" src="${order.idCustomer.avatar}">
                        </div>
                        <div class="d-inline"  style="font-size: 24px;">
                            <b><label>${order.idCustomer.idAccount.username}</label></b>
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
<!--                    <test="${order.amount != 0}">
                        <tr class="text-right">
                            <td><b>Tổng giảm từ shop</b></td>
                            <td> <span>-</span> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                        </tr>-->
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
    <div class="border border-dark text-right bg-light mb-5">
        <div class="p-4">
            <h5><spring:message code="label.payment.type"/></h5>
            <c:if test="${order.paymentType == 1}">
                <h6 style="color: #267bd1"><spring:message code="label.payment.home"/></h6>
            </c:if>
            <c:if test="${order.paymentType == 2}">
                <h6 style="color: #267bd1"><spring:message code="label.payment.online"/></h6>
            </c:if>
        </div>
    </div>
</div>
<c:if test="${errMessage != null}">
    <div class="text-danger pt-4 text-center" style="font-size: 20px;">
        ${errMessage}
    </div>
</c:if>
<div class="d-flex">
    <div class="py-4 px-2">
        <a class="btn btn-dark" href="<c:url value="/seller/list-order"/>"><i class="fa-solid fa-arrow-left"></i> <spring:message code="label.back"/></a>
    </div>
    <c:if test="${order.active == 2 || order.active == 1}">
        <div class="py-4 px-2">
            <a class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#reasonCancel"><spring:message code="label.cancel.order"/></a>
        </div>
    </c:if>
    <c:if test="${order.active == 1}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/seller/order-detail/${order.id}/confirm"/>"><spring:message code="label.confirm.order"/></a>
        </div>
    </c:if>
    <c:if test="${order.active == 3}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/seller/order-detail/${order.id}/shipping"/>"><spring:message code="label.confirm.shipping"/></a>
        </div>
    </c:if>    
    <c:if test="${order.active == 2}">  <!-- chờ vận chuyển -->
        <div class="py-4 px-2">
            <a class="btn btn-success" data-bs-toggle="modal" data-bs-target="#setDaySend"><spring:message code="label.pick.day.send"/></a>
        </div>
    </c:if>
    <c:if test="${order.active == 4}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/seller/order-detail/${order.id}/confirm/order"/>"><spring:message code="label.order.finish"/></a>
        </div>
    </c:if>
</div>
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
                        <form:option value="Hết hàng" label="Hết hàng"/>
                        <form:option value="Người mua yêu cầu hủy" label="Người mua yêu cầu hủy"/>
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
<div class="modal fade" id="setDaySend" tabindex="-1" aria-labelledby="#setDaySend" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="exampleModalLabel"><spring:message code="label.pick.day.send"/></h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div  class="pt-2 pb-2"><h6 class="text-danger">* <spring:message code="label.warning.day.send"/> *</h6></div>
            <form action="${action}">
                <div class="form-group row">
                    <div class="form-group col-md-8">
                        <input type="date" id="daySend" class="form-control" name="daySend" required="required"/>
                    </div>
                    <div class="form-group col-md-4">
                        <button class="form-control btn btn-primary" type="submit"><spring:message code="label.done"/></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>     
<c:if test="${seller.idAccount.active == 0}">
    <a id="aclick" href="<c:url value="/access-denied"/>"></a>
</c:if>
<script>
    setTimeout(locate, 0)
    function locate() {
        document.getElementById("aclick").click();
    }
</script>
<script>
    document.getElementById('daySend').value = new Date().toISOString().substring(0, 10);

    $(function () {
        var dtToday = new Date();

        var month = dtToday.getMonth() + 1;
        var day = dtToday.getDate();
        var year = dtToday.getFullYear();
        if (month < 10)
            month = '0' + month.toString();
        if (day < 10)
            day = '0' + day.toString();

        var minDate = year + '-' + month + '-' + day;
        var maxDate = year + '-' + month + '-' + (day + 7);

        $('#daySend').attr('min', minDate);
        $('#daySend').attr('max', maxDate);
    });
</script>