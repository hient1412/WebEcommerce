<%-- 
    Document   : seller-view
    Created on : Sep 29, 2022, 9:26:05 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-sm-2 col-md-2">
        <ul class="list-unstyled ps-0">
            <li class="mb-1">
                <button class="btn btn-toggle align-items-center rounded collapsed p-2 mt-3" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
                    <h2>QUẢN LÝ</h2>
                </button>
                <div class="collapse show center" id="home-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal p-1">
                        <li class="nav-item p-1"><a href="<c:url value="/seller/list-product-upload"/>" class="link-dark">Tất cả sản phẩm</a></li>
                        <li class="nav-item p-1"><a href="#" class="link-dark" >Doanh Thu</a></li>
                        <li class="nav-item p-1"><a href="#" class="link-dark" >Mã giảm cửa hàng</a></li>
                        <li class="nav-item p-1"><a href="#" class="link-dark" >Đánh giá</a></li>
                        <li class="nav-item p-1"><a href="#" class="link-dark" >Hồ sơ cửa hàng</a></li>
                        <li class="nav-item p-1"><a href="#" class="link-dark" >Thống kê</a></li>
                    </ul>
                </div>
            </li>
        </ul>
        <hr class="d-sm-none">
    </div>
    <div class="col-sm-10">
        
    </div>
</div>