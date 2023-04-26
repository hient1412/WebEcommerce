<%-- 
    Document   : admin-account
    Created on : Oct 17, 2022, 3:47:18 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="center">
        <div class="row">
            <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.account.management"/></h2></div>
        </div>
    </div>
    <c:if test="${listTK.size() != 0}">
        <div  style="overflow-x:auto;"> 
            <table class="table table-bordered center">
                <thead>
                    <tr>
                        <th><spring:message code="label.account.id"/></th>
                        <th><spring:message code="label.username"/></th>
                        <th><spring:message code="label.account.type"/></th>
                        <th><spring:message code="label.active"/></th>
                        <th><spring:message code="label.action"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="ac">
                        <tr>
                            <td>${ac.id}</td>
                            <td>${ac.username}</td>
                            <td>${ac.role}</td>
                            <c:if test="${ac.active == 1}">
                                <td><spring:message code="label.approved"/></td>
                            </c:if>
                            <c:if test="${ac.active == 0}">
                                <td><spring:message code="label.not.approved"/></td>
                            </c:if>
                            <td>
                                <a title="<spring:message code="label.see"/>" href="<c:url value="/admin/account/see"/>?id=${ac.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-eye p-1"></i></a>
                                <a title="<spring:message code="label.edit"/>" href="<c:url value="/admin/account/edit"/>?id=${ac.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-regular fa-pen-to-square p-1"></i></a>
                                <a title="<spring:message code="label.delete"/>" href="<c:url value="/admin/account/delete"/>?id=${ac.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-trash-can p-1"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                <td colspan="5">
                    <a class="nav-link" title="<spring:message code="label.add.account"/>" href="<c:url value="/admin/account/add"/>" data-toggle="tooltip"><spring:message code="label.add.account"/></a>
                </td>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${list.size() == 0}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            <spring:message code="label.not.account"/>
        </div>
    </c:if>

    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>

    <ul class="pagination d-flex justify-content-center mt-4">
        <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
            <li class="page-item">
                <a class="page-link" href="<c:url value="/admin/account"/>?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul>
</div>