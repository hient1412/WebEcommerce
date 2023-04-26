<%-- 
    Document   : report
    Created on : Apr 22, 2023, 10:31:08 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${counterS == 0}">
    <div class="p-4">
        <div class="center p-4 border border-dark">
            <h2 class="text-uppercase"><spring:message code="label.confirm.success.report"/></h2>
        </div>
    </div>
</c:if>
<c:if test="${counterS > 0}">
    <div class="p-1 my-5">
        <div class="center">
            <div class="row">
                <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.report.management"/></h2></div>
            </div>
        </div>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th><spring:message code="label.product"/></th>
                    <th><spring:message code="label.action"/></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${report}">
                    <tr>
                        <td>${r.idProduct.name}</td>
                        <td>
                            <a title='<spring:message code="label.see"/>' href="<c:url value="/admin/report/see"/>?id=${r.idProduct.id}"
                               data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-eye p-1"></i></a>
                            <a title='<spring:message code="label.ban"/>' href="<c:url value="/admin/report/ban"/>?id=${r.idProduct.id}"
                               data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-ban p-1"></i></a>
                            <a title='<spring:message code="label.skip"/>' href="<c:url value="/admin/report/skip"/>?id=${r.idProduct.id}"
                               data-toggle="tooltip"><i style="font-size: 22px" class="fas fa-times p-1"></i></a>

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
                    <a class="page-link" href="<c:url value="/admin/report"/>?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:if>