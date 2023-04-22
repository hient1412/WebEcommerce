<%-- 
    Document   : product-cate
    Created on : Oct 18, 2022, 1:59:50 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="center">
        <div class="row">
            <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.product.type.management"/></h2></div>
        </div>
    </div>
    <table class="table table-bordered center">
        <thead>
            <tr>
                <th><spring:message code="label.product.type.id"/></th>
                <th><spring:message code="label.product.type.name"/></th>
                <th><spring:message code="label.description"/></th>
                <th><spring:message code="label.action"/></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${cate}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.name}</td>
                    <c:if test="${c.description != null && c.description != ''}">
                        <td>${c.description}</td>
                    </c:if>
                    <c:if test="${c.description == null ||  c.description == ''}">
                        <td><spring:message code="label.not.write.description"/></td>
                    </c:if>
                    <td>
                        <a title='<spring:message code="label.edit"/>' href="<c:url value="/admin/product-cate/edit"/>?id=${c.id}"
                           data-toggle="tooltip"><i style="font-size: 22px" class="fa-regular fa-pen-to-square p-1"></i></a>
                        <a title='<spring:message code="label.delete"/>' href="<c:url value="/admin/product-cate/delete"/>?id=${c.id}"
                           data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-trash-can p-1"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="4">
                    <a class="nav-link" title='<spring:message code="label.add.product.type"/>' href="<c:url value="/admin/product-cate/add"/>" data-toggle="tooltip"><spring:message code="label.add.product.type"/></a>
                </td>
            </tr>
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
                <a class="page-link" href="<c:url value="/admin/product-cate"/>?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul>
</div>