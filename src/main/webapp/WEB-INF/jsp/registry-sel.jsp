<%--
    Document   : registry-sel
    Created on : Sep 29, 2022, 12:33:18 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <c:url value="/registry/sel" var="action"/>
    <div class="login-form">
        <form:form action="${action}" method="post" modelAttribute="seller" enctype="multipart/form-data">
            <h1 class="p-4 center text-uppercase">Thêm thông tin<br>người bán</h1>
                <form:input hidden="true" path="idAccount" value="${ac.id}"/>
            <div class="form-group">
                <label for="inputName">Tên cửa hàng</label>
                <form:input autocomplete="off" type="text" class="form-control" path="name" required="required"/>
            </div>
            <div class="form-group">
                <label for="inputAddress">Địa chỉ</label>
                <form:input autocomplete="off" type="text" class="form-control" path="address" required="required"/>
            </div>
            <label for="location">Nơi bán</label>
            <form:select path="idLocation" >
                <c:forEach items="${locations}" var="l">
                    <form:option value="${l.id}" label="${l.name}" />
                </c:forEach>
            </form:select>
            <div class="form-group">
                <label for="avatar">Avatar</label>
                <form:input type="file" path="file" id="avatar" class="form-control"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Xong</button>
            </div>
        </form:form>
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
    </div>
</body>
