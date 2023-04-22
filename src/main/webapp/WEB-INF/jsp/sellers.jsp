<%-- 
    Document   : sellers
    Created on : Oct 7, 2022, 4:10:08 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div>
        <h1 class="center p-4 text-uppercase"><spring:message code="label.search"/></h1>
    </div>
    <div>
        <form action="" >
            <div class="center">
                <label><spring:message code="label.shop.name"/></label>
                <input type="text" name="kw" autocomplete="off"/>
                <input type="submit" class="mt-4 p-1" value="<spring:message code="label.search"/>"/>
                <input type="button" class="p-1" onclick="clearFilter()" value="<spring:message code="label.clear"/>"/>
            </div>
        </form>
    </div>
</div>


<c:if test="${!kw.isEmpty()}">
    <div class="row">
        <div class="title-center">
            <h1><spring:message code="label.result"/></h1>
            <span style="color: blue">"${kw}"</span>
        </div>
    </div>
</c:if>
<c:if test="${counterS != 0 && !kw.isEmpty()}">
    <div>
        <div style="text-align: center">
            <span><spring:message code="label.there.are"/> <span style="color: red">${counterS}</span> <spring:message code="label.results"/></span>
        </div>
    </div>
</c:if>
<c:choose>
    <c:when test="${sellers.size() != 0}">
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <div class="row justify-content-center">
            <div class="product-list">
                <div class="row m-1">
                    <c:forEach items="${sellers}" var="s">
                        <div class="white-box-2 mt-2">
                            <div class="row p-2 align-items-center">
                                <div class="col-md-1 p-0 m-0 col-sm-3 col-3">
                                    <a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>"><img class="product-img-2 img-fluid rounded-circle" src="${s[2]}"/></a>
                                </div>
                                <div class="col-md-3 ps-5 col-sm-3 col-3">
                                    <div class="row">
                                        <div>
                                            <b><a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>">${s[1]}</a></b>
                                            <br>
                                            <c:if test="${sellerRating.avgRating(productService.getRatingSeller(s[0])) != 0}">
                                                <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${sellerRating.avgRating(productService.getRatingSeller(s[0]))}/5</span> <br>
                                            </c:if>
                                            <c:if test="${sellerRating.avgRating(productService.getRatingSeller(s[0])) == 0}">
                                                <span><i>(<spring:message code="label.not.rating"/>)</i></span> <br>
                                            </c:if>
                                        </div>
                                        <a class="btn btn-info" href="/WebEcommerce/seller-detail/${s[0]}"><spring:message code="label.see.shop"/></a>
                                    </div>
                                </div>
                                <div class="col-md-8 col-sm-6 col-6">
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-6 center" >
                                            <h4><i class="fa-solid fa-location-dot"></i> ${s[3]}</h4>
                                            <span><spring:message code="label.address"/></span>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-6 center">
                                            <h4><i class="fa-solid fa-box"></i> ${s[4]}</h4>
                                            <span><spring:message code="label.product"/></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
                <c:when test="${sellers.size() == 0}">
                    <h3 class="center p-3">
                        <i class="text-danger"><spring:message code="label.no.result"/></i>
                    </h3>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>