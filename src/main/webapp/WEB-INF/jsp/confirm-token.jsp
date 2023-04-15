<%--
    Document   : confirm-token
    Created on : Apr 4, 2023, 11:10:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <form action="" method="post" modelAttribute="s">
            <div class="pb-3 text-center">
                <h1>Nhập mã xác thực tại đây</h1>
                <h6><a href="<c:url value="/forgot-password"/>">Nhập lại email</a></h6>
            </div>
            <span class="text-center pt-3">Gửi lại mã</span>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <input autocomplete="off" type="text" class="form-control" name="sendtoken" required="required"/>
                </div>
                <div class="col-md-4 col-12">
                    <button type="submit"  class="form-control btn btn-primary btn-lg btn-block login-btn">Gửi</button>
                </div>
            </div>

        </form>
    </div>
</div>


