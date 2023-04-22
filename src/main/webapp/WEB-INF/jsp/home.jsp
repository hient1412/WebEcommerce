<%-- 
    Document   : home
    Created on : Sep 21, 2022, 5:15:28 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="product-list">
    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>
    <c:choose>
        <c:when test="${product.size() != 0}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
                <c:forEach items="${product}" var="p">
                    <div class="col">
                        <div class="white-box mt-3">
                            <div class="product-img">
                                <img src="${p.imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p.name}</div>
                                <div class="price">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                </div>
                                <a class="blue-btn" href="<c:url value="/product-detail/${p.id}"/>"><spring:message code="label.product.see.detail"/></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="row">
                <div class="pagination justify-content-center mt-4">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                            <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div> 
            <c:if test="${cateId == null}">
                <c:if test="${buyALot.size() != 0}">
                    <div class="row">
                        <h1 class="center text-uppercase"><spring:message code="label.product.favorite"/></h1>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
                        <c:forEach items="${buyALot}" var="p">
                            <div class="col">
                                <div class="white-box mt-3">
                                    <div class="product-img">
                                        <img src="${p[3].imageCollection.get(0).image}">
                                    </div>
                                    <div class="product-bottom">
                                        <div class="product-name">${p[1]}</div>
                                        <div class="price">
                                            <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p[2]}" maxFractionDigits="3" type="number"/>
                                        </div>
                                        <a class="blue-btn"" href="<c:url value="/product-detail/${p[0]}"/>"><spring:message code="label.product.see.detail"/></a>
                                        <div class="pt-4"><span class="text-danger"><spring:message code="label.number.sale"/>: ${p[4]}</span></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </c:if>          
        </c:when>
        <c:when test="${product.size() == 0}">
            <h3 class="center">
                <i><spring:message code="label.not.product.cate"/></i>
            </h3>
        </c:when>
    </c:choose>
</div>
