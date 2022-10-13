<%-- 
    Document   : list-order
    Created on : Oct 6, 2022, 7:07:59 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div>
    <h1 class="center p-4">TÌM KIẾM</h1>
    <div class="p-4" style="background-color: #ccc">
        <form action="" >
            <div class="row">
                <div class="col-3">
                    <label>Mã đơn hàng</label>
                    <input type="number" name="idOrder" autocomplete="off"/>
                </div>
                <div class="col-3">
                    <label>Tên khách hàng</label>
                    <input type="text" name="nameCus" autocomplete="off"/>
                </div>
                <div class="col-3">
                    <label>Sản phẩm</label>
                    <input type="text" name="namePro" autocomplete="off"/>
                </div>
                <div class="col-3">
                    <label for="active">Trạng thái</label>
                    <select id="active"name="active">
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
                <div class="row m-1">
                    <div class="white-box bg-light p-2 ">
                        <div class="row">
                            <div class="col-md-6">
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
                        </div>
                    </div>
                    <c:forEach items="${product}" var="p">
                        <div class="white-box-2 mt-2">
                            <div class="row d-flex">
                                <div class="col-md-4">
                                    <div class="user-2 d-inline-block">
                                        <img class="rounded-circle img-fluid" src="${p[5]}">
                                    </div>
                                    <div class="d-inline">
                                    <label>${p[6]}</label> <i class="fa fa-comments" aria-hidden="true"></i>
                                    </div>
                                </div> 
                                <div class="col-md-2" style="text-align: right">
                                    <label>Mã đơn: ${p[0]}</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-1">
                                    <div class="product-img-3">
                                        <img src="${p[4].image}">
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <c:forEach items="${p[3].getOrderDetailCollection()}" var="c">
                                        <div class="mb-3">
                                            <label>${c.idProduct.name}</label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="col-md-2 center">
                                    <div class="mb-3">
                                        <label>x ${p[7]}</label>
                                    </div>
                                </div>
                                <div class="col-md-2 center">
                                    <div>
                                        <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p[1]}" maxFractionDigits="3" type="number"/>
                                        <c:if test="${p[8] == 1}">
                                        <span style="font-size: 10px;color: #ccc">Thanh toán tại nhà</span>
                                        </c:if>
                                        <c:if test="${p[8] == 2}">
                                        <span style="font-size: 10px;color: #ccc">Thanh toán qua thẻ</span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-2 center">
                                    <div>
                                        <c:if test="${p[2] == 1}">
                                            <label>Đã đặt hàng</label>
                                        </c:if>
                                        <c:if test="${p[2] == 0}">
                                            <label>Đã hủy</label>
                                        </c:if>
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