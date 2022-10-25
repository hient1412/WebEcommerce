<%-- 
    Document   : change-password
    Created on : Oct 25, 2022, 1:50:19 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <form:form action="" method="post">
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="text-center">Đổi mật khẩu</h1>
            <div class="form-group">
                <label>Mật khẩu cũ</label>
                <input autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <label>Mật khẩu mới</label>
                <input autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <label>Xác nhận mật khẩu mới</label>
                <input autocomplete="off" type="password" class="form-control" required="required"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Sửa</button>
            </div>
        </form:form>
    </div>
</div>

