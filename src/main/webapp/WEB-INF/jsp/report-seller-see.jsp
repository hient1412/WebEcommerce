<%-- 
    Document   : report-seller-see
    Created on : Apr 23, 2023, 5:18:25 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="text-center my-4">
    <div class="border border-dark">
        <h3 class="text-danger"><spring:message code="label.report.seller.detail"/></h3>
    </div>
</div>
<div class="text-center my-4">
    <div class="border border-dark bg-light">
        <div class="p-3">
            <div class="d-flex">
                <div >
                    <div class="user-3 d-inline-block">
                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.id}"><img class="rounded-circle img-fluid" src="${seller.avatar}"></a>
                    </div>
                    <div class="d-inline" style="font-size: 24px;">
                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.id}"><label>${seller.name}</label></a>
                    </div>
                </div>
                <div class="ml-auto">
                    <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.id}" class="btn border-dark p-2"><spring:message code="label.see.shop"/></a>
                </div>
            </div>
        </div>
    </div>
    <div class="mb-3">
        <div class="border border-dark bg-light">
            <table class="table table-bordered center">
                <thead>
                    <tr>
                        <th><spring:message code="label.product.id"/></th>
                        <th><spring:message code="label.product.name"/></th>
                        <th><spring:message code="label.action"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${product}">
                        <tr>
                            <td>${r.id}</td>
                            <td>${r.name}</td>
                            <td>
                                <a title='<spring:message code="label.see"/>' href="<c:url value="/product-detail/"/>${r.id}"
                                   data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-eye p-1"></i></a>
                                <a title='<spring:message code="label.unban.seller"/>' href="<c:url value="/admin/report/unban"/>?id=${r.id}"
                                   data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-ban p-1"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <ul class="pagination d-flex justify-content-center mt-4">
                <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                    <c:if test="${(Math.ceil(counterS/count)) != 1}" >
                        <li class="page-item">
                            <a class="page-link" href="<c:url value="/admin/report/seller/see?id=${seller.id}"/>&page=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<div class="d-flex">
    <div class="py-4 pe-2">
        <a class="btn btn-dark" href="<c:url value="/admin/report/seller"/>"><i class="fa-solid fa-arrow-left"></i> <spring:message code="label.back"/></a>
    </div>
    <div class="py-4 pe-2">
        <a class="btn btn-danger" href="<c:url value="/admin/report/seller/ban"/>?id=${seller.id}"><spring:message code="label.ban.seller"/></a>
    </div>
</div>