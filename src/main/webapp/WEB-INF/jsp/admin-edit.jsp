<%-- 
    Document   : admin-edit
    Created on : Oct 21, 2022, 2:40:01 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <h1 class="p-4 center text-uppercase">CHỈNH SỬA THÔNG TIN CÁ NHÂN</h1>
                <form:input hidden="true" path="id" value="${admin.id}"/>
                <div class="form-group">
                    <label>Họ và tên:</label>
                    <form:input autocomplete="off" type="text" class="form-control" path="name" required="required"/>
                </div>
                <div class="form-group">
                    <label for="inputEmail">Email</label>
                    <form:input type="text" autocomplete="off" class="form-control" id="inputEmail" path="email" required="required"/>
                </div> 
                <div class="form-group">
                    <label for="inputPhone">Số điện thoại</label>
                    <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone" required="required"/>
                </div>
                <div class="form-group">
                    <label for="gender">Giới tính:</label>
                    <form:select path="gender" >
                        <form:option value="Nam" label="Nam"/>
                        <form:option value="Nữ" label="Nữ"/>
                        <form:option value="Khác" label="Khác"/>
                    </form:select>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Xong</button>
                </div>
            </form:form>
        </div>
    </div>
</div>




