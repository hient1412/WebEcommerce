<%-- 
    Document   : login
    Created on : Sep 22, 2022, 1:31:11 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/login" var="action"/>
<c:url value="/registry" var="registry"/>
<body style="background-image: url('https://static.tapchitaichinh.vn/images/upload/hoangthuviet/09092021/e-commerce-770x385.jpg')">
    <div class="login-form">
        <form method="post" action="${action}">
            <h1 class="p-4 center">ĐĂNG NHẬP</h1>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-lg btn-primary btn-block">Facebook</a>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-lg btn-info btn-block">Google</a>
                </div>
            </div>
            <div class="m-3">
                <div class="form-group">
                    <label for="inputUsername">Tên đăng nhập</label>
                    <input type="text" autocomplete="off" class="form-control" id="inputUsername" name="username">
                </div>
                <div class="form-group">
                    <label for="inputPassword">Mật khẩu</label>
                    <input autocomplete="off" type="password" class="form-control" id="inputPassword" name="password">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"/> Nhớ mật khẩu
                    </label>
                </div>
                <input type="submit" class="btn btn-primary btn-lg btn-block login-btn" value="Đăng nhập"/>

        </form>
        <div class="text-center p-2">
            <p>Bạn chưa có tài khoản? <a href="${registry}">Đăng ký ngay</a></p>
            <a href="#">Quên mật khẩu</a>
        </div>
        <c:if test="${param.error != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                Tên đăng nhập hoặc mật khẩu KHÔNG chính xác!
            </div>
        </c:if>
        <c:if test="${param.accessDenied != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                Không có quyền truy cập!
            </div>
        </c:if>
    </div>
</body>
