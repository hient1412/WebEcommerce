<%--
    Document   : seller-detail
    Created on : Oct 5, 2022, 5:12:55 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:if test="${general[2] != 0}">
    <div>
        <div class="p-4 mt-4 bg-light">
            <div class="row justify-content-center center">
                <div class="col-12 col-lg-2 my-2">
                    <div class="product-img-2">
                        <img class="rounded-circle img-fluid" src="${general[1]}">
                    </div>
                </div>
                <div class="col-12 col-lg-2 my-2">
                    <h4>${general[0]}</h4>
                    <c:if test="${sellerRating != 0}">
                        <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${sellerRating}/5</span> <br>
                    </c:if>
                    <c:if test="${sellerRating == 0}">
                        <span><i>(<spring:message code="label.not.rating"/>)</i></span> <br>
                    </c:if>
                    <a href="#" class="btn btn-dark"><spring:message code="label.chat"/></a>
                </div>
                <div class="col-12 col-lg-4 my-2">
                    <h4 class="text-uppercase"><spring:message code="label.description"/></h4>
                    <span class="center">${seller.description}</span>
                </div>
                <div class="col-12 col-lg-4 my-2">
                    <h4 class="text-uppercase"><spring:message code="label.product"/>: <span class="text-danger">${general[2]}</span> </h4>
                </div>
            </div>
        </div>
        <div class="product-list">
            <div class="row">
                <c:if test="${productBySeller.size() != 0}">
                    <h2 class="center pb-4 pt-4"><spring:message code="label.all.product"/></h2>
                    <div class="row">
                        <form action="">
                            <div class="mt-4">
                                <label for="cateId"><spring:message code="label.product.type"/>: </label>
                                <input type="radio" id="cateId" name="cateId" value="" ondblclick="this.form.submit()" checked>
                                <label><spring:message code="label.all"/></label>
                                <c:forEach items="${cateBySeller}" var="c">
                                    <input type="radio" id="cateId" name="cateId" ondblclick="this.form.submit()" onclick="paginationClick('sort', $('radio-toolbar').on(submit), function {
                                        $('input').val()}
                                        })" value="${c.id}">
                                    <label>${c.name}</label>
                                </c:forEach>
                            </div>
                            <div class="radio-toolbar" >
                                <span><spring:message code="label.sort.by"/>: </span>

                                <input onclick="this.form.submit()" type="radio" id="desc" name="sort" value="desc">
                                <label for="desc"><spring:message code="label.latest"/></label>

                                <input onclick="this.form.submit()" type="radio" id="asc" name="sort" value="asc">
                                <label for="asc"><spring:message code="label.oldest"/></label>

                                <input onclick="this.form.submit()" type="radio" id="pin" name="sort" value="pin">
                                <label for="pin"><spring:message code="label.ascending.price"/></label>

                                <input onclick="this.form.submit()" type="radio" id="pde" name="sort" value="pde">
                                <label for="pde"><spring:message code="label.descending.price"/></label>
                            </div>
                        </form>
                        <c:forEach items="${productBySeller}" var="p">
                            <div class="col-md-4 col-sm-6 col-lg-3">
                                <div class="white-box mt-3">
                                    <div class="product-img">
                                        <img src="${p.imageCollection.get(0).image}">
                                    </div>
                                    <div class="product-bottom">
                                        <div class="product-name">${p.name}</div>
                                        <div class="price">
                                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                <span id="vndPrice" name="vndPrice">
                                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                                <span id="usdPrice" name="usdPrice" >
                                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(p.price)}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                        </div>
                                        <a class="blue-btn"" href="<c:url value="/product-detail/${p.id}"/>"><spring:message code="label.product.see.detail"/></a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <br>
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
                </div>
            </div>
            <c:if test="${productBySeller.size() == 0}">
                <div class="row">
                    <h3 class="center">
                        <i><spring:message code="label.no.product"/></i>
                    </h3>
                </div>
            </c:if>
        </div>
    </div>
</c:if>
<c:if test="${general[2] == 0}">
    <c:if test="${sellerAuthentication.id == seller.id}">
        <h3 class="py-5 text-uppercase text-center text-danger"><spring:message code="label.post.first"/>!!!!</h3>
    </c:if>
    <c:if test="${sellerAuthentication.id != seller.id}">
        <h3 class="py-5 text-uppercase text-center text-danger"><spring:message code="label.seller.no.open"/>!!!!</h3>
    </c:if>
</c:if>
