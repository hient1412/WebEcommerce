<%-- 
    Document   : sellers
    Created on : Oct 7, 2022, 4:10:08 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <h1 class="center p-4">TÌM KIẾM CỬA HÀNG</h1>
    <div >
        <form action="" >
            <div class="center">
                <label>Tên cửa hàng</label>
                <input type="text" name="kw" autocomplete="off"/>
                <input type="submit" class="mt-4 p-1" value="Tìm kiếm"/>
                <input type="button" class="p-1" onclick="clearFilter()" value="Nhập lại"/>
            </div>
        </form>
    </div>
</div>

<div class="row">
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
</div>
<div>
    <c:choose>
        <c:when test="${sellers.size() != 0}">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div class="product-list">
                        <div class="row m-1">
                            <c:forEach items="${sellers}" var="s">
                                <div class="white-box-2 mt-2">
                                    <div class="row p-2">
                                        <div class="col-md-2">
                                            <a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>"><img class="product-img-2 img-fluid rounded-circle" src="${s[2]}"/></a>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="row">
                                                <div>
                                                    <b><a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>">${s[1]}</a></b>
                                                </div>
                                                <a class="btn btn-info" href="/WebEcommerce/seller-detail/${s[0]}">Xem shop</a>
                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6 center" style="border-left: 1px solid #000000">
                                                    <h4><i class="fa-solid fa-location-dot"></i> ${s[3]}</h4>
                                                    <span>Địa chỉ</span>
                                                </div>
                                                <div class="col-md-6 center" style="border-left: 1px solid #000000">
                                                    <h4><i class="fa-solid fa-box"></i> ${s[4]}</h4>
                                                    <span>Sản phẩm</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="pagination justify-content-center mt-4">
                            <ul class="pagination">
                                <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                                    <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </div>    
                </c:when>
                <c:when test="${sellers.size() == 0}">
                    <h3 class="center p-3">
                        <i class="text-danger">Không có cửa hàng</i>
                    </h3>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>