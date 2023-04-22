<%-- 
    Document   : registry
    Created on : Sep 28, 2022, 4:00:16 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:url value="/login" var="login"/>
<c:url value="/registry" var="action"/>
<c:url var="link" value="/"/>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <div class="login-form">
        <form:form method="post" action="${action}" modelAttribute="account">
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
                                    <i class="fa-solid fa-check" style="color: green;margin-left: 50px" ></i>
                                </c:if>
                            </div>
                        </a>
                        <a class="dropdown-item px-2" style="width: 100px;" onclick="changeLang(${link}, 'en')">
                            <div class="d-flex">
                                <span>EN</span>
                                <c:if test="${pageContext.response.locale.language == 'en'}">
                                    <i class="fa-solid fa-check" style="color: green;margin-left: 50px;"></i>
                                </c:if>
                            </div>
                        </a>
                    </div>
                </li>
            </ul>
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="p-4 center text-uppercase"><spring:message code="label.sign.up"/></h1>
            <div class="m-3">
                <div class="form-group">
                    <label for="inputUsername"><spring:message code="label.username"/></label>
                    <form:input type="text" autocomplete="off" class="form-control" id="inputUsername" required="required" path="username"/>
                </div>
                <div class="form-group">
                    <label for="inputPassword"><spring:message code="label.password"/></label>
                    <form:input autocomplete="off" type="password" class="form-control" id="inputPassword" required="required" path="password"/>
                </div>
                <div class="form-group">
                    <label for="confirmPassword"><spring:message code="label.confirm.password"/></label>
                    <form:input autocomplete="off" type="password" class="form-control" id="confirmPassword" required="required" path="confirmPassword"/>
                </div>
                <label for="role"> <spring:message code="label.role"/></label>
                <form:select path="role" >
                    <form:option value="ROLE_CUSTOMER" ><spring:message code="label.role.customer"/></form:option>
                    <form:option value="ROLE_SELLER" ><spring:message code="label.role.seller"/></form:option>
                </form:select>
                <input type="submit" class="btn btn-primary btn-lg btn-block login-btn" value="<spring:message code="label.sign.up"/>"/>
            </form:form>
            <div class="text-center p-2">
                <p><spring:message code="label.have.account"/>? <a href="${login}"><spring:message code="label.sign.in"/></a></p>
            </div>
            <c:if test="${param.error != null}">
                <div class="text-danger text-uppercase" style="text-align: center; font-size: 20px; padding: 10px;">
                    <spring:message code="label.error"/>!!!
                </div>
            </c:if>
            <c:if test="${param.accessDenied != null}">
                <div class="alert alert-danger text-uppercase">
                    <spring:message code="label.not.access"/>!
                </div>
            </c:if>
        </div>
    </div>
</body>


