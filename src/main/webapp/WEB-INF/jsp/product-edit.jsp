<%-- 
    Document   : product-edit
    Created on : Sep 30, 2022, 12:04:15 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/seller/product-edit" var="action"/>
<div class="row container d-flex justify-content-center">
    <div class="card">
        <div class="card-body">
            <h1 class="center">CHỈNH SỬA SẢN PHẨM</h1>
            <form:form action="${action}" method="post" modelAttribute="product" accept-charset="utf-8" enctype="multipart/form-data">
                <form:input hidden="true" path="id" value="${product.id}"/>
                <div class="form-group row">
                    <div class="col">
                        <label>Tên sản phẩm</label>
                        <form:input type="text" path="name" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col">
                        <label>Giá tiền</label>
                        <form:input type="number" path="price" class="form-control" autocomplete="off"/>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <label>Số lượng</label>
                        <form:input type="number" path="quantity" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col">
                        <label>Thương hiệu</label>
                        <form:input type="text" path="manufacturer" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col">
                        <label>Loại sản phẩm</label>
                        <form:select class="form-control" path="idCategory">
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}"> ${c.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="image">Hình ảnh</label>
                    <c:if test="${product.imageCollection.size() != 0}">
                        <br>Đã từng upload ảnh trước đây:<br>
                    </c:if>
                    <c:forEach items="${product.imageCollection}" var="p">
                        <c:if test="${p.image.startsWith('http')}">
                            <span><a target="_blank" href="${p.image}">Xem lại</a></span><br>
                        </c:if>
                    </c:forEach>
                    <br>(Chỉ upload file hình ảnh)<span style="color: red">*</span>
                    <form:input type="file" accept="image/*, .jpg,.png" multiple="multiple" path="file" id="image" class="form-control"/>
                </div>
                <div class="form-group">
                    <form:textarea type="text" autocomplete="off" class="form-control input-lg" path="description" placeholder="Mô tả"/>
                </div>
                <br>
                <div>
                    <button type="submit" class="btn btn-primary btn-lg btn-block">Sửa</button>
                </div>
            </form:form>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
        </div>
    </div>
</div>