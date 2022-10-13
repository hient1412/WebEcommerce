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
                        <div class="white-box mt-3">
                            <div class="wishlist-icon">
                                <img src="https://pngimage.net/wp-content/uploads/2018/06/wishlist-icon-png-3.png"/>
                            </div>
                            <div class="product-img">
                                <img src="${p.imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p.name}</div>
                                <div class="price">
                                    <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                </div>
                                <a class="blue-btn" href="<c:url value="/product-detail/${p.id}"/>">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <br>
                <div class="col-md-12">
                    <div class="pagination justify-content-center mt-4">
                        <ul class="pagination">
                            <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                                <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                </div> 
                <c:if test="${cateId == null}">
                    <c:if test="${buyALot.size() != 0}">
                        <h1 class="center"> SẢN PHẨM ĐƯỢC KHÁCH HÀNG ƯA CHUỘNG </h1>
                        <c:forEach items="${buyALot}" var="p">
                            <div class="col-md-3 col-sm-6">
                                <div class="white-box mt-3">
                                    <div class="wishlist-icon">
                                        <img src="https://pngimage.net/wp-content/uploads/2018/06/wishlist-icon-png-3.png"/>
                                    </div>
                                    <div class="product-img">
                                        <img src="${p[3].imageCollection.get(0).image}">
                                    </div>
                                    <div class="product-bottom">
                                        <div class="product-name">${p[1]}</div>
                                        <div class="price">
                                            <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p[2]}" maxFractionDigits="3" type="number"/>
                                        </div>
                                        <a class="blue-btn"" href="<c:url value="/product-detail/${p[0]}"/>">Xem chi tiết</a>
                                        <div class="pt-4"><span class="text-danger">Số lượt bán: ${p[4]}</span></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </c:if>          
            </c:when>
            <c:when test="${product.size() == 0}">
                <h3 class="center">
                    <i>Không có sản phẩm nào thuộc loại này </i>
                </h3>
            </c:when>
        </c:choose>
    </div>
</div>
