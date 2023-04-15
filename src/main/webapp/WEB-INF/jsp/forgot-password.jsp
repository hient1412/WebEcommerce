<%-- 
    Document   : forgot-password
    Created on : Apr 4, 2023, 10:01:56 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <form action="" method="post">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <h1 class="text-center">Quên mật khẩu</h1>
            <label for="role"> Bạn là </label>
            <select name="role" >
                <option value="ROLE_CUSTOMER" label="Khách hàng"/>
                <option value="ROLE_SELLER" label="Người bán" />
            </select>
            <div class="form-group">
                <label>Nhập tài khoản mail</label>
                <input autocomplete="off" type="email" class="form-control" name="email" required="required"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Gửi</button>
            </div>
        </form>
    </div>
</div>
