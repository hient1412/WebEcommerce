<%-- 
    Document   : forgot-password
    Created on : Apr 4, 2023, 10:01:56 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="white-box">
        <form action="" method="post">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="text-center"><spring:message code="label.forgot.password"/></h1>
            <label for="role"><spring:message code="label.role"/> </label>
            <select name="role" >
                <option value="ROLE_CUSTOMER"><spring:message code="label.role.customer"/></option>
                <option value="ROLE_SELLER"><spring:message code="label.role.seller"/></option>
            </select>
            <div class="form-group">
                <label><spring:message code="label.enter.email"/></label>
                <input autocomplete="off" type="email" class="form-control" name="email" required="required"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.done"/></button>
            </div>
        </form>
    </div>
</div>
