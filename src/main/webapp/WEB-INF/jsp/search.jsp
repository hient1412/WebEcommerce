<%-- 
    Document   : search
    Created on : Sep 24, 2022, 1:10:51 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="row bg-light">
    <div class="col-md-3 p-4">
        <h4 class="center"><i class="fa fa-filter" aria-hidden="true"></i> BỘ LỌC TÌM KIẾM</h4>
        <b>Theo danh mục</b>
        <br>
        <c:forEach items="${categories}" var="c">
            <input type="checkbox" /> <span class="font20">${c.name}</span><br>
        </c:forEach>
    </div>
    <div class="col-md-9">
        <div class="row p-3">
            <c:if test="${!kw.isEmpty()}">
                <div class="title-center">
                    <h1>Kết quả tìm kiếm</h1>
                    <span style="color: blue">"${kw}"</span>
                </div>
            </c:if>
            <c:if test="${counterS != 0 && !kw.isEmpty()}">
                <div style="text-align: center">
                    <span>Tìm thấy <span style="color: red">${counterS}</span> kết quả phù hợp</span>
                </div>
            </c:if>
            <c:if test="${counterS == 0}">
                <div style="text-align: center">
                    <i>Không tìm thấy việc làm phù hợp với yêu cầu tìm kiếm của bạn</i>
                </div>
            </c:if>
        </div>
            <div class="row">
                <c:forEach items="${product}" var="p">
                    <div class="col-md-3 col-sm-6 p-1">
                        <div class="white-box">
                            <div class="wishlist-icon">
                                <img src="https://pngimage.net/wp-content/uploads/2018/06/wishlist-icon-png-3.png"/>
                            </div>
                            <div class="product-img">
                                <img src="">
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
            </div>
        </div>
        <div class="col-md-12">
            <div class="pagination justify-content-center center">
                <ul class="pagination">
                    <!--<li class="page-item previous-page"><a class="page-link" href="#">&laquo;</a></li>-->
                    <c:forEach begin="1" end="${Math.ceil(counterS/6)}" var="i">
                        <li class="page-item current-page"><a class="page-link" href="<c:url value="/" />?page=${i}">${i}</a></li>
                        </c:forEach>
                    <!--<li class="page-item next-page"><a class="page-link" href="#">&raquo;</a></li>-->
                </ul>
            </div>
        </div>
    </div>
</div>