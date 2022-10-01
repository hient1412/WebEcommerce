<%-- 
    Document   : seller-confirm
    Created on : Sep 29, 2022, 1:49:56 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${listAc.size() > 0}">
        <div class="center">
            <div class="row">
                <div class="col-md-12"><h2>Xác nhận người bán</h2></div>
            </div>
        </div>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th>Mã tài khoản</th>
                    <th>Tên đăng nhập</th>
                    <th>Loại tài khoản</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ac" items="${listAc}">
                    <tr>
                        <td>${ac.id}</td>
                        <td>${ac.username}</td>
                        <td>${ac.role}</td>
                        <td>
                            <a title="Xác nhận" href="<c:url value="/admin/seller-confirm/1"/>?id=${ac.id}"
                               data-toggle="tooltip"><i style="font-size:24px" class="fa">&#xf00c;</i></a>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4">
                        <a class="nav-link" title="Xác nhận tất cả" href="<c:url value="/admin/seller-confirm/all"/>"data-toggle="tooltip">Xác nhận tất cả</a>
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
            <c:forEach begin="1" end="${Math.ceil(size/count)}" var="i">
                <li class="page-item">
                    <a class="page-link" href="<c:url value="/admin/seller-confirm"/>?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <div class="center p-4">
            <h2>TẤT CẢ NGƯỜI BÁN ĐÃ ĐƯỢC XÁC NHẬN</h2>
        </div>
    </c:otherwise>
</c:choose>