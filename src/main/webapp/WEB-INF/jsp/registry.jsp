<%-- 
    Document   : registry
    Created on : Sep 28, 2022, 4:00:16 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/login" var="login"/>
<c:url value="/registry" var="action"/>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <div class="login-form">
        <form:form method="post" action="${action}" modelAttribute="account">
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="p-4 center">ĐĂNG KÝ</h1>
            <div class="m-3">
                <div class="form-group">
                    <label for="inputUsername">Tên đăng nhập</label>
                    <form:input type="text" autocomplete="off" class="form-control" id="inputUsername" required="required" path="username"/>
                </div>
                <div class="form-group">
                    <label for="inputPassword">Mật khẩu</label>
                    <form:input autocomplete="off" type="password" class="form-control" id="inputPassword" required="required" path="password"/>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <form:input autocomplete="off" type="password" class="form-control" id="confirmPassword" required="required" path="confirmPassword"/>
                </div>
                <label for="role"> Bạn đăng kí với vai trò </label>
                <form:select path="role" >
                    <form:option value="ROLE_CUSTOMER" label="Khách hàng"/>
                    <form:option value="ROLE_SELLER" label="Người bán" />
                </form:select>
                <input type="submit" class="btn btn-primary btn-lg btn-block login-btn" value="Đăng ký"/>
            </form:form>
            <div class="text-center p-2">
                <p>Bạn đã có tài khoản? <a href="${login}">Đăng nhập ngay</a></p>
            </div>
            <c:if test="${param.error != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    Có lỗi xảy ra!!!
                </div>
            </c:if>
            <c:if test="${param.accessDenied != null}">
                <div class="alert alert-danger">
                    KHÔNG có quyền truy cập!
                </div>
            </c:if>
        </div>
    </div>
</body>


