<%-- 
    Document   : admin-account-add
    Created on : Oct 18, 2022, 5:42:30 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <form:form action="${action}" modelAttribute="ac" method="post">
            <h1 class="text-center">Thêm tài khoản</h1>
            <div class="form-group">
                <label>Tên đăng nhập</label>
                <form:input autocomplete="off" type="text" class="form-control" path="username" required="required"/>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <form:input autocomplete="off" type="password" class="form-control" path="password" required="required"/>
            </div>
            <div class="form-group">
                <label>Vai trò </label>
                <form:select path="role" >
                    <form:option value="ROLE_CUSTOMER" label="Khách hàng"/>
                    <form:option value="ROLE_SELLER" label="Người bán" />
                    <form:option value="ROLE_ADMIN" label="Admin"/>
                </form:select>
            </div>
            <div class="form-group">
                <label>Trạng thái</label>
                <form:select path="active" >
                    <form:option value="1" label="Đã được duyệt"/>
                    <form:option value="0" label="Chưa duyệt" />
                </form:select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Thêm tài khoản</button>
            </div>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
        </form:form>
    </div>
</div>