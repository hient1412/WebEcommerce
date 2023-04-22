<%-- 
    Document   : admin-account-add
    Created on : Oct 18, 2022, 5:42:30 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="white-box">
        <form:form action="${action}" modelAttribute="ac" method="post">
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="text-center"><spring:message code="label.add.account" /></h1>
            <div class="form-group">
                <label><spring:message code="label.username" /></label>
                <form:input autocomplete="off" type="text" class="form-control" path="username" required="required"/>
            </div>
            <div class="form-group">
                <label><spring:message code="label.password" /></label>
                <form:input autocomplete="off" type="password" class="form-control" path="password" required="required"/>
            </div>
            <div class="form-group">
                <label><spring:message code="label.role" /></label>
                <form:select path="role" >
                    <form:option value="ROLE_CUSTOMER"><spring:message code="label.role.customer"/></form:option>
                    <form:option value="ROLE_SELLER"><spring:message code="label.role.seller"/></form:option>
                    <form:option value="ROLE_ADMIN"><spring:message code="label.role.admin"/></form:option>
                </form:select>
            </div>
            <div class="form-group">
                <label><spring:message code="label.active" /></label>
                <form:select path="active" >
                    <form:option value="1" label="${labelApproved}"><spring:message code="label.approved"/></form:option>
                    <form:option value="0" label="${labelNotApproved}"><spring:message code="label.not.approved"/></form:option>
                </form:select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.add.account" /></button>
            </div>
        </form:form>
    </div>
</div>