<%--
    Document   : header
    Created on : Sep 21, 2022, 5:14:07 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top"  style="background-color: #1a1919;">
    <div class="container">
        <ul class="navbar-nav">
            <li class="nav-item active"><a href="<c:url value="/sellers"/>" class="nav-link" >Cửa hàng</a></li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <c:choose>
                <c:when test="${pageContext.request.userPrincipal.name == null}">
                    <li class="nav-item active"><a class="nav-link a-login" href="<c:url value="/login"/>">Đăng nhập/Đăng ký</a></li>
                    </c:when>
                    <c:when test="${pageContext.request.userPrincipal.name != null}">
                    <li class="dropdown nav-item active">
                        <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_SELLER')}">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle nav-link"><img src="${pageContext.session.getAttribute('currentSeller').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                            <ul class="dropdown-menu">
                                <c:if test="${pageContext.session.getAttribute('current').active == 1}">
                                    <li><a href="<c:url value="/seller/dashboard"/>"><i class="fa fa-briefcase"></i> Quản lý công việc</a></li>
                                    <li><a href="<c:url value="/seller-detail/${pageContext.session.getAttribute('currentSeller').id}"/>"><i class="fa-solid fa-store"></i> Hồ sơ cửa hàng</a></li>
                                    <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> Thông tin cá nhân</a></li>
                                    <li><a href="<c:url value="/admin/edit"/>"><i class="fa-solid fa-pen-to-square"></i> Cập nhật thông tin</a></li>
                                    </c:if>
                                    <c:if test="${pageContext.session.getAttribute('current').active == 0}">
                                    <li style="margin-left: 15px; color: red"><i class="fa fa-briefcase"></i>(Chưa kích hoạt)</li>
                                    </c:if>
                                <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
                            </ul>
                        </c:if>
                        <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_CUSTOMER')}">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle nav-link"><img src="${pageContext.session.getAttribute('currentCustomer').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> Thông tin cá nhân</a></li>
                                <li><a href="<c:url value="/candidate/edit"/>"><i class="fa-solid fa-pen-to-square"></i> Cập nhật thông tin</a></li>
                                <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
                            </ul>
                        </c:if>
                        <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_ADMIN')}">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle user-action nav-link"><span>${pageContext.request.userPrincipal.name}</span>(${pageContext.session.getAttribute('current').role})</a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/personal"/>"><i class="fa-solid fa-user"></i> Thông tin cá nhân</a></li>
                                <li><a href="<c:url value="/admin/edit"/>"><i class="fa-solid fa-pen-to-square"></i> Cập nhật thông tin</a></li>
                                <li><a href="<c:url value="/admin/dashboard"/>"><i class="fa fa-briefcase"></i> Quản lý</a></li>
                                <li><a href="<c:url value="/logout"/>"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
                            </ul>
                        </c:if>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>
</nav>
