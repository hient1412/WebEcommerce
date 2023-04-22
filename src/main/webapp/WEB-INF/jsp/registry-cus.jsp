<%-- 
    Document   : registry-cus
    Created on : Sep 28, 2022, 10:11:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:url var="link" value="/"/>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <c:choose>
        <c:when test="${action != null}">
            <c:url value="${action}" var="action"/>
        </c:when>
        <c:otherwise>
            <c:url value="/admin/account/add" var="action"/>
        </c:otherwise>
    </c:choose>

    <div class="login-form">
        <form:form action="${action}" method="post" modelAttribute="customer" enctype="multipart/form-data">
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
                        <h1 class="p-4 center text-uppercase"><spring:message code="label.add.information"/><br><spring:message code="label.role.customer"/></h1>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
                <form:input hidden="true" path="idAccount" value="${ac.id}"/>
            <div class="form-group row">
                <div class="col">
                    <label for="inputLastName"><spring:message code="label.lastname"/></label>
                    <form:input autocomplete="off" type="text" class="form-control" path="lastName" required="required"/>
                </div>
                <div class="col">
                    <label for="inputFirstName"><spring:message code="label.firstname"/></label>
                    <form:input autocomplete="off" type="text" class="form-control" path="firstName" required="required"/>
                </div>
            </div>
            <div class="form-group">
                <label for="dob"><spring:message code="label.dob"/></label>
                <form:input type="date" class="form-control" path="dob" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputEmail"><spring:message code="label.email"/></label>
                <form:input type="email" autocomplete="off" class="form-control" id="inputEmail" path="email" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputPhone"><spring:message code="label.phone"/></label>
                <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone" required="required"/>
            </div>
            <div class="form-group">
                <label for="avatar"><spring:message code="label.avatar"/></label>
                <form:input type="file" path="file" id="avatar" class="form-control"/>
            </div>
            <div class="form-group">
                <label for="description"><spring:message code="label.description"/></label>
                <form:textarea type="text" class="form-control" path="description"/>
            </div>
            <div class="form-group row">
                <div class="col">
                    <label for="gender"><spring:message code="label.gender"/>:</label>
                    <form:select path="gender" >
                        <form:option value="Nam"><spring:message code="label.male"/></form:option>
                        <form:option value="Nữ" ><spring:message code="label.female"/></form:option>
                    </form:select>
                </div>
                <div class="col">
                    <label for="location"><spring:message code="label.hometown"/></label>
                    <form:select path="location" >
                        <c:forEach items="${locations}" var="l">
                            <form:option value="${l.id}" label="${l.name}" />
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.done"/></button>
            </div>
        </form:form>
    </div>
</body>




