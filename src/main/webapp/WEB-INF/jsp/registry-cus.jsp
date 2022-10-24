<%-- 
    Document   : registry-cus
    Created on : Sep 28, 2022, 10:11:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <c:choose>
        <c:when test="${action != null}">
            <c:url value="${action}" var="action"/>
        </c:when>
        <c:otherwise>
            <c:url value="/admin/account/add" var="action"/>
        </c:otherwise>
    </c:choose>

    <div class="login-form">
        <form:form action="${action}" method="post" modelAttribute="customer" enctype="multipart/form-data">
            <h1 class="p-4 center text-uppercase">Thêm thông tin<br>khách hàng</h1>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
                <form:input hidden="true" path="idAccount" value="${ac.id}"/>
            <div class="form-group row">
                <div class="col">
                    <label for="inputLastName">Họ</label>
                    <form:input autocomplete="off" type="text" class="form-control" path="lastName" required="required"/>
                </div>
                <div class="col">
                    <label for="inputFirstName">Tên</label>
                    <form:input autocomplete="off" type="text" class="form-control" path="firstName" required="required"/>
                </div>
            </div>
            <div class="form-group">
                <label for="dob">Ngày sinh</label>
                <form:input type="date" class="form-control" path="dob" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputEmail">Email</label>
                <form:input type="email" autocomplete="off" class="form-control" id="inputEmail" path="email" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputPhone">Số điện thoại</label>
                <form:input type="number" autocomplete="off" class="form-control" id="inputPhone" path="phone" required="required"/>
            </div>
            <div class="form-group">
                <label for="avatar">Avatar</label>
                <form:input type="file" path="file" id="avatar" class="form-control"/>
            </div>
            <div class="form-group">
                <label for="description">Mô tả bản thân</label>
                <form:textarea type="text" class="form-control" path="description"/>
            </div>
            <div class="form-group row">
                <div class="col">
                    <label for="gender">Giới tính của bạn:</label>
                    <form:select path="gender" >
                        <form:option value="Nam" label="Nam"/>
                        <form:option value="Nữ" label="Nữ"/>
                        <form:option value="Khác" label="Khác"/>
                    </form:select>
                </div>
                <div class="col">
                    <label for="location">Quê quán</label>
                    <form:select path="location" >
                        <c:forEach items="${locations}" var="l">
                            <form:option value="${l.id}" label="${l.name}" />
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Xong</button>
            </div>
        </form:form>
    </div>
</body>




