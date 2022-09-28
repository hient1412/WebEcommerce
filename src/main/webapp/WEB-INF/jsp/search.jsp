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
            <div class="mt-3"><b>Người bán</b> <input autocomplete="off" style="width: 120px" type="text" name="seller" /></div>
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
            <input type="button" onclick="clearFilter()" value="Xóa lọc"/>
            <input type="submit" class="mt-4" value="Lọc"/>
        </form>
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
                    <i>Không tìm thấy sản phẩm phù hợp với yêu cầu tìm kiếm của bạn</i>
                </div>
            </c:if>
        </div>

        <div class="row">
            <c:forEach items="${listProduct}" var="p">
                <div class="col-md-3 col-sm-6 p-1">
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
            
<div class="col-md-12">
    <div class="pagination justify-content-center mt-4">
        <ul class="pagination">
            <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
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