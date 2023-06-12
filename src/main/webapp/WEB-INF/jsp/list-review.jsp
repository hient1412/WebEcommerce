<%-- 
    Document   : list-review
    Created on : May 20, 2023, 10:21:06 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:if test="${errMessage != noReview}">
    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>
</c:if>

<spring:message code="label.not.rating" var="noReview"/>

<h1 class="center p-4 text-uppercase"><spring:message code="label.review"/></h1>
<c:if test="${sellerRating != 0}">
    <div class="p-4 border border-dark" style="background-color: #ccc">
        <div class="row justify-content-lg-around align-items-center">
            <div class="col-md-4 text-center">
                <c:if test="${sellerRating != 0}">
                    <span style="font-size: 40px"><label style="color: yellow; font-size: 40px">&#9733;</label> ${sellerRating}</span> <br>
                </c:if>
                <c:if test="${sellerRating == 0}">
                    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                        (${noReview})
                    </div>
                </c:if>
            </div>
            <div class="col-md-6 text-center">
                <form action="">
                    <div class="radio-toolbar" >
                        <input onclick="this.form.submit()" type="radio" id="all" name="rating" value="">
                        <label for="all"><spring:message code="label.all"/>(${generalRatingAll[0]})</label>

                        <input onclick="this.form.submit()" type="radio" id="one" name="rating" value="1">
                        <label for="one"><spring:message code="label.rating.one"/>(${generalRating1[0]})</label>

                        <input onclick="this.form.submit()" type="radio" id="two" name="rating" value="2">
                        <label for="two"><spring:message code="label.rating.two"/>(${generalRating2[0]})</label>

                        <input onclick="this.form.submit()" type="radio" id="three" name="rating" value="3">
                        <label for="three"><spring:message code="label.rating.three"/>(${generalRating3[0]})</label>

                        <input onclick="this.form.submit()" type="radio" id="four" name="rating" value="4">
                        <label for="four"><spring:message code="label.rating.four"/>(${generalRating4[0]})</label>

                        <input onclick="this.form.submit()" type="radio" id="five" name="rating" value="5">
                        <label for="five"><spring:message code="label.rating.five"/>(${generalRating5[0]})</label>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div>
        <c:choose>
            <c:when test="${listReview.size() != 0}">
                <div class="product-list">
                    <div class="row">
                        <div class="white-box bg-light p-1 center media-white-none">
                            <div class="row">
                                <div class="col-md-6">
                                    <label><spring:message code="label.product"/></label>
                                </div>
                                <div class="col-md-6 center">
                                    <label><spring:message code="label.review"/></label>
                                </div>
                            </div>
                        </div>
                        <c:forEach items="${listReview}" var="l">
                            <div class="white-box-2 mt-2">
                                <div class=" d-inline">
                                    <spring:message code="label.by.customer" />: <img class="rounded-circle img-fluid user-2" src="${l.idAccount.customer.avatar}">
                                </div>
                                <div class="d-inline">
                                    <label> ${l.idAccount.username}</label>
                                </div>
                                <div class="row align-items-start">
                                    <div class="col-2 col-md-1">
                                        <div class="product-img-3">
                                            <div class="mb-2">
                                                <a href="<c:url value="/product-detail/${l.idProduct.id}"/>"><img src="${l.idProduct.imageCollection.get(0).image}"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4 col-md-5">
                                        <div>
                                            <label>${l.idProduct.name}</label>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-6 text-center">
                                        <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${l.rating}</span>
                                        <h6><i>" ${l.content} "</i></h6>
                                        <h6><fmt:formatDate pattern="HH:mm dd/MM/yyyy" value="${l.reviewDate}"/></h6>
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
            <c:when test="${listReview.size() == 0}">
                <h3 class="center p-3">
                    <i class="text-danger"><spring:message code="label.not.rating"/></i>
                </h3>
            </c:when>
        </c:choose>
    </div>
</c:if>
<c:if test="${sellerRating == 0}">
    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
        ${noReview}
    </div>
</c:if>
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