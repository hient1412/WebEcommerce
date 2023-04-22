<%-- 
    Document   : order-success
    Created on : Mar 20, 2023, 12:40:44 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="p-5 text-center">
    <div class="border border-success p-5 m-5">
    <div class="pt-4"><img src="<c:url value="/images/check.png"/>"/></div>

    <h2><spring:message code="label.order.success"/></h2>
    
    <p>* <spring:message code="label.ship.soon"/>. *</p>
    </div>
</div>
