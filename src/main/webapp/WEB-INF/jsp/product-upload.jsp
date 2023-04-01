<%-- 
    Document   : product-upload
    Created on : Sep 29, 2022, 3:32:32 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row container d-flex justify-content-center p-4">
    <div class="card">
        <div class="card-body">
            <h1 class="center">ĐĂNG SẢN PHẨM</h1>
            <form:form action="" method="post" modelAttribute="product" enctype="multipart/form-data">
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
                    <div class="col-6 col-lg-4">
                        <label>Số lượng</label>
                        <form:input type="number" value="1" path="quantity" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col-6 col-lg-4">
                        <label>Thương hiệu</label>
                        <form:input type="text" path="manufacturer" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col-12 col-lg-4">
                        <label>Loại sản phẩm</label>
                        <form:select class="form-control" path="idCategory">
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}"> ${c.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Hình ảnh</label>
                    <br>(Chỉ upload file hình ảnh)<span style="color: red">*</span><br>
                    <form:input type="file" accept="image/*, .jpg,.png" multiple="multiple" path="file" class="form-control" required="required"/>
                </div>
                <div>
                    <label>Mô tả chi tiết</label>
                    <form:textarea type="text" autocomplete="off" class="form-control input-lg" path="description" placeholder="Mô tả"/>
                </div>
                <br>
                <div>
                    <button type="submit" class="btn btn-primary btn-lg btn-block">Đăng</button>
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