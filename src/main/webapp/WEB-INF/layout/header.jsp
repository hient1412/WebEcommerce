<%--
    Document   : header
    Created on : Sep 21, 2022, 5:14:07 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top"  style="background-color: #1a1919;">
    <div class="container">
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ">
                <li class="nav-item active"><a href="#" class="nav-link" >Công ty</a></li>
                <li class="nav-item active"><a href="#" class="nav-link" >Ứng viên</a></li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal.name == null}">
                        <li class="nav-item active"><a class="nav-link a-login" href="<c:url value="/login"/>">Đăng nhập/Đăng ký</a></li>
                        </c:when>
                        <c:when test="${pageContext.request.userPrincipal.name != null}">
                        <li class="dropdown nav-item active">
                            <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_SELLER')}">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle user-action nav-link"><img src="${pageContext.session.getAttribute('currentSeller').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                                <ul class="dropdown-menu">
                                    <li><a href="<c:url value="/personal-info"/>"><i class="fa fa-user-o"></i>Thông tin cá nhân</a></li>                            
                                    <li><a href="<c:url value="/company/edit"/>"><i class="fa fa-pencil-square-o"></i>Cập nhật thông tin</a></li>
                                        <c:if test="${pageContext.session.getAttribute('current').active == 1}">
                                        <li><a href="<c:url value="/seller/view"/>"><i class="fa fa-briefcase"></i>Quản lý</a></li>
                                        </c:if>
                                        <c:if test="${pageContext.session.getAttribute('current').active == 0}">
                                        <li style="margin-left: 15px; color: red"><i class="fa fa-briefcase"></i>(Chưa kích hoạt)</li>
                                        </c:if>
                                    <li><a href="<c:url value="/logout"/>"><i class="material-icons">&#xE8AC;</i>Đăng xuất</a></li>
                                </ul>
                            </c:if>
                            <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_CUSTOMER')}">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle user-action nav-link"><img src="${pageContext.session.getAttribute('currentCustomer').getAvatar()}">${pageContext.request.userPrincipal.name}</a>
                                <ul class="dropdown-menu">
                                    <li><a href="<c:url value="/personal-info"/>"><i class="fa fa-user-o"></i>Thông tin cá nhân</a></li>
                                    <li><a href="<c:url value="/candidate/edit"/>"><i class="fa fa-pencil-square-o"></i>Cập nhật thông tin</a></li>
                                    <li><a href="<c:url value="/candidate/list-apply"/>?id=${pageContext.session.getAttribute('current').ungVien.maUV}"><i class="fa fa-briefcase"></i>Ds đã ứng tuyển</a></li>
                                    <li><a href="<c:url value="/logout"/>"><i class="material-icons">&#xE8AC;</i>Đăng xuất</a></li>
                                </ul>

                            </c:if>
                            <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_ADMIN')}">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle user-action nav-link"><span>${pageContext.request.userPrincipal.name}</span>(${pageContext.session.getAttribute('current').role})</a>
                                <ul class="dropdown-menu">
                                    <li><a href="<c:url value="/personal-info"/>"><i class="fa fa-user-o"></i>Thông tin cá nhân</a></li>
                                    <li><a href="<c:url value="/admin/edit"/>"><i class="fa fa-pencil-square-o"></i>Cập nhật thông tin</a></li>
                                    <li><a href="<c:url value="/admin/view"/>"><i class="fa fa-briefcase"></i>Quản lý</a></li>
                                    <li><a href="<c:url value="/logout"/>"><i class="material-icons">&#xE8AC;</i>Đăng xuất</a></li>
                                </ul>

                            </c:if>
                        </li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<nav>
    <div id="flipkart-navbar">
        <div class="container">
            <div class="row row2">
                <div class="col-md-3">
                    <a class="navbar-brand" style="font-size: 25px; color: white;" href="<c:url value="/" />">&copy; WebEcommerce &copy;</a>
                </div>
                <div class="col-md-7">
                    <form action="<c:url value="/search" />">
                        <input class="flipkart-navbar-input col-md-10" id="kw" autocomplete="off" name="kw"type="text" placeholder="Tìm sản phẩm phù hợp">
                        <button class="flipkart-navbar-button col-md-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </form>
                </div>
                <div class="col-sm-1">
                    <a class="cart-button" href="<c:url value="/cart"/>">
                        <i class="fa fa-shopping-cart i-cart" aria-hidden="true"></i>
                        <div class="badge badge-danger" id="cartCounter">${cartCounter}</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="collapse navbar-collapse">
        <div class="container">
            <ul class="navbar-nav">
                <c:forEach items="${categories}" var="i">
                    <li class="nav-item active">
                        <c:url value="/" var="cate">
                            <c:param name="cateId" value="${i.id}"></c:param>
                        </c:url>
                        <a href="${cate}" class="nav-link a-login" >${i.name}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>