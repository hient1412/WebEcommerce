<%-- 
    Document   : customer-edit
    Created on : Oct 21, 2022, 4:07:32 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row container d-flex justify-content-center p-4">
    <div class="card">
        <div class="card-body">
            <form:form action="${action}" method="post" modelAttribute="customer" enctype="multipart/form-data">
                <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
                <c:if test="${errMessage != null}">
                    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                        ${errMessage}
                    </div>
                </c:if>
                <h1 class="p-4 center text-uppercase"><spring:message code="label.edit.personal"/></h1>
                <form:input hidden="true" path="id" value="${customer.id}"/>
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
                    <form:input type="date" class="form-control" path="dob"/>
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
                            <form:option value="Nam" label="Nam"/>
                            <form:option value="Nữ" label="Nữ"/>
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
    </div>
</div>