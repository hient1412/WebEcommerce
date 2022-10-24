<%--
    Document   : seller-view
    Created on : Sep 29, 2022, 9:26:05 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="!hasRole('ROLE_CUSTOMER')">

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
                        <li class="nav-item p-1"><a href="<c:url value="/seller/dashboard"/>" class="link-dark"><strong><i class="fa fa-tachometer" aria-hidden="true"></i> Tổng quan</strong></a></li>
                        <li class="nav-item p-1"><a href="<c:url value="/seller/list-order"/>" class="link-dark"><strong><i class="fa-regular fa-file"></i> Quản lý đơn hàng</strong></a></li>
                        <button class="btn btn-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#product-collapse" aria-expanded="false">
                            <li class="nav-item p-1"><strong><i class="fa fa-shopping-bag" aria-hidden="true"></i> Quản lý sản phẩm</strong></li>
                        </button>
                        <div class="center collapse" id="product-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal p-1">
                                <li class="nav-item p-1"><a href="<c:url value="/seller/list-product-upload"/>" class="link-dark">Tất cả sản phẩm</a></li>
                                <li class="nav-item p-1"><a href="<c:url value="/seller/product"/>" class="link-dark">Thêm sản phẩm</a></li>
                            </ul>
                        </div>
                        <li class="nav-item p-1"><a href="#" class="link-dark" ><strong><i class="fa-regular fa-credit-card"></i> Doanh Thu</strong></a></li>
                        <button class="btn btn-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#stats-collapse" aria-expanded="false">
                            <li class="nav-item p-1"><strong><i class="fa fa-line-chart" aria-hidden="true"></i> Thống kê</strong></li>
                        </button>
                        <div class="center collapse" id="stats-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal p-1">
                                <li class="nav-item p-1"><a href="<c:url value="/seller/stats/categories"/>" class="link-dark">Theo danh mục</a></li>
                                <li class="nav-item p-1"><a href="<c:url value="/seller/stats/turnover/product"/>" class="link-dark">Theo doanh thu từng sản phẩm</a></li>
                            </ul>
                        </div>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</sec:authorize>