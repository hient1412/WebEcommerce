<%--
    Document   : sel-order-detail
    Created on : Mar 26, 2023, 11:00:12 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url value="/seller/order-detail/${order.id}/send" var="action"/>
<div class="container">
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
            <a href="<c:url value="/seller/cancel/${order.id}"/>">Xem chi tiết đơn hủy</a>
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
<c:if test="${errMessage != null}">
    <div class="text-danger pt-4 text-center" style="font-size: 20px;">
        ${errMessage}
    </div>
</c:if>
<div class="d-flex">
    <div class="py-4 px-2">
        <a class="btn btn-dark" href="<c:url value="/seller/list-order"/>"><i class="fa-solid fa-arrow-left"></i> Trở lại</a>
    </div>
    <c:if test="${order.active == 2 || order.active == 1}">
        <div class="py-4 px-2">
            <a class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#reasonCancel">Hủy đơn hàng</a>
        </div>
    </c:if>
    <c:if test="${order.active == 1}">
        <div class="py-4 px-2">
            <a class="btn btn-success" href="<c:url value="/seller/order-detail/${order.id}/confirm"/>">Xác nhận đơn hàng</a>
        </div>
    </c:if>
    <c:if test="${order.active == 2}">  <!-- chờ vận chuyển -->
        <div class="py-4 px-2">
            <a class="btn btn-success" data-bs-toggle="modal" data-bs-target="#setDaySend">Chọn ngày gửi hàng</a>
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
                        <form:option value="Hết hàng" label="Hết hàng"/>
                        <form:option value="Người mua yêu cầu hủy" label="Người mua yêu cầu hủy"/>
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
<div class="modal fade" id="setDaySend" tabindex="-1" aria-labelledby="#setDaySend" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Chọn ngày gửi đơn hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div  class="pt-2 pb-2"><h6 class="text-danger">* Vui lòng không gửi hàng sau 7 ngày *</h6></div>
            <form action="${action}">
                <div class="form-group row">
                    <div class="form-group col-md-8">
                        <input type="date" id="daySend" class="form-control" name="daySend" required="required"/>
                    </div>
                    <div class="form-group col-md-4">
                        <button class="form-control btn btn-primary" type="submit">Chọn</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>     

<script>
    document.getElementById('daySend').value = new Date().toISOString().substring(0, 10);

    $(function () {
        var dtToday = new Date();

        var month = dtToday.getMonth() + 1;
        var day = dtToday.getDate();
        var year = dtToday.getFullYear();
        if (month < 10)
            month = '0' + month.toString();
        if (day < 10)
            day = '0' + day.toString();

        var minDate = year + '-' + month + '-' + day;
        var maxDate = year + '-' + month + '-' + (day + 7);

        $('#daySend').attr('min', minDate);
        $('#daySend').attr('max', maxDate);
    });
</script>