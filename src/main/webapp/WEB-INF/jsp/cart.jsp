<%-- 
    Document   : cart
    Created on : Sep 27, 2022, 10:50:21 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<div class="product-big-title-area">
    <div class="container">
        <br>
        <div class="product-bit-title">
            <h3 class="text-uppercase center">GIỎ HÀNG</h3>
        </div>
        <br>
    </div>
</div>

<c:if test="${cartProducts == null}">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="product-bit-title center">
                    <h4 class="text-primary">Bạn chưa thêm sản phẩm vào giỏ hàng</h4>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${cartProducts != null}">
    <c:if test="${cartProducts.size() != 0}">
        <div class="container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Số tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartProducts}" var="c">
                        <tr id="product${c.productId}">
                            <td>${c.productName}</td>
                            <td>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${c.price}" />  VNĐ
                            </td>
                            <td>
                                <div class="form-group">
                                    <input type="number" onblur="updateCart(this, ${c.productId})" value="${c.count}" class="form-control">
                                </div>
                            </td>
                            <td>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${c.price}" />  VNĐ
                            </td>
                            <td>
                                <input type="button" onclick="deleteItemInCart(${c.productId})" value="Xóa sp" class="btn btn-primary" />
                            </td>
                        </tr>  
                    </c:forEach>
                </tbody>
            </table>
            <div class="center">
            <input type="button" value="Thanh toán" class="btn btn-primary">
            </div>
            <br><br>
        </div>
    </c:if>
    <c:if test="${cartProducts.size() == 0}">
        <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="product-bit-title center">
                    <h4 class="text-primary">Bạn chưa thêm sản phẩm vào giỏ hàng</h4>
                </div>
            </div>
        </div>
    </div>
    </c:if>
</c:if>

<script src="<c:url value="/js/cart.js" />"></script>