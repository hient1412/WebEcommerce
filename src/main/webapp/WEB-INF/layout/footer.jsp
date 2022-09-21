<%-- 
    Document   : footer
    Created on : Sep 21, 2022, 5:14:31 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="container-fluid padding">
    <div id="footer" class="row text-center">
        <div class="col-md-4">
            <p><h5>Liên hệ hỗ trợ</h5></p>
            <p><i class="fa fa-phone" aria-hidden="true"></i> Ho Chi Minh: (+84) 385 620 489</p>
            <p><i class="fa fa-phone" aria-hidden="true"></i> Ha Noi: (+84) 024 650 449</p>
        </div>
        <div class="col-md-4">
            <p><h5>Kết nối với chúng tôi</h5></p>
            <a href="#"><img class="social" src="<c:url value="/images/fb.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/ins.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/twitter.png"/>"/></a>
            <a href="#"><img class="social" src="<c:url value="/images/youtube.png"/>"/></a>
        </div>
        <div class="col-md-4">
            <p><h5>Địa Điểm</h5></p>
            <p><i class="fa fa-map-marker" aria-hidden="true"></i> 72 Nguyen Kiem, Go Vap, Ho Chi Minh</p>
            <p><i class="fa fa-map-marker" aria-hidden="true"></i> 152 Nguyen Tuan, Thanh Xuan, Ha Noi</p>
        </div>
    </div>
    <div id="sign" class="row text-center">
        <div class="col-12">
            <p>
            <h5>&copy; WebEcommerce &copy;</h5>
            <h7><i class="fa fa-envelope-o" aria-hidden="true"></i> ecommerce@gmail.com</h7>
            </p>
        </div>
    </div>
</div>