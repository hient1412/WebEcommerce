<%-- 
    Document   : list-product-upload
    Created on : Sep 29, 2022, 4:26:19 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div>
    <h1 class="center p-4">TÌM KIẾM</h1>
    <div class="p-4" style="background-color: #ccc">
        <form action="" >
            <div class="row row-cols-1 row-cols-md-2 row-cols-sm-2">
                <div class="col">
                    <label>Từ khóa</label>
                    <input class="w-50" type="text" name="kw"/>
                </div>
                <div class="col">
                    <label>Số lượng</label>
                    <input class="w-25" type="number" name="quantityMin" placeholder="Min"/>
                    <label>-</label>
                    <input class="w-25" type="number" name="quantityMax" placeholder="Max"/>
                </div>
                <div class="col">
                    <label for="cat">Danh mục</label>
                    <select id="cat"name="cat">
                        <option value="" selected>Không chọn</option>
                        <c:forEach items="${cateBySeller}" var="c">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col">
                    <label for="active">Trạng thái</label>
                    <select id="active"name="active">
                        <option value="" selected>Tất cả</option>
                        <option value="1">Đang hoạt động</option>
                        <option value="0">Đã ẩn</option>
                    </select>
                </div>
            </div>
            <div class="center"> 
                <input type="submit" class="mt-4 p-1" value="Tìm kiếm"/>
                <input type="button" class="p-1" onclick="clearFilter()" value="Nhập lại"/>
            </div>
        </form>
    </div>
</div>

<div>
    <c:choose>
        <c:when test="${product.size() != 0}">
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
            <div class="product-list">
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3">
                    <c:forEach items="${product}" var="p">
                        <div class="col">
                            <div class="white-box mt-3">
                                <div class="product-img">
                                    <img src="${p.imageCollection.get(0).image}">
                                </div>
                                <div class="product-bottom">
                                    <div class="product-name">${p.name}
                                        <c:if test="${p.active == 0}">
                                            <div class="text-primary" ><h6>Trạng thái: Đã ẩn </h6></div>
                                        </c:if></div>
                                    <div><h6>Loại sản phẩm: ${p.idCategory.name}</h6></div>
                                    <div class="price">
                                        <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                    </div>
                                    <a class="blue-btn"" href="<c:url value="/product-detail/${p.id}"/>">Xem trước</a>
                                </div>
                                <div class="row mt-3 center">
                                    <div class="col">
                                        <a title="Sửa" href="<c:url value="/seller/product-edit"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa-regular fa-pen-to-square"></i>Sửa</a>
                                    </div>
                                    <div class="col">
                                        <c:if test="${p.active == '1'}">
                                            <a title="Ẩn" href="<c:url value="/seller/product-hide"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-eye-slash" aria-hidden="true"></i>Ẩn</a>
                                        </c:if>
                                        <c:if test="${p.active == '0'}">
                                            <a title="Hiện" href="<c:url value="/seller/product-show"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-eye" aria-hidden="true"></i>Hiện</a>
                                        </c:if>
                                    </div>
                                    <div class="col">
                                        <a title="Xóa" href="<c:url value="/seller/product-delete"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-trash" aria-hidden="true"></i>Xóa</a>
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
        <c:when test="${product.size() == 0}">
            <h3 class="center p-3">
                <i class="text-danger">Không có sản phẩm</i>
            </h3>
        </c:when>
    </c:choose>
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