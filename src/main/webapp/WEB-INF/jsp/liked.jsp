<%-- 
    Document   : liked
    Created on : Apr 23, 2023, 10:06:02 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="border border-dark mt-4">
    <h1 class="center p-4 text-uppercase"><spring:message code="label.list.like"/></h1>
</div>
<div>
    <c:choose>
        <c:when test="${listLike.size() != 0}">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <div class="product-list">
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
                    <c:forEach items="${listLike}" var="p">
                        <div class="col">
                            <div class="white-box-3 mt-3">
                                <div class="text-right mb-3">
                                    <a class="fas fa-heart" style="font-size: 24px; color: red" href="<c:url value="/customer/liked/unlike"/>?id=${p.idProduct.id}"></a>
                                </div>
                                <div class="product-img">
                                    <img src="${p.idProduct.imageCollection.get(0).image}">
                                </div>
                                <div class="product-bottom">
                                    <div class="product-name">${p.idProduct.name}</div>
                                    <div><h6><spring:message code="label.product.type"/>: ${p.idProduct.idCategory.name}</h6></div>
                                    <div class="price">
                                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                                            <span id="vndPrice" name="vndPrice">
                                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p.idProduct.price}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${pageContext.response.locale.language == 'en'}">
                                            <span id="usdPrice" name="usdPrice" >
                                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(p.idProduct.price)}" maxFractionDigits="3" type="number"/>
                                            </span>
                                        </c:if>
                                    </div>
                                    <a class="blue-btn"" href="<c:url value="/product-detail/${p.idProduct.id}"/>"><spring:message code="label.product.see.detail"/></a>
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
        </c:when>
        <c:when test="${listLike.size() == 0}">
            <h3 class="center p-4 m-5">
                <i class="text-danger"><spring:message code="label.no.product.like"/></i>
            </h3>
        </c:when>
    </c:choose>
</div>
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