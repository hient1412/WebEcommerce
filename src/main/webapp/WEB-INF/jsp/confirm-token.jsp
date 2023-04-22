<%--
    Document   : confirm-token
    Created on : Apr 4, 2023, 11:10:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="p-5">
    <div class="white-box">
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <form action="" method="post" modelAttribute="s">
            <div class="pb-3 text-center">
                <h1><spring:message code="label.verify.code"/></h1>
                <h6><a href="<c:url value="/forgot-password"/>"><spring:message code="label.email.again"/></a></h6>
            </div>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <input autocomplete="off" type="text" class="form-control" name="sendtoken" required="required"/>
                </div>
                <div class="col-md-4 col-12">
                    <button type="submit"  class="form-control btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.done"/></button>
                </div>
            </div>
        </form>
    </div>
</div>


