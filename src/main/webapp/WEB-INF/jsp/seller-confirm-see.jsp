<%-- 
    Document   : seller-confirm-see
    Created on : Apr 23, 2023, 2:06:23 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="container">
    <div class="row my-5 align-items-center">
        <div class="col-lg-5 mb-5 mb-lg-0 bg-light">
            <div class="ml-3 p-3" style="font-size: 20px">
                <div class="mt-4 text-primary">
                    <h4>${sel.name}</h4>
                </div>
                <div>
                    <p><h5><spring:message code="label.address"/>:</h5> ${sel.address}</p>
                </div>
                <div>
                    <p><h5><spring:message code="label.location"/>:</h5>${sel.idLocation.name}</p>
                </div>
                <div>
                    <c:if test="${!sel.email.isEmpty() == true}">
                        <p><h5><spring:message code="label.email"/></h5> ${sel.email} </p>
                    </c:if>
                </div>
                <div>
                    <c:if test="${!sel.phone.isEmpty() == true}">
                        <p><h5><spring:message code="label.phone"/></h5> ${sel.phone} </p>
                    </c:if>
                </div>
                <div>
                    <c:if test="${!sel.description.isEmpty() == true}">
                        <p><h5><spring:message code="label.description"/></h5> ${sel.description} </p>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <img class="img-fluid w-100" src="${sel.avatar}" />
        </div>
    </div>
</div>
<c:if test="${errMessage != null}">
    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
        <p>${errMessage}</p>
    </div>
</c:if>