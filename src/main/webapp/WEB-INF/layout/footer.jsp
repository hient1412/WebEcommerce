<%-- 
    Document   : footer
    Created on : Sep 21, 2022, 5:14:31 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="container-fluid padding">
    <div id="footer" class="row text-center">
        <div class="col-md-4">
            <p><h5><spring:message code="label.contact"/></h5></p>
            <p><i class="fa fa-phone" aria-hidden="true"></i> <spring:message code="label.hcm"/>: (+84) 385 620 489</p>
            <p><i class="fa fa-phone" aria-hidden="true"></i> <spring:message code="label.hn"/>: (+84) 024 650 449</p>
        </div>
        <div class="col-md-4">
            <p><h5><spring:message code="label.connect"/></h5></p>
            <a href="#"><img class="social" src="<c:url value="/images/fb.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/ins.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/twitter.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/youtube.png"/>"/></a>
        </div>
        <div class="col-md-4">
            <p><h5><spring:message code="label.location"/></h5></p>
            <p><i class="fa-solid fa-location-dot"></i> <spring:message code="label.location.one"/></p>
            <p><i class="fa-solid fa-location-dot"></i> <spring:message code="label.location.two"/></p>
        </div>
    </div>
    <div id="sign" class="row text-center">
        <div class="col-12">
            <p>
            <h5>&copy; WebEcommerce &copy;</h5>
            <h7><i class="fa fa-envelope-o" aria-hidden="true"></i> ecommerce@gmail.com</h7>
            </p>
        </div>
    </div>
</div>