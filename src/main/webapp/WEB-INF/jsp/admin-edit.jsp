<%-- 
    Document   : admin-edit
    Created on : Oct 21, 2022, 2:40:01 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:url value="/admin/edit" var="action"/>
<div class="row container d-flex justify-content-center p-4">
    <div class="card">
        <div class="card-body">
            <form:form action="${action}" method="post" modelAttribute="admin">
                <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
                <c:if test="${errMessage != null}">
                    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                        ${errMessage}
                    </div>
                </c:if>
                <h1 class="p-4 center text-uppercase"><spring:message code="label.edit.personal"/></h1>
                <form:input hidden="true" path="id" value="${admin.id}"/>
                <div class="form-group">
                    <label><spring:message code="label.fullname"/>:</label>
                    <form:input autocomplete="off" type="text" class="form-control" path="name" required="required"/>
                </div>
                <div class="form-group">
                    <label for="inputEmail"><spring:message code="label.email"/></label>
                    <form:input type="text" autocomplete="off" class="form-control" id="inputEmail" path="email" required="required"/>
                </div> 
                <div class="form-group">
                    <label for="inputPhone"><spring:message code="label.phone"/></label>
                    <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone" required="required"/>
                </div>
                <div class="form-group">
                    <label for="gender"><spring:message code="label.gender"/>:</label>
                    <form:select path="gender" >
                        <form:option value="Nam" ><spring:message code="label.male"/></form:option>
                        <form:option value="Nữ" label="Nữ"><spring:message code="label.female"/></form:option>
                    </form:select>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-block login-btn"><spring:message code="label.done"/></button>
                </div>
            </form:form>
        </div>
    </div>
</div>




