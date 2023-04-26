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
        <c:url var="link" value="/"/>
        <div class="dropdown-menu" style="width: fit-content;min-width: unset;padding: 0;">
            <button class="dropdown-item px-2" style="width: 100px;" onclick="changeLang(${link}, 'vi')">
                <div class="d-flex align-items-center">
                    <span>VI</span>
                </div>
            </button>
            <button class="px-2" style="width: 100px;" onclick="changeLang(${link}, 'en')">
                <div class="d-flex">
                    <span>EN</span>
                </div>
            </button>
        </div>
        <h2 class="text-uppercase"><spring:message code="label.billing.information"/></h2>
        <div class="row">
            <div class="col-75">
                <div class="container">
                    <form>
                        <div class="row">
                            <div class="col-50">
                                <h3><spring:message code="label.customer.information"/></h3>
                                <label for="fname"><i class="fa fa-user"></i> <spring:message code="label.customer.firstname"/></label>
                                <input type="text" id="fname" name="firstname" value="${shipAddress.name}" disabled>
                                <label for="email"><i class="fa fa-phone"></i> <spring:message code="label.phone"/></label>
                                <input type="text" id="phone" name="phone" value="${shipAddress.phone}" disabled>
                                <label for="email"><i class="fa fa-envelope"></i> <spring:message code="label.email"/></label>
                                <input type="text" id="email" name="email" value="${cus.email}" disabled>
                                <label for="adr"><i class="fa fa-address-card-o"></i> <spring:message code="label.address"/></label>
                                <input type="text" class="text2" id="adr" name="address" value="${shipAddress.address}, ${shipAddress.ward}, ${shipAddress.district}, ${shipAddress.city.name} " disabled > 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-25">
                <div class="container">
                    <h4><i class="fa fa-shopping-cart"></i> <spring:message code="label.cart"/></h4>
                    <c:forEach items="${cartProducts}" var="c">
                        <p><a href="#">${c.productName}</a> 
                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                <span id="vndPrice" name="vndPrice">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${c.price}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                <span id="usdPrice" name="usdPrice" >
                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(c.price)}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                            x ${c.count}</p>
                        </c:forEach>
                    <p><spring:message code="label.trans.fee"/> 
                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                            <span id="vndPrice" name="vndPrice">
                                <span style="text-decoration: underline">đ</span> 0
                            </span>
                        </c:if>
                        <c:if test="${pageContext.response.locale.language == 'en'}">
                            <span id="usdPrice" name="usdPrice" >
                                <span>$</span> 0
                            </span>
                        </c:if>
                    <hr>
                    <p><spring:message code="label.total.amount"/>
                        <c:if test="${pageContext.response.locale.language == 'vi'}">
                            <span id="vndPrice" name="vndPrice">
                                <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${cartAmount.amountWithShip}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                        <c:if test="${pageContext.response.locale.language == 'en'}">
                            <span id="usdPrice" name="usdPrice" >
                                <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(cartAmount.amountWithShip)}" maxFractionDigits="3" type="number"/>
                            </span>
                        </c:if>
                    </p>
                    <div>
                        <input type="button" onclick="pay()" value="<spring:message code="label.pay"/>" class="btn">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>



<script src="<c:url value="/js/cart.js" />"></script>
<script src="<c:url value="/js/main.js" />"></script>