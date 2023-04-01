<%--
    Document   : search
    Created on : Sep 24, 2022, 1:10:51 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="row bg-light">
    <div class="col-md-3 p-4 center">
        <h4 class="center"><i class="fa fa-filter" aria-hidden="true"></i> LỌC NÂNG CAO</h4>
        <form action="" class="">
            <div class="left">
                <br>
                <b>Giá từ</b> <input style="width: 70px "type="number" name="fp" />
                <b>Đến</b> <input style="width: 70px" type="number" name="tp"/>
                <input hidden="true" name="kw" value="${kw}" />
                <div class="mt-4">
                    <label for="sort"> Sắp xếp</label>
                    <select id="sort"name="sort">
                        <option value="" selected>Không chọn</option>
                        <option value="desc">Theo mới nhất</option>
                        <option value="asc" >Theo cũ nhất</option>
                        <option value="az" >Theo tên tăng dần</option>
                        <option value="za" >Theo tên giảm dần</option>
                        <option value="pin" >Theo giá tăng dần</option>
                        <option value="pde" >Theo giá giảm dần</option>
                    </select>
                </div>
                <div class="mt-4">
                    <label for="cat">Danh mục</label>
                    <select id="cat"name="cat">
                        <option value="" selected>Không chọn</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mt-4">
                    <label for="location">Nơi bán</label>
                    <select id="location"name="location">
                        <option value="" selected>Không chọn</option>
                        <c:forEach items="${locations}" var="l">
                            <option value="${l.id}">${l.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <input type="submit" class="mt-4 p-1" value="Lọc"/>
            <input type="button" class="p-1" onclick="clearFilter()" value="Xóa lọc"/>
        </form>
    </div>
    <div class="col-md-9">
        <div class="row">
            <c:if test="${!kw.isEmpty()}">
                <div class="title-center">
                    <h1>Kết quả tìm kiếm</h1>
                    <span style="color: blue">"${kw}"</span>
                </div>
            </c:if>
        </div>
        <div>
            <c:if test="${!kw.isEmpty()}">
                <c:if test="${sellers.size() != 0}">
                    <c:if test="${sellerCounterS != 0 && !kw.isEmpty()}">
                        <b>Tìm trong shop</b> 
                        <div>
                            <span>Có <span style="color: red">${sellerCounterS}</span> kết quả phù hợp</span>
                        </div>
                    </c:if>
                    <c:if test="${sellerCounterS == 0}">
                        <div>
                            <i>Không tìm thấy sản phẩm phù hợp với yêu cầu tìm kiếm của bạn</i>
                        </div>
                    </c:if>
                    <c:if test="${errMessage != null}">
                        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                            ${errMessage}
                        </div>
                    </c:if>
                    <div class="row justify-content-center">
                        <div class="product-list">
                            <div class="row m-1">
                                <c:forEach items="${sellers}" var="s">
                                    <div class="white-box-2 mt-2">
                                        <div class="row p-2 align-items-center">
                                            <div class="col-md-1 p-0 m-0 col-sm-3 col-3">
                                                <a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>"><img class="product-img-2 img-fluid rounded-circle" src="${s[2]}"/></a>
                                            </div>
                                            <div class="col-md-2 ps-5 col-sm-3 col-3">
                                                <div class="row">
                                                    <div>
                                                        <b><a class="link-dark" href="<c:url value="/seller-detail/${s[0]}"/>">${s[1]}</a></b>
                                                    </div>
                                                    <a class="btn btn-info" href="/WebEcommerce/seller-detail/${s[0]}">Xem shop</a>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-sm-6 col-6">
                                                <div class="row">
                                                    <div class="col-md-6 col-sm-6 col-6 center" >
                                                        <h4><i class="fa-solid fa-location-dot"></i> ${s[3]}</h4>
                                                        <span>Địa chỉ</span>
                                                    </div>
                                                    <div class="col-md-6 col-sm-6 col-6 center" >
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
                    </c:if>
                </c:if>
            </div>
            <c:if test="${productCounterS != 0 && !kw.isEmpty()}">
                <div class="row">
                    <br>
                    <b>Tìm trong sản phẩm</b>
                    <div>
                        <span>Có <span style="color: red">${productCounterS}</span> kết quả phù hợp</span>
                    </div>
                </div>
            </c:if>
            <c:if test="${productCounterS == 0}">
                <div class="row">
                    <div style="text-align: center">
                        <i>Không tìm thấy sản phẩm phù hợp với yêu cầu tìm kiếm của bạn</i>
                    </div>
                </div>
            </c:if>

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
                <c:forEach items="${listProduct}" var="p">
                    <div class="col p-1">
                        <div class="white-box">
                            <div class="product-img">
                                <img src="${p.imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p.name}</div>
                                <div class="price">
                                    <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                </div>
                                <a class="blue-btn"" href="<c:url value="/product-detail/${p.id}"/>">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="pagination justify-content-center mt-4">
        <ul class="pagination">
            <c:forEach begin="1" end="${Math.ceil(productCounterS/count)}" var="i">
                <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                </c:forEach>
        </ul>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "") {
                    $(obj).removeAttr("name");
                }
            });
        });
    });
</script>