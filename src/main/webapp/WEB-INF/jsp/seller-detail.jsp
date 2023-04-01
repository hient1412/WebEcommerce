<%--
    Document   : seller-detail
    Created on : Oct 5, 2022, 5:12:55 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div>
    <div class="p-4 mt-4 bg-light">
        <div class="row justify-content-center center">
            <div class="col-12 col-lg-2 my-2">
                <div class="product-img-2">
                    <img class="rounded-circle img-fluid" src="${general[1]}">
                </div>
            </div>
            <div class="col-12 col-lg-2 my-2">
                <h4>${general[0]}</h4>
                <a href="#" class="btn btn-dark">Nhắn tin</a>
            </div>
            <div class="col-12 col-lg-4 my-2">
                <h4 class="text-uppercase">Mô tả shop</h4>
                <span class="center">${seller.description}</span>
            </div>
            <div class="col-12 col-lg-4 my-2">
                <h4 class="text-uppercase">Sản phẩm: <span class="text-danger">${general[2]}</span> </h4>
            </div>
        </div>
    </div>
    <div class="product-list">
        <div class="row">
            <c:if test="${productBySeller.size() != 0}">
                <h2 class="center pb-4 pt-4">Tất cả sản phẩm</h2>
                <div class="row">
                        <form action="">
                            <div class="mt-4">
                                <label for="cateId">Danh mục: </label>
                                <input type="radio" id="cateId" name="cateId" value="" ondblclick="this.form.submit()" checked>
                                <label>Tất cả</label>
                                <c:forEach items="${cateBySeller}" var="c">
                                    <input type="radio" id="cateId" name="cateId" ondblclick="this.form.submit()" onclick="paginationClick('sort', $('radio-toolbar').on(submit), function {
                                        $('input').val()}
                                        })" value="${c.id}">
                                    <label>${c.name}</label>
                                </c:forEach>
                            </div>
                            <div class="radio-toolbar" >
                                <span>Sắp xếp theo: </span>

                                <input onclick="this.form.submit()" type="radio" id="desc" name="sort" value="desc">
                                <label for="desc">Mới nhất</label>

                                <input onclick="this.form.submit()" type="radio" id="asc" name="sort" value="asc">
                                <label for="asc">Cũ nhất</label>

                                <input onclick="this.form.submit()" type="radio" id="pin" name="sort" value="pin">
                                <label for="pin">Giá tăng dần</label>

                                <input onclick="this.form.submit()" type="radio" id="pde" name="sort" value="pde">
                                <label for="pde">Giá giảm dần</label>
                            </div>
                        </form>
                    <c:forEach items="${productBySeller}" var="p">
                        <div class="col-md-4 col-sm-6 col-lg-3">
                            <div class="white-box mt-3">
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
                </c:if>
            </div>
        </div>
        <c:if test="${productBySeller.size() == 0}">
            <div class="row">
                <h3 class="center">
                    <i>Không có sản phẩm</i>
                </h3>
            </div>
        </c:if>
    </div>
</div>