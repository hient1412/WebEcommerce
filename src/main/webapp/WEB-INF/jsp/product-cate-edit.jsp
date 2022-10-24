<%-- 
    Document   : product-cate-edit
    Created on : Oct 18, 2022, 2:26:26 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div  class="p-5">
    <div class="white-box">
        <div class="center">
            <div class="col-md-12">
                <h2>SỬA LOẠI SẢN PHẨM</h2>
            </div>
        </div>
        <form:form action="" method="post" modelAttribute="category">
            <form:errors path="*" element="div" cssClass="text-danger" cssStyle="text-align: center; font-size: 20px; padding: 10px;"/>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <div class="form-group">
                <label>Tên loại sản phẩm</label>
                <form:input type="text" path="name" class="form-control" autocomplete="off"/>
            </div>
            <div class="form-group">
                <label>Mô tả</label>
                <form:input type="text" path="description" class="form-control" autocomplete="off"/>
            </div>
            <div>
                <button type="submit" class="btn btn-primary btn-lg btn-block">Sửa</button>
            </div>
        </form:form>
    </div>
</div>
