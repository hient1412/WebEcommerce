<%-- 
    Document   : ship-address-edit
    Created on : Dec 9, 2022, 1:59:29 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <h1 class="text-center">Chỉnh sửa địa chỉ </h1>
        <form:form action="" modelAttribute="sa" method="post">
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <div class="form-group row">
                <div class="col">
                    <form:input  type="text" class="form-control" path="name" autocomplete="off" placeholder="Họ tên người nhận"/>
                </div>
                <div class="col">
                    <form:input type="text" class="form-control" path="phone" autocomplete="off" placeholder="Số điện thoại"/>
                </div>
            </div>
            <div class="form-group row">
                <div class="col">
                    <form:input type="text" class="form-control" path="ward" autocomplete="off" placeholder="Phường/Xã"/>
                </div>
                <div class="col">
                    <form:input type="text" class="form-control" path="district" autocomplete="off" placeholder="Quận/Huyện"/>
                </div>
                <div class="col">
                    <form:select path="city" class="form-control">
                        <c:forEach items="${locations}" var="l">
                            <option value="${l.id}"> ${l.name}</option>
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="form-group row">
                <div class="col">
                    <form:input type="text" class="form-control" path="address" autocomplete="off" placeholder="Địa chỉ cụ thể (Vd: 123/23/3 Phạm Thế Hiển)"/>         
                </div>
            </div>
            <div>
                <button type="submit" class="btn btn-primary btn-lg btn-block">Sửa</button>
            </div>
        </form:form>
    </div>
</div>