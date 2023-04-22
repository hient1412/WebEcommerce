<%-- 
    Document   : change-password
    Created on : Oct 25, 2022, 1:50:19 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="white-box">
        <form:form action="" method="post" modelAttribute="ac">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="text-center"><spring:message code="label.change.password"/></h1>
            <div class="form-group">
                <label><spring:message code="label.old.password"/></label>
                <form:input path="passwordOld" autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <label><spring:message code="label.new.password"/></label>
                <form:input path="passwordNew" autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <label><spring:message code="label.confirm.new.password"/></label>
                <form:input path="confirmPassword" autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.change"/></button>
            </div>
        </form:form>
    </div>
</div>

