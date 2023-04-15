<%-- 
    Document   : checkout.jsp
    Created on : Mar 7, 2023, 8:39:27 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            body {
                font-family: Arial;
                font-size: 17px;
                padding: 8px;
            }
            .text2 {
                text-transform: capitalize;
            }

            * {
                box-sizing: border-box;
            }

            .row {
                display: -ms-flexbox; /* IE10 */
                display: flex;
                -ms-flex-wrap: wrap; /* IE10 */
                flex-wrap: wrap;
                margin: 0 -16px;
            }

            .col-25 {
                -ms-flex: 25%; /* IE10 */
                flex: 25%;
            }

            .col-50 {
                -ms-flex: 50%; /* IE10 */
                flex: 50%;
            }

            .col-75 {
                -ms-flex: 75%; /* IE10 */
                flex: 75%;
            }

            .col-25,
            .col-50,
            .col-75 {
                padding: 0 16px;
            }

            .container {
                background-color: #f2f2f2;
                padding: 5px 20px 15px 20px;
                border: 1px solid lightgrey;
                border-radius: 3px;
            }

            input[type=text] {
                width: 100%;
                margin-bottom: 20px;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }

            label {
                margin-bottom: 10px;
                display: block;
            }

            .icon-container {
                margin-bottom: 20px;
                padding: 7px 0;
                font-size: 24px;
            }

            .btn {
                background-color: #04AA6D;
                color: white;
                padding: 12px;
                margin: 10px 0;
                border: none;
                width: 100%;
                border-radius: 3px;
                cursor: pointer;
                font-size: 17px;
            }

            .btn:hover {
                background-color: #45a049;
            }

            a {
                color: #2196F3;
            }

            hr {
                border: 1px solid lightgrey;
            }

            span.price {
                float: right;
                color: grey;
            }

            /* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
            @media (max-width: 800px) {
                .row {
                    flex-direction: column-reverse;
                }
                .col-25 {
                    margin-bottom: 20px;
                }
            }
        </style>
    </head>
    <body>

        <h2>THÔNG TIN THANH TOÁN</h2>
        <div class="row">
            <div class="col-75">
                <div class="container">
                    <form>
                        <div class="row">
                            <div class="col-50">
                                <h3>Thông tin khách hàng</h3>
                                <label for="fname"><i class="fa fa-user"></i> Tên khách hàng</label>
                                <input type="text" id="fname" name="firstname" value="${shipAddress.name}" disabled>
                                <label for="email"><i class="fa fa-phone"></i> Số điện thoại</label>
                                <input type="text" id="phone" name="phone" value="${shipAddress.phone}" disabled>
                                <label for="email"><i class="fa fa-envelope"></i> Email</label>
                                <input type="text" id="email" name="email" value="${cus.email}" disabled>
                                <label for="adr"><i class="fa fa-address-card-o"></i> Địa chỉ</label>
                                <input type="text" class="text2" id="adr" name="address" value="${shipAddress.address}, ${shipAddress.ward}, ${shipAddress.district}, ${shipAddress.city.name} " disabled > 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-25">
                <div class="container">
                    <h4><i class="fa fa-shopping-cart"></i> Giỏ hàng</h4>
                    <c:forEach items="${cartProducts}" var="c">
                        <p><a href="#">${c.productName}</a> <fmt:formatNumber type="number" maxFractionDigits="3" value="${c.price}" /> <span style="text-decoration: underline">đ</span> x ${c.count}</p>
                    </c:forEach>
                    <p>Phí vận chuyển</a> 0 <span style="text-decoration: underline">đ</span></p>
                    <hr>
                    <p>Tổng <span id="cartAmount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartAmount.amountWithShip}"/></span> VNĐ</p>
                    <div>
                        <input type="button" onclick="pay()" value="THANH TOÁN" class="btn">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>



<script src="<c:url value="/js/cart.js" />"></script>