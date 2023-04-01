<%-- 
    Document   : header2
    Created on : Oct 4, 2022, 10:53:07 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav>
    <div id="flipkart-navbar">
        <div class="container">
            <div class="row row2">
                <div class="col-12 col-md-5 col-lg-3">
                    <a class="navbar-brand" style="font-size: 25px; color: white;" href="<c:url value="/" />">&copy; WebEcommerce &copy;</a>
                </div>
                <div class="col-8 col-md-6 col-lg-6">
                    <form action="<c:url value="/search" />" class="d-flex">
                        <input class="flipkart-navbar-input w-100" id="kw" autocomplete="off" name="kw"type="text" placeholder="Tìm sản phẩm phù hợp">
                        <button class="flipkart-navbar-button"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </form>
                </div>
                <c:if test="${pageContext.request.userPrincipal.name == null}">
                    <div class="col-4 col-md-1 col-lg-1">
                        <a class="cart-button" href="<c:url value="/cart"/>">
                            <i class="fa fa-shopping-cart i-cart" aria-hidden="true"></i>
                            <div class="badge badge-danger" id="cartCounter">${cartCounter}</div>
                        </a>
                    </div>
                </c:if>
                <c:if test="${pageContext.session.getAttribute('current').role == ('ROLE_CUSTOMER')}">
                    <div class="col-1">
                        <a class="cart-button" href="<c:url value="/cart"/>">
                            <i class="fa fa-shopping-cart i-cart" aria-hidden="true"></i>
                            <div class="badge badge-danger" id="cartCounter">${cartCounter}</div>
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</nav>
<nav class="navbar navbar-expand-lg navbar-dark nav-reponse">
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
