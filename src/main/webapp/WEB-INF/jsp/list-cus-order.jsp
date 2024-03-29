<%-- 
    Document   : list-cus-order
    Created on : Oct 19, 2022, 3:13:41 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:if test="${errMessage != 'Không có đơn hàng'}">
    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>
</c:if>
<spring:message code="label.no.order" var="noOrder"/>
<h1 class="center p-4 text-uppercase"><spring:message code="label.search"/></h1>
<div class="p-4" style="background-color: #ccc">
    <form action="" >
        <div class="row row-cols-1 row-cols-md-2 row-cols-sm-2">
            <div class="col">
                <label><spring:message code="label.order.id"/></label>
                <input type="number" name="idOrder" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label><spring:message code="label.product.name"/></label>
                <input type="text" name="namePro" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label><spring:message code="label.seller.name"/></label>
                <input type="text" name="nameSel" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label  for="active"><spring:message code="label.active"/></label>
                <select class="form-control" id="active"name="active">
                    <option value="" selected><spring:message code="label.all"/></option>
                    <option value="1"><spring:message code="label.order.status.one"/></option>
                    <option value="2"><spring:message code="label.order.status.two"/></option>
                    <option value="3"><spring:message code="label.order.status.three"/></option>
                    <option value="4"><spring:message code="label.order.status.four"/></option>
                    <option value="5"><spring:message code="label.order.status.five"/></option>
                    <option value="0"><spring:message code="label.order.status.six"/></option>
                </select>
            </div>
        </div>
        <div class="center">
            <input type="submit" class="mt-4 p-1" value='<spring:message code="label.search"/>'/>
            <input type="button" class="p-1" onclick="clearFilter()" value='<spring:message code="label.clear"/>'/>
        </div>
    </form>
</div>
<c:choose>
    <c:when test="${orders.size() != 0}">
        <c:if test="${errMessage == 'Không có đơn hàng'}">
            <h3 class="center p-3">
                <i class="text-danger">${noOrder}</i>
            </h3>
        </c:if>
        <c:if test="${errMessage != 'Không có đơn hàng'}">
            <div class="product-list">
                <div class="row">
                    <div class="white-box bg-light p-1 center media-white-none">
                        <div class="row">
                            <div class="col-md-4">
                                <label><spring:message code="label.product"/></label>
                            </div>
                            <div class="col-md-2 center">
                                <label><spring:message code="label.quantity"/></label>
                            </div>
                            <div class="col-md-2 text-end">
                                <label><spring:message code="label.total.amount"/></label>
                            </div>
                            <div class="col-md-2 text-end">
                                <label><spring:message code="label.active"/></label>
                            </div>
                            <div class="col-md-2 center">
                                <label></label>
                            </div>
                        </div>
                    </div>
                    <c:forEach items="${orders}" var="o">
                        <div class="white-box-2 mt-2">
                            <div class="row d-flex">
                                <div class="col-6 col-lg-8">
                                    <div class="user-2 d-inline-block">
                                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(o.id)[2]}"><img class="rounded-circle img-fluid" src="${seller.getSeller(o.id)[1]}"></a>
                                    </div>
                                    <div class="d-inline">
                                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(o.id)[2]}"><label>${seller.getSeller(o.id)[0]}</label></a> <i class="fa fa-comments" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4" style="text-align: right">
                                    <label><spring:message code="label.order.id"/>: ${o.id}</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 col-lg-6">
                                    <div class="row">
                                        <c:forEach items="${orderDetail.getOrderDetail(o.id)}" var="od">
                                            <div class="col-4 col-md-2">
                                                <div class="product-img-3">
                                                    <a href="<c:url value="/product-detail/${od.idProduct.id}"/>">
                                                        <div>
                                                            <img src="${od.idProduct.imageCollection.get(0).image}">
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-4 col-md-6">
                                                <a href="<c:url value="/product-detail/${od.idProduct.id}"/>">
                                                    <div>
                                                        <label style="color: black; cursor: pointer">${od.idProduct.name}</label>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="col-4 col-md-4 center">
                                                <div>
                                                    <label>x ${od.quantity}</label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-6">
                                    <div class="row">
                                        <div class="col-12 col-lg-4 text-end">
                                            <div>
                                                <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                    <span id="vndPrice" name="vndPrice">
                                                        <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${o.amount}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                                <c:if test="${pageContext.response.locale.language == 'en'}">
                                                    <span id="usdPrice" name="usdPrice" >
                                                        <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(o.amount)}" maxFractionDigits="3" type="number"/>
                                                    </span>
                                                </c:if>
                                                <br>
                                                <c:if test="${o.paymentType == 1}">
                                                    <span style="font-size: 10px;color: #ccc"><spring:message code="label.payment.home"/></span>
                                                </c:if>
                                                <c:if test="${o.paymentType == 2}">
                                                    <span style="font-size: 10px;color: #ccc"><spring:message code="label.payment.online"/></span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-4 text-end  media-active">
                                            <div>
                                                <c:if test="${o.active == 1}">
                                                    <label><spring:message code="label.order.status.one"/></label>
                                                </c:if>
                                                <c:if test="${o.active == 2}">
                                                    <label><spring:message code="label.order.status.two"/></label>
                                                </c:if>
                                                <c:if test="${o.active == 3}">
                                                    <label><spring:message code="label.order.status.three"/></label>
                                                </c:if>
                                                <c:if test="${o.active == 4}">
                                                    <label><spring:message code="label.order.status.four"/></label>
                                                </c:if>
                                                <c:if test="${o.active == 5}">
                                                    <label><spring:message code="label.order.status.five"/></label>
                                                </c:if>
                                                <c:if test="${o.active == 0}">
                                                    <label><spring:message code="label.order.status.six"/></label>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-4 text-end">
                                            <a href="<c:url value="/customer/order-detail/${o.id}"/>"><spring:message code="label.product.see.detail"/></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-md-12">
                <div class="pagination justify-content-center mt-4">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                            <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div>
        </c:if>
    </c:when>
    <c:when test="${orders.size() == 0}">
        <h3 class="center p-3">
            <i class="text-danger">${noOrder}</i>
        </h3>
    </c:when>
</c:choose>
<script>
    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "") {
                    $(obj).removeAttr("name");
                }
            });
        });
    });
</script>
