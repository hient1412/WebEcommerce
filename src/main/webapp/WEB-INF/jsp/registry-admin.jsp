<%-- 
    Document   : registry-admin
    Created on : Oct 18, 2022, 10:11:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <c:url value="/registry/admin" var="action"/>
    <c:url var="link" value="/"/>
    <div class="login-form">
        <form:form action="${action}" method="post" modelAttribute="admin">
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
            <h1 class="p-4 center text-uppercase"><spring:message code="label.add.information"/><br><spring:message code="label.role.admin"/></h1>
                <form:input hidden="true" path="idAccount" value="${ac.id}"/>
                <form:input hidden="true" path="id" value="${id}"/>
            <div class="form-group">
                <label><spring:message code="label.fullname"/>:</label>
                <form:input autocomplete="off" type="text" class="form-control" path="name" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputEmail"><spring:message code="label.email"/></label>
                <form:input type="text" autocomplete="off" class="form-control" id="inputEmail" path="email"/>
            </div>
            <div class="form-group">
                <label for="inputPhone"><spring:message code="label.phone"/></label>
                <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone"/>
            </div>
            <div class="form-group">
                <label for="gender"><spring:message code="label.gender"/>:</label>
                <form:select path="gender" >
                    <form:option value="Nam" ><spring:message code="label.male"/></form:option>
                    <form:option value="Nữ" ><spring:message code="label.female"/></form:option>
                </form:select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.done"/></button>
            </div>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
        </form:form>
    </div>
</body>




