<%-- 
    Document   : sel-order-detail
    Created on : Mar 26, 2023, 11:00:12 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container">
    <div class="center p-4">
        <h3>CHI TIẾT ĐƠN HÀNG </h3>
        <span>Mã đơn hàng: ${order.id}</span>
        <br>
        <span>Ngày đặt hàng: <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" /></span>
        <br>
        <span>Ngày dự kiến giao hàng: <fmt:formatDate value="${order.requiredDate}" pattern="dd-MM-yyyy" /></span>
        <br>
        <c:if test="${order.active == 1}">
            <h5 class="text-success">Trạng thái đơn hàng: Đã đặt hàng</h5>
        </c:if>
        <c:if test="${order.active == 0}">
            <h5 class="text-danger">Trạng thái đơn hàng: Đã hủy</h5>
        </c:if>
    </div>

    <div class="mt-3">
        <div class="border border-dark">
            <div class="p-4">
                <h4>Địa chỉ nhận hàng</h4>
                <div class="row pt-3">
                    <div class="col-md-12">
                        <b>${order.idShipAdress.name}</b> <span> | </span><label> ${order.idShipAdress.phone}</label> 
                        <p class="capitalizeText">${order.idShipAdress.address}</p> 
                        <p><span class="capitalizeText">${order.idShipAdress.ward}</span><span class="capitalizeText">, ${order.idShipAdress.district}</span><span>, ${order.idShipAdress.city.name} </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="border-left border-right border-dark bg-light">
            <div class="p-3">
                <div class="d-flex">
                    <div >
                        <div class="user-3 d-inline-block">
                            <img class="rounded-circle img-fluid" src="${order.idCustomer.avatar}">
                        </div>
                        <div class="d-inline"  style="font-size: 24px;">
                            <b><label>${order.idCustomer.idAccount.username}</label></b>
                        </div>
                    </div>
                    <div class="ml-auto">
                        <button class="border-dark p-2"><i class="fa fa-comments" aria-hidden="true"></i> Liên hệ</button>
                    </div>
                </div>
                <hr>
                <c:forEach items="${orderDetail.getOrderDetail(order.id)}" var="od">
                    <div class="row align-items-center">
                        <div class="col text-center">
                            <div class="product-img-4">
                                <div class="mb-2">
                                    <img src="${od.idProduct.imageCollection.get(0).image}">
                                </div>
                            </div>
                            <div class="mt-3">
                                <div class="mb-3">
                                    <label>${od.idProduct.name}</label>
                                </div>
                            </div>
                        </div>
                        <div class="col center">
                            <div class="mb-3">
                                <label>x ${od.quantity}</label>
                            </div>
                        </div>
                        <div class="col center">
                            <div class="mb-3">
                                <label><fmt:formatNumber value="${od.idProduct.price}" maxFractionDigits="3" type="number"/></label>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="mb-3">
        <div class="border border-dark bg-light">
            <table class="table table-bordered p-0 m-0">
                <tbody>
                    <tr class="text-right">
                        <td><b>Tổng tiền hàng</b></td>
                        <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                    </tr>
                    <tr class="text-right">
                        <td><b>Phí ship</b></td>
                        <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="0" maxFractionDigits="3" type="number"/><br></td>
                    </tr>
<!--                    <test="${order.amount != 0}">
                        <tr class="text-right">
                            <td><b>Tổng giảm từ shop</b></td>
                            <td> <span>-</span> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                        </tr>-->
                    <tr class="text-right">
                        <td><b>Thành tiền</b></td>
                        <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="border border-dark text-right bg-light mb-5">
        <div class="p-4">
            <h5>Phương thức thanh toán</h5>
            <c:if test="${order.paymentType == 1}">
                <h6 style="color: #267bd1">Thanh toán tại nhà</h6>
            </c:if>
            <c:if test="${order.paymentType == 2}">
                <h6 style="color: #267bd1">Thanh toán qua thẻ</h6>
            </c:if>
        </div>
    </div>
</div>