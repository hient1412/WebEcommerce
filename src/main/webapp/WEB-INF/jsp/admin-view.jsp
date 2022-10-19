<%-- 
    Document   : admin-view
    Created on : Oct 5, 2022, 12:44:48 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row bg-light">
    <ul class="list-unstyled ps-0">
        <li class="mb-1">
            <div class="center pl-2 m-4">
                <button class="btn btn-toggle rounded collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
                    <h2>QUẢN LÝ</h2>
                </button>
            </div>
            <div class="collapse show center" id="home-collapse">
                <ul class="btn-toggle-nav list-unstyled fw-normal p-1">
                    <li class="nav-item p-1"><a href="<c:url value="/admin/dashboard"/>" class="link-dark"><strong><i class="fa fa-tachometer" aria-hidden="true"></i> Tổng quan</strong></a></li>
                    <li class="nav-item p-1"><a href="<c:url value="/admin/account"/>" class="link-dark" ><strong><i class="fa fa-users" aria-hidden="true"></i> Quản lý tài khoản</strong></a></li>
                    <li class="nav-item p-1"><a href="<c:url value="/admin/product-cate"/>" class="link-dark"><strong><i class="fa fa-cubes" aria-hidden="true"></i> Quản lý loại sản phẩm</strong></a></li>
                    <li class="nav-item p-1"><a href="<c:url value="/admin/seller-confirm"/>" class="link-dark" ><strong><i class="fa fa-credit-card" aria-hidden="true"></i> Duyệt</strong></a></li>
                    <button class="btn btn-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#stats-collapse" aria-expanded="false">
                        <li class="nav-item p-1"><strong><i class="fa fa-line-chart" aria-hidden="true"></i> Thống kê</strong></li>
                    </button>
                    <div class="center collapse" id="stats-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal p-1">
                            <li class="nav-item p-1"><a href="<c:url value="/admin/stats/role"/>" class="link-dark">Theo loại tài khoản</a></li>
                            <li class="nav-item p-1"><a href="<c:url value="/admin/stats/categories"/>" class="link-dark">Theo loại sản phẩm</a></li>
                        </ul>
                    </div>
                </ul>
            </div>
        </li>
    </ul>
</div>