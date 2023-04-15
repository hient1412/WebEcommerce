<%--
    Document   : customer-order-detail
    Created on : Feb 21, 2023, 7:43:36 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${errMessage != null}">
    <div class="text-danger pt-4 text-center" style="font-size: 20px;">
        ${errMessage}
    </div>
</c:if>
<div class="center p-4">
    <h3>CHI TIẾT ĐƠN HÀNG </h3>
    <span>Mã đơn hàng: ${order.id}</span>
    <br>
    <span>Ngày đặt hàng: <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy hh:mm:ss" /></span>
    <c:if test="${order.daySend != null}">
        <br>
        <h5 class="text-danger">Người bán phải gửi hàng vào ngày: <fmt:formatDate value="${order.daySend}" pattern="dd-MM-yyyy" /></h5>
    </c:if>
    <c:if test="${order.active == 1}">
        <h5 class="text-success">Trạng thái đơn hàng: Đã đặt hàng</h5>
    </c:if>
    <c:if test="${order.active == 2}">
        <h5 class="text-success">Trạng thái đơn hàng: Chờ lấy hàng</h5>
    </c:if>
    <c:if test="${order.active == 3}">
        <h5 class="text-success">Trạng thái đơn hàng: Chờ vận chuyển</h5>
    </c:if>
    <c:if test="${order.active == 4}">
        <h5 class="text-success">Trạng thái đơn hàng: Đang giao</h5>
    </c:if>
    <c:if test="${order.active == 5}">
        <h5 class="text-success">Trạng thái đơn hàng: Đã hoàn thành (vào lúc: <fmt:formatDate value="${order.orderReceived}" pattern="dd-MM-yyyy hh:mm:ss" />)</h5>
    </c:if>
    <c:if test="${order.active == 0}">
        <h5 class="text-danger">Trạng thái đơn hàng: Đã hủy</h5>
        <a href="<c:url value="/customer/cancel/${order.id}"/>">Xem chi tiết đơn hủy</a>
        <br>
    </c:if>
    <span>Ngày dự kiến giao hàng: <fmt:formatDate value="${order.requiredDate}" pattern="dd-MM-yyyy" /></span>
    <br>
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
                        <a href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}"><img class="rounded-circle img-fluid" src="${seller.getSeller(order.id)[1]}"></a>
                    </div>
                    <div class="d-inline" style="font-size: 24px;">
                        <a class="link-dark" href="http://localhost:8080/WebEcommerce/seller-detail/${seller.getSeller(order.id)[2]}"><label>${seller.getSeller(order.id)[0]}</label></a>
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
                <tr class="text-right">
                    <td><b>Thành tiền</b></td>
                    <td> <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${order.amount}" maxFractionDigits="3" type="number"/><br></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="border border-dark text-right bg-light">
    <div class="p-2">
        <h5>Phương thức thanh toán</h5>
        <c:if test="${order.paymentType == 1}">
            <h6 style="color: #267bd1">Thanh toán tại nhà</h6>
        </c:if>
        <c:if test="${order.paymentType == 2}">
            <h6 style="color: #267bd1">Thanh toán qua thẻ</h6>
        </c:if>
    </div>
</div>
<div class="d-flex">
    <div class="py-4">
        <a class="btn btn-dark" href="<c:url value="/customer/list-cus-order"/>"><i class="fa-solid fa-arrow-left"></i> Trở lại</a>
    </div>
    <c:if test="${order.active == 1 || order.active == 2}">  <!-- Đặt hàng hoặc chờ lấy hàng -->
        <div class="p-4">
            <a class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#reasonCancel">Hủy đơn hàng</a>
        </div>
    </c:if>
    <c:if test="${order.active == 5}">  <!-- Đặt hàng thành công -->
        <div class="p-4">
            <a class="btn btn-outline-success" >Mua lại đơn hàng</a>
        </div>
    </c:if>
    <c:if test="${order.active == 4}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/customer/order-detail/${order.id}/confirm"/>">Đã nhận được hàng</a>
        </div>
    </c:if>
</div>
<div class="modal fade" id="reasonCancel" tabindex="-1" aria-labelledby="reasonCancel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nêu lý do hủy đơn hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form:form action="" modelAttribute="cancel" method="post">
                <div class="modal-body">

                    <form:select path="cancelDescription" >
                        <c:if test="${order.active == 1}">
                            <form:option value="Đổi ý, không muốn mua nữa" label="Đổi ý, không muốn mua nữa"/>
                        </c:if>
                        <c:if test="${order.active == 2}">
                            <form:option value="Người bán gửi hàng lâu" label="Người bán gửi hàng lâu"/>
                        </c:if>
                        <form:option value="Muốn thay đổi sản phẩm" label="Muốn thay đổi sản phẩm"/>
                        <form:option value="Muốn thay đổi phương thức thanh toán" label="Muốn thay đổi phương thức thanh toán"/>
                        <form:option value="Khác" label="Khác"/>
                    </form:select>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Gửi lý do</button>
                </div>
            </form:form>
        </div>
    </div>
</div>