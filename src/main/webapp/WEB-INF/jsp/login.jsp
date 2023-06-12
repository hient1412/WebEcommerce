<%-- 
    Document   : login
    Created on : Sep 22, 2022, 1:31:11 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<c:url var="link" value="/"/>
<c:url value="/login" var="action"/>
<c:url value="/registry" var="registry"/>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <div class="login-form">
        <form method="post" action="${action}">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
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
            <h1 class="p-4 center"><spring:message code="label.sign.in"/></h1>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-lg btn-primary btn-block">Facebook</a>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-lg btn-info btn-block">Google</a>
                </div>
            </div>
            <div class="m-3">
                <div class="form-group">
                    <label for="inputUsername"><spring:message code="label.username"/></label>
                    <input type="text" autocomplete="off" class="form-control" id="inputUsername" name="username">
                </div>
                <div class="form-group">
                    <label for="inputPassword"><spring:message code="label.password"/></label>
                    <input autocomplete="off" type="password" class="form-control" id="inputPassword" name="password">
                </div>
                <!--                <div class="checkbox">
                                    <label>
                                        <input type="checkbox"/> Nhớ mật khẩu
                                    </label>
                                </div>-->
                <input type="submit" class="btn btn-primary btn-lg btn-block login-btn" value='<spring:message code="label.sign.in"/>'/>

        </form>
        <div class="text-center p-2">
            <p><spring:message code="label.not.account"/>? <a href="${registry}"><spring:message code="label.sign.up"/></a></p>
            <a href="<c:url value="/forgot-password"/>"><spring:message code="label.forgot.password"/></a>
        </div>
        <c:if test="${param.error != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                <spring:message code="label.not.correct"/>
            </div>
        </c:if>
        <c:if test="${param.accessDenied != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                <spring:message code="label.not.access"/>
            </div>
        </c:if>
    </div>
</body>