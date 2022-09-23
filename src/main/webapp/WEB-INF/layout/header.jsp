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
                        <li class="nav-item active"><a class="nav-link a-login" href="<c:url value="/login"/>">Đăng nhập</a></li>
                        <li class="nav-item active"><a class="nav-link a-login" href="#">Đăng ký</a></li>
                        </c:when>
                        <c:when test="${pageContext.request.userPrincipal.name != null}">
                        <li class="nav-item active"><a class="nav-link a-login" href="#">${pageContext.request.userPrincipal.name}</a></li>
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
                    <a class="navbar-brand" style="font-size: 30px; color: white;" href="<c:url value="/" />">&copy; WebEcommerce &copy;</a>
                </div>
                <div class="col-md-5">
                    <form action="<c:url value="/search" />">
                        <input class="flipkart-navbar-input col-md-10" autocomplete="off" name="kw" type="text" placeholder="Tìm sản phẩm hoặc cửa hàng phù hợp">
                        <button class="flipkart-navbar-button col-md-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </form>
                </div>
                <div class="col-sm-1">
                    <a class="cart-button">
                        <i class="fa fa-shopping-cart i-cart" aria-hidden="true"></i>
                        <span class="item-number ">0</span>
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