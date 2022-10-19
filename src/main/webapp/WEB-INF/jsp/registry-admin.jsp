<%-- 
    Document   : registry-admin
    Created on : Oct 18, 2022, 10:11:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
<c:url value="/registry/admin" var="action"/>
    <div class="login-form">
        <form:form action="${action}" method="post" modelAttribute="admin">
            <h1 class="p-4 center text-uppercase">Thêm thông tin<br>admin</h1>
                <form:input hidden="true" path="idAccount" value="${ac.id}"/>
            <div class="form-group">
                    <label>Họ và tên:</label>
                    <form:input autocomplete="off" type="text" class="form-control" path="name" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputEmail">Email</label>
                <form:input type="text" autocomplete="off" class="form-control" id="inputEmail" path="email"/>
            </div>
            <div class="form-group">
                <label for="inputPhone">Số điện thoại</label>
                <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone"/>
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
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
        </form:form>
    </div>
</body>




