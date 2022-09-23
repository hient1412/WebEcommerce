<%-- 
    Document   : home
    Created on : Sep 21, 2022, 5:15:28 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="product-list">
    <div class="row">
        <c:choose>
            <c:when test="${product.size() != 0}">
                <c:forEach items="${product}" var="p">
                    <div class="col-md-3 col-sm-6">
                        <div class="white-box">
                            <div class="wishlist-icon">
                                <img src="https://pngimage.net/wp-content/uploads/2018/06/wishlist-icon-png-3.png"/>
                            </div>
                            <div class="product-img">
                                <img src="${p.imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p.name}</div>
                                <div class="price">
                                    <span class="rupee-icon"><fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/> VND</span>
                                </div>
                                <a href="#" class="blue-btn">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:when test="${product.size() == 0}">
                <h3 class="center"><i>Không có sản phẩm phù hợp</i><h3>
            </c:when>
        </c:choose>

    </div>
</div>