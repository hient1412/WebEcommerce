<%--
    Document   : header
    Created on : Sep 21, 2022, 5:14:07 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:url var="link" value="/"/>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top"  style="background-color: #1a1919;">
    <div class="container">
        <ul class="navbar-nav">
            <li class="nav-item active"><a href="<c:url value="/sellers"/>" class="nav-link" ><spring:message code="label.sel"/></a></li>
        </ul>
        <ul class="navbar-nav ml-auto align-items-center">
            <li class="dropdown nav-item active">
                <div data-toggle="dropdown" class="dropdown-toggle nav-link">
                    <c:if test="${pageContext.response.locale.language == 'vi'}">
                        <span>VI</span>
                    </c:if>
                    <c:if test="${pageContext.response.locale.language == 'en'}">
                        <span>EN</span>
                    </c:if>
                </div>
                <div class="dropdown-menu" style="width: fit-content;min-width: unset;padding: 0;">
                    <a class="dropdown-item px-2" style="width: 100px;" onclick="changeLang(${link}, 'vi')">
                        <div class="d-flex align-items-center">
                            <span>VI</span>
                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                <i class="fa-solid fa-check" style="color: green;margin-left: 30px" ></i>
                            </c:if>
                        </div>
                    </a>
                    <a class="dropdown-item px-2" style="width: 100px;" onclick="changeLang(${link}, 'en')">
                        <div class="d-flex">
                            <span>EN</span>
                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                <i class="fa-solid fa-check" style="color: green;margin-left: 30px;"></i>
                            </c:if>
                        </div>
                    </a>
                </div>
            </li>
            <c:choose>
                <c:when test="${pageContext.request.userPrincipal.name == null}">
                    <li class="nav-item active"><a class="nav-link a-login" href="<c:url value="/login"/>"><spring:message code="label.in.up"/></a></li>
                    </c:when>
                    <c:when test="${pageContext.request.userPrincipal.name != null}">
                    <li class="dropdown nav-item active">
                        <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_SELLER')}">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle nav-link"><img src="${pageContext.session.getAttribute('currentSeller').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                            <ul class="dropdown-menu">
                                <c:if test="${pageContext.session.getAttribute('current').active == 1}">
                                    <li><a href="<c:url value="/seller/dashboard"/>"><i class="fa fa-briefcase"></i> <spring:message code="label.job.management"/></a></li>
                                    <li><a href="<c:url value="/seller-detail/${pageContext.session.getAttribute('currentSeller').id}"/>"><i class="fa-solid fa-store"></i> <spring:message code="label.my.shop"/></a></li>
                                    </c:if>
                                    <c:if test="${pageContext.session.getAttribute('current').active == 0}">
                                    <li style="margin-left: 15px; color: red"><i class="fa fa-briefcase"></i> <spring:message code="label.not.active"/></li>
                                    </c:if>
                                <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> <spring:message code="label.personal"/></a></li>
                                <li><a href="<c:url value="/seller/edit"/>"><i class="fa-solid fa-pen-to-square"></i> <spring:message code="label.update.personal"/></a></li>
                                <li><a href="<c:url value="/change-password"/>"><i class="fa-solid fa-key"></i> <spring:message code="label.change.pass"/></a></li>
                                <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> <spring:message code="label.logout"/></a></li>
                            </ul>
                        </c:if>
                        <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_CUSTOMER')}">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle nav-link"><img src="${pageContext.session.getAttribute('currentCustomer').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> <spring:message code="label.personal"/></a></li>
                                <li><a href="<c:url value="/customer/edit"/>"><i class="fa-solid fa-pen-to-square"></i> <spring:message code="label.update.personal"/></a></li>
                                <li><a href="<c:url value="/customer/list-cus-order"/>"><i class="fa-regular fa-file"></i>  <spring:message code="label.order"/></a></li>
                                <li><a href="<c:url value="/customer/liked"/>"><i class="far fa-heart"></i> <spring:message code="label.liked"/></a></li></a></li>
                                <li><a href="<c:url value="/customer/ship-address"/>"><i class="fa-solid fa-location-arrow"></i> <spring:message code="label.address"/></a></li></a></li>
                        <li><a href="<c:url value="/change-password"/>"><i class="fa-solid fa-key"></i> <spring:message code="label.change.pass"/></a></li></a></li>
                        <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> <spring:message code="label.logout"/></a></li></a></li>
                    </ul>
                </c:if>
                <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_ADMIN')}">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle user-action nav-link"><span>${pageContext.request.userPrincipal.name}</span>(${pageContext.session.getAttribute('current').role})</a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/admin/dashboard"/>"><i class="fa fa-briefcase"></i> <spring:message code="label.job.management"/></a></li>
                        <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> <spring:message code="label.personal"/></a></li>
                        <li><a href="<c:url value="/admin/edit"/>"><i class="fa-solid fa-pen-to-square"></i> <spring:message code="label.update.personal"/></a></li>
                        <li><a href="<c:url value="/change-password"/>"><i class="fa-solid fa-key"></i> <spring:message code="label.change.pass"/></a></li>
                        <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> <spring:message code="label.logout"/></a></li>
                    </ul>
                </c:if>
                </li>
            </c:when>
        </c:choose>
        </ul>
    </div>
</nav>
