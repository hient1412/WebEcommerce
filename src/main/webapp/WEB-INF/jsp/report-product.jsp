<%--
    Document   : report-product
    Created on : Apr 22, 2023, 11:10:15 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="text-center my-4">
    <div class="border border-dark">
        <h3 class="text-danger"><spring:message code="label.report.detail"/></h3>
    </div>
</div>
<div class="text-center my-4">
    <div class="border border-dark bg-light">
        <div class="p-3">
            <div class="d-flex">
                <div >
                    <div class="user-3 d-inline-block">
                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${product.idSeller.id}"><img class="rounded-circle img-fluid" src="${product.idSeller.avatar}"></a>
                    </div>
                    <div class="d-inline" style="font-size: 24px;">
                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${product.idSeller.id}"><label>${product.idSeller.name}</label></a>
                    </div>
                </div>
                <div class="ml-auto">
                    <a href="http://localhost:8080/WebEcommerce/seller-detail/${product.idSeller.id}" class="btn border-dark p-2"><spring:message code="label.see.shop"/></a>
                </div>
            </div>
            <hr>
            <div class="row align-items-center justify-content-center">
                <div class="col-md-6 text-center">
                    <div >
                        <div class="mb-2">
                            <a href="<c:url value="/product-detail/${product.id}"/>"><img src="${img}"class="w-100"/></a>
                        </div>
                    </div>
                    <div class="mt-3">
                        <div class="mb-3">
                            <label>${product.name}</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mb-3">
        <div class="border border-dark bg-light">
            <table class="table table-bordered center">
                <thead>
                    <tr>
                        <th><spring:message code="label.report.id"/></th>
                        <th><spring:message code="label.at"/></th>
                        <th><spring:message code="label.description"/></th>
                        <th><spring:message code="label.request.by"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${report}">
                        <tr>
                            <td>${r.id}</td>
                            <td><fmt:formatDate value="${r.reportDate}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                            <td>${r.reportDescription}</td>
                            <td>${r.idCustomer.lastName}  ${r.idCustomer.firstName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <ul class="pagination d-flex justify-content-center mt-4">
                <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                    <li class="page-item">
                        <a class="page-link" href="<c:url value="/admin/report/see?id=${product.id}"/>&page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<div class="d-flex">
    <div class="py-4 pe-2">
        <a class="btn btn-dark" href="<c:url value="/admin/report"/>"><i class="fa-solid fa-arrow-left"></i> <spring:message code="label.back"/></a>
    </div>
    <div class="py-4 pe-2">
        <a class="btn btn-danger" href="<c:url value="/admin/report/ban"/>?id=${product.id}"><spring:message code="label.ban"/></a>
    </div>
    <div class="py-4 pe-2">
        <a class="btn btn-success" href="<c:url value="/admin/report/skip"/>?id=${product.id}"><spring:message code="label.skip"/></a>
    </div>
</div>