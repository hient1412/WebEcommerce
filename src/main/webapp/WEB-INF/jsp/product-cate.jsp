<%-- 
    Document   : product-cate
    Created on : Oct 18, 2022, 1:59:50 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="center">
        <div class="row">
            <div class="col-md-12"><h2>QUẢN LÝ LOẠI SẢN PHẨM</h2></div>
        </div>
    </div>
    <table class="table table-bordered center">
        <thead>
            <tr>
                <th>Mã loại</th>
                <th>Tên loại sản phẩm</th>
                <th>Mô tả</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${cate}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.name}</td>
                    <c:if test="${c.description != null && c.description != ''}">
                        <td>${c.description}</td>
                    </c:if>
                    <c:if test="${c.description == null ||  c.description == ''}">
                        <td>Chưa viết mô tả</td>
                    </c:if>
                    <td>
                        <a title="Sửa" href="<c:url value="/admin/product-cate/edit"/>?id=${c.id}"
                           data-toggle="tooltip"><i style="font-size: 22px" class="fa-regular fa-pen-to-square p-1"></i></a>
                        <a title="Xóa" href="<c:url value="/admin/product-cate/delete"/>?id=${c.id}"
                           data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-trash-can p-1"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="4">
                    <a class="nav-link" title="Thêm loại sản phẩm" href="<c:url value="/admin/product-cate/add"/>" data-toggle="tooltip">Thêm loại sản phẩm</a>
                </td>
            </tr>
        </tbody>
    </table>
    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>
    <ul class="pagination d-flex justify-content-center mt-4">
        <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
            <li class="page-item">
                <a class="page-link" href="<c:url value="/admin/product-cate"/>?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul>
</div>