<%--
    Document   : search
    Created on : Sep 24, 2022, 1:10:51 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row bg-light">
    <div class="col-md-3 p-4 center">
        <h4 class="center text-uppercase"><i class="fa fa-filter" aria-hidden="true"></i> <spring:message code="label.advanced.search"/></h4>
        <form action="" class="">
            <div class="left">
                <br>
                <b><spring:message code="label.price.from"/></b> <input style="width: 100%"type="number" name="fp" /><br>
                <b><spring:message code="label.to"/></b> <input style="width: 100%" type="number" name="tp"/>
                <input hidden="true" name="kw" value="${kw}" />
                <div class="mt-4">
                    <label for="sort"> <spring:message code="label.sort.by"/></label>
                    <select id="sort"name="sort">
                        <option value="" selected><spring:message code="label.no.selected"/></option>
                        <option value="desc"><spring:message code="label.latest"/></option>
                        <option value="asc" ><spring:message code="label.oldest"/></option>
                        <option value="az" ><spring:message code="label.az"/></option>
                        <option value="za" ><spring:message code="label.za"/></option>
                        <option value="pin" ><spring:message code="label.ascending.price"/></option>
                        <option value="pde" ><spring:message code="label.descending.price"/></option>
                    </select>
                </div>
                <div class="mt-4">
                    <label for="cat"><spring:message code="label.product.type"/></label>
                    <select id="cat"name="cat">
                        <option value="" selected><spring:message code="label.no.selected"/></option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mt-4">
                    <label for="location"><spring:message code="label.location"/></label>
                    <select id="location"name="location">
                        <option value="" selected><spring:message code="label.no.selected"/></option>
                        <c:forEach items="${locations}" var="l">
                            <option value="${l.id}">${l.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <input type="submit" class="mt-4 p-1" value="<spring:message code="label.done"/>"/>
            <input type="button" class="p-1" onclick="clearFilter()" value="<spring:message code="label.clear"/>"/>
        </form>
    </div>
    <div class="col-md-9">
        <div class="row">
            <c:if test="${!kw.isEmpty()}">
                <div class="title-center">
                    <h1><spring:message code="label.result"/></h1>
                    <span style="color: blue">"${kw}"</span>
                </div>
            </c:if>
        </div>
        <div>
            <c:if test="${!kw.isEmpty()}">
                <c:if test="${productCounterS == 0 && sellerCounterS == 0}">
                    <div class="row">
                        <div style="text-align: center">
                            <i><spring:message code="label.no.result"/></i>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sellers.size() != 0}">
                    <c:if test="${sellerCounterS != 0 && !kw.isEmpty()}">
                        <b><spring:message code="label.in.shop"/></b> 
                        <div>
                            <span><spring:message code="label.there.are"/> <span style="color: red">${sellerCounterS}</span> <spring:message code="label.results"/></span>
                        </div>
                    </c:if>
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
                                            <div class="col-md-2 ps-5 col-sm-3 col-3">
                                                <div class="row">
                                                    <div>
                                                        <b><a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>">${s[1]}</a></b>
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
                                                    <div class="col-md-6 col-sm-6 col-6 center" >
                                                        <h4><i class="fa-solid fa-box"></i> ${s[4]}</h4>
                                                        <span><spring:message code="label.product"/></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>  
                    </c:if>
                </c:if>
            </div>
            <c:if test="${productCounterS != 0 && !kw.isEmpty()}">
                <div class="row">
                    <br>
                    <b><spring:message code="label.in.products"/></b>
                    <div>
                        <span><spring:message code="label.there.are"/> <span style="color: red">${productCounterS}</span> <spring:message code="label.results"/></span>
                    </div>
                </div>
            </c:if>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
                <c:forEach items="${listProduct}" var="p">
                    <div class="col p-1">
                        <div class="white-box">
                            <div class="product-img">
                                <img src="${p.imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p.name}</div>
                                <div class="price">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                </div>
                                <a class="blue-btn"" href="<c:url value="/product-detail/${p.id}"/>"><spring:message code="label.product.see.detail"/></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div>
    <div class="pagination justify-content-center mt-4">
        <ul class="pagination">
            <c:forEach begin="1" end="${Math.ceil(productCounterS/count)}" var="i">
                <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                </c:forEach>
        </ul>
    </div>
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