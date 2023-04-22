<%-- 
    Document   : change-password
    Created on : Oct 25, 2022, 1:50:19 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="white-box">
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <h1 class="text-center text-uppercase"><spring:message code="label.address.list"/></h1>
        <c:if test="${listShip == 0}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                <spring:message code="label.no.address"/>!!
            </div>
        </c:if>
        <c:if test="${listShip != 0}">
        <c:url value="/api/customer/${customerId}/address" var="endpoint"/>

        <div id="ship">

        </div>
        </c:if>
        <div class="form-group center mt-4">
            <a class="btn btn-link" href="<c:url value="/customer/ship-address-add"/>"><p><i class="fa-regular fa-square-plus"></i> <spring:message code="label.add.other.address"/></p></a>
        </div>
    </div>
</div>
<script>
    window.onload = function () {
        loadShipAddress('${endpoint}');
    };
</script>