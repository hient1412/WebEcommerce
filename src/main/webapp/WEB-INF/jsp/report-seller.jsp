<%-- 
    Document   : report-seller
    Created on : Apr 23, 2023, 2:42:56 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${counterS == 0}">
    <div class="p-4">
        <div class="center p-4 border border-dark">
            <h2 class="text-uppercase"><spring:message code="label.confirm.success.report.seller"/></h2>
        </div>
    </div>
</c:if>
<c:if test="${counterS > 0}">
    <div class="p-1 my-5">
        <div class="center">
            <div class="row">
                <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.report.seller.management"/></h2></div>
            </div>
        </div>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th><spring:message code="label.shop.name"/></th>
                    <th><spring:message code="label.product"/></th>
                    <th><spring:message code="label.action"/></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${report}">
                    <tr>
                        <td>${r[1]}</td>
                        <td>${r[2]}</td>
                        <td>
                            <a title='<spring:message code="label.see"/>' href="<c:url value="/admin/report/seller/see"/>?id=${r[0]}"
                               data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-eye p-1"></i></a>
                            <a title='<spring:message code="label.ban.seller"/>' href="<c:url value="/admin/report/seller/ban"/>?id=${r[0]}"
                               data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-ban p-1"></i></a>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <ul class="pagination d-flex justify-content-center mt-4">
            <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                <li class="page-item">
                    <a class="page-link" href="<c:url value="/admin/report/seller"/>?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:if>