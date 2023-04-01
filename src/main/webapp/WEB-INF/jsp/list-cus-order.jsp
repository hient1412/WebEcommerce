<%-- 
    Document   : list-cus-order
    Created on : Oct 19, 2022, 3:13:41 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<h1 class="center p-4">TÌM KIẾM</h1>
<div class="p-4" style="background-color: #ccc">
    <form action="" >
        <div class="row row-cols-1 row-cols-md-2 row-cols-sm-2">
                <div class="col">
                <label>Mã đơn hàng</label>
                <input type="number" name="idOrder" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label>Tên sản phẩm</label>
                <input type="text" name="namePro" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label>Tên người bán</label>
                <input type="text" name="nameSel" class="form-control" autocomplete="off"/>
            </div>
            <div class="col">
                <label  for="active">Trạng thái</label>
                <select class="form-control" id="active"name="active">
                    <option value="" selected>Tất cả</option>
                    <option value="1">Đã đặt hàng</option>
                    <option value="0">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="center">
            <input type="submit" class="mt-4 p-1" value="Tìm kiếm"/>
            <input type="button" class="p-1" onclick="clearFilter()" value="Nhập lại"/>
        </div>
    </form>
</div>
<c:choose>
    <c:when test="${orders.size() != 0}">
        <div class="product-list">
            <div class="row">
                <div class="white-box bg-light p-1 center media-white-none">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Sản phẩm</label>
                        </div>
                        <div class="col-md-2 center">
                            <label>Số lượng</label>
                        </div>
                        <div class="col-md-2 center">
                            <label>Tổng đơn</label>
                        </div>
                        <div class="col-md-2 center">
                            <label>Trạng thái</label>
                        </div>
                        <div class="col-md-2 center">
                            <label></label>
                        </div>
                    </div>
                </div>
                <c:forEach items="${orders}" var="o">
                    <div class="white-box-2 mt-2">
                        <div class="row d-flex">
                            <div class="col-6 col-lg-8">
                                <div class="user-2 d-inline-block">
                                    <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(o.id)[2]}"><img class="rounded-circle img-fluid" src="${seller.getSeller(o.id)[1]}"></a>
                                </div>
                                <div class="d-inline">
                                    <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(o.id)[2]}"><label>${seller.getSeller(o.id)[0]}</label></a> <i class="fa fa-comments" aria-hidden="true"></i>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4" style="text-align: right">
                                <label>Mã đơn: ${o.id}</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 col-lg-6">
                                <div class="row">
                                    <c:forEach items="${orderDetail.getOrderDetail(o.id)}" var="od">
                                       <div class="col-4 col-md-2">
                                            <div class="product-img-3">
                                                <a href="<c:url value="/product-detail/${od.idProduct.id}"/>">
                                                    <div>
                                                        <img src="${od.idProduct.imageCollection.get(0).image}">
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-4 col-md-6">
                                            <a href="<c:url value="/product-detail/${od.idProduct.id}"/>">
                                                <div>
                                                    <label style="color: black; cursor: pointer">${od.idProduct.name}</label>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 col-md-4 center">
                                            <div>
                                                <label>x ${od.quantity}</label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                             <div class="col-12 col-lg-6">
                                <div class="row">
                                    <div class="col-12 col-lg-4 text-end">
                                        <div>
                                            <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${o.amount}" maxFractionDigits="3" type="number"/><br>
                                            <c:if test="${o.paymentType == 1}">
                                                <span style="font-size: 10px;color: #ccc">Thanh toán tại nhà</span>
                                            </c:if>
                                            <c:if test="${o.paymentType == 2}">
                                                <span style="font-size: 10px;color: #ccc">Thanh toán qua thẻ</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-12 col-lg-4 text-end  media-active">
                                        <div>
                                            <c:if test="${o.active == 1}">
                                                <label>Đã đặt hàng</label>
                                            </c:if>
                                            <c:if test="${o.active == 0}">
                                                <label>Đã hủy</label>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-12 col-lg-4 text-end">
                                        <a href="<c:url value="/customer/order-detail/${o.id}"/>">Xem chi tiết</a>
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
    <c:when test="${orders.size() == 0}">
        <h3 class="center p-3">
            <i class="text-danger">Không có đơn hàng</i>
        </h3>
    </c:when>
</c:choose>
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
