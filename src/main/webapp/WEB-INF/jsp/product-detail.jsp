<%--
    Document   : product-detail
    Created on : Sep 25, 2022, 6:11:22 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:if test="${errMessage != null}">
    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
        ${errMessage}
    </div>
</c:if>
<div class="row d-flex justify-content-center">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-6">
                <br>
                <div class="row card">
                    <div class="p-3">
                        <div class="text-center"> <img style="width: 450px;height: 500px" id="img-main" src="${product.imageCollection.get(0).image}"/> </div>
                    </div>
                    <div class="row">
                        <div class="thumbnail text-center p-3">
                            <c:forEach items="${image}" var="i">
                                <img class="border border-dark" onmousemove="change_image(this)" src="${i.image}" width="70px" height="70px">
                            </c:forEach>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <sec:authorize access="isAuthenticated()">
                            <div class="col text-left mb-2" style="font-size: 24px">
                                <i class="fas fa-share-square"></i>
                                <i class="fab fa-facebook-square"></i>
                                <i class="fab fa-facebook-messenger"></i>
                                <i class="fab fa-instagram"></i>
                            </div>
                            <div class="col text-center mb-2">
                                <sec:authorize access="isAuthenticated()">
                                    <sec:authorize access="hasRole('ROLE_CUSTOMER')">
                                        <c:if test="${productService.checkExistLike(product.id, pageContext.session.getAttribute('currentCustomer').getId()) == 0}">
                                            <a class='far fa-heart' style='font-size:24px;color: red' href="<c:url value="/product-detail/like"/>?id=${product.id}" ></a>
                                        </c:if>
                                        <c:if test="${productService.checkExistLike(product.id, pageContext.session.getAttribute('currentCustomer').getId()) != 0}">
                                            <a class="fas fa-heart" style="font-size: 24px; color: red" href="<c:url value="/product-detail/unlike"/>?id=${product.id}"></a>
                                        </c:if>
                                    </sec:authorize>
                                </sec:authorize>
                                <sec:authorize access="!isAuthenticated()">
                                    <a class='far fa-heart' style='font-size:40px;color: red' href="<c:url value="/login"/>"></a> 
                                </sec:authorize>
                                <spring:message code="label.liked"/>(${likes[0]})
                        <!--<i class="fa-regular fa-heart" style="font-size: 24px"></i> <spring:message code="label.liked"/> (${likes[0]})-->
                            </div>
                            <sec:authorize access="hasRole('ROLE_CUSTOMER')">
                                <div class="col text-right a-login mb-2 " style="cursor: pointer">
                                    <a data-bs-toggle="modal" data-bs-target="#reasonReport"><i class="far fa-flag" style="font-size: 24px"></i> <spring:message code="label.report"/></a>
                                </div>
                            </sec:authorize>
                        </sec:authorize>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <br>
                <div class="row product p-4" style="height: 677px;">
                    <div class="mt-4 mb-4">
                        <h3 class="text-uppercase">${product.name}</h3>
                        <c:if test="${countRating != 0}">
                            <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${avgRating}</span>
                        </c:if>
                        <c:if test="${countRating == 0}">
                            <span><i>(<spring:message code="label.not.rating"/>)</i></span>
                        </c:if>
<!--                        <div class="price d-flex flex-row align-items-center"> <span class="act-price"><span style="text-decoration: underline">đ</span><fmt:formatNumber value="${product.price}" maxFractionDigits="3" type="number"/></span>
                        
                        </div>-->

                        <div id="price" name="price" class="price d-flex flex-row align-items-center">
                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                <span id="vndPrice" name="vndPrice" class="text-danger">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${product.price}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                <span id="usdPrice" name="usdPrice"  class="text-danger">
                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(product.price)}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                        </div>
                        <!--                        <h3 class="text-uppercase">product.name</h3>
                                                <div class="price d-flex flex-row align-items-center"> <span class="act-price">$20</span>
                                                    <div class="ml-2"> <small class="dis-price"><span style="text-decoration: underline">đ</span>product.price</small> <span>40% OFF</span> </div>
                                                </div>-->
                    </div>
                    <div>
                        <h4><spring:message code="label.description"/></h4>
                        <p>${product.description}</p>
                    </div>
                    <!--                    <div class="sizes mt-5">
                                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                                        </div>-->
                    <c:if test="${product.isDelete == 0 && product.adminBan == 0}">
                        <div class="cart mt-4 align-items-center">
                            <c:choose>
                                <c:when test="${product.quantity != 0}">    
                                    <h6><spring:message code="label.only"/> ${product.quantity} <spring:message code="label.product.left"/></h6>
                                    <sec:authorize access="!isAuthenticated()">
                                        <a class="btn btn-dark text-uppercase mr-2 px-4" href="javascript:;" class="btn btn-warning" onclick="addProductIntoCart(${product.id}, '${seller.id}', '${product.name}', '${product.imageCollection.get(0).image}', ${product.price})"><spring:message code="label.add.to.cart"/></a>
                                        <a class="btn btn-dark text-uppercase mr-2 px-4" class="btn btn-warning" href="<c:url value="/login"/>"><spring:message code="label.buy.now"/></a>
                                    </sec:authorize>
                                    <sec:authorize access="isAuthenticated()">
                                        <sec:authorize access="hasRole('ROLE_CUSTOMER')">
                                            <div class="d-flex">
                                                <a class="btn btn-dark text-uppercase mr-2 px-4" href="javascript:;" class="btn btn-warning" onclick="addProductIntoCart(${product.id}, '${seller.id}', '${product.name}', '${product.imageCollection.get(0).image}', ${product.price})"><spring:message code="label.add.to.cart"/></a>
                                                <a data-bs-toggle="modal" data-bs-target="#buyNowModal" class="btn btn-dark text-uppercase mr-2 px-4"><spring:message code="label.buy.now"/></a>
                                            </div>
                                        </sec:authorize>
                                    </sec:authorize>                        
                                </c:when>       
                                <c:otherwise>
                                    <h1 style="border:3px solid rgb(255, 0, 0);color:rgb(255, 0, 0);" align="center"><spring:message code="label.out.product"/></h1>                           
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
            </div>
            <c:if test="${buyALotSeller.size() != 0}">
                <div class="row center pt-3">
                    <h1><spring:message code="label.top.sell"/></h1>
                </div>
                <c:forEach items="${buyALotSeller}" var="p">
                    <div class="col-md-3 col-sm-6">
                        <div class="white-box mt-3">
                            <div class="product-img">
                                <img src="${p[3].imageCollection.get(0).image}">
                            </div>
                            <div class="product-bottom">
                                <div class="product-name">${p[1]}</div>
                                <div class="price">
                                    <c:if test="${pageContext.response.locale.language == 'vi'}">
                                        <span id="vndPrice" name="vndPrice" class="text-danger">
                                            <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p[2]}" maxFractionDigits="3" type="number"/>
                                        </span>
                                    </c:if>
                                    <c:if test="${pageContext.response.locale.language == 'en'}">
                                        <span id="usdPrice" name="usdPrice"  class="text-danger">
                                            <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(p[2])}" maxFractionDigits="3" type="number"/>
                                        </span>
                                    </c:if>
                                </div>
                                <a class="blue-btn"" href="<c:url value="/product-detail/${p[0]}"/>"><spring:message code="label.product.see.detail"/></a>
                                <div class="pt-4"><span class="text-danger"><spring:message code="label.number.sale"/>: ${p[4]}</span></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div class="p-4 m-4 bg-light">
        <div class="row align-items-center">
            <div class="col-12 col-lg-1">
                <div class="product-img-2">
                    <img class="rounded-circle img-fluid" src="${seller.avatar}">
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <h4>${seller.name}</h4>
                <c:if test="${sellerRating != 0}">
                    <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${sellerRating}/5</span> <br>
                </c:if>
                <c:if test="${sellerRating == 0}">
                    <span><i>(<spring:message code="label.not.rating"/>)</i></span> <br>
                </c:if>
                <a href="#" class="btn btn-dark"><spring:message code="label.chat"/></a>
                <a class="btn btn-info" href="<c:url value="/seller-detail/${seller.id}"/>"><spring:message code="label.see.shop"/></a>
            </div>
            <div class="col-6 col-lg-4 center">
                <h5><i class="fa-solid fa-location-dot"></i> ${seller.idLocation.name}</h5>
                <span><spring:message code="label.address"/></span>
            </div>
            <div class="col-6 col-lg-4 center">
                <h5><i class="fa-solid fa-box"></i> ${general[2]}</h5>
                <span><spring:message code="label.product"/></span>
            </div>
        </div>
    </div>
    <h3 class="text-uppercase"><spring:message code="label.product.review"/></h3>
    <c:if test="${countRating != 0}">
        <div class="py-2">
            <span><label style="color: yellow; font-size: 20px">&#9733;</label> ${avgRating}/5</span><span>(${countRating} <spring:message code="label.review"/>)</span>
        </div>
    </c:if>
    <c:if test="${countRating == 0}">
        <div class="py-2">
            <span><i>(<spring:message code="label.not.rating"/>)</i></span>
        </div>
    </c:if>
    <c:url value="/api/product/${product.id}/review" var="endpoint"/>
    <sec:authorize access="isAuthenticated()">
        <sec:authorize access="hasRole('ROLE_CUSTOMER')">
            <div class="row mt-4 mb-4">
                <h4><spring:message code="label.write.review"/></h4>
                <div class="row mt-4"> 
                    <div class="user d-flex">
                        <img class="rounded-circle img-fluid" src="${pageContext.session.getAttribute('currentCustomer').getAvatar()}"><h6 class="mx-2">${pageContext.request.userPrincipal.name}</h6>
                        <span class="mx-2"><i class="fa fa-clock-o" aria-hidden="true"></i><span class="mx-2" id="clock"></span></span>
                        <span class="mx-2"><i class="fa fa-calendar-o" aria-hidden="true"></i><span class="mx-2" id="calendar"></span></span>
                    </div>
                </div>
                <div id="rating">
                    <input type="radio" id="rate1" name="rating" value="1" />
                    <label for="rate1" >&#9733;</label>

                    <input type="radio" id="rate2" name="rating" value="2" />
                    <label for="rate2" >&#9733;</label>

                    <input type="radio" id="rate3" name="rating" value="3" />
                    <label for="rate3" >&#9733;</label>

                    <input type="radio" id="rate4" name="rating" value="4" />
                    <label for="rate4" >&#9733;</label>

                    <input type="radio" id="rate5" name="rating" value="5" />
                    <label for="rate5" >&#9733;</label>

                </div>
                <div class="d-flex flex-row">
                    <textarea type="text" id="inputReview" class="form-control mr-3" placeholder='<spring:message code="label.enter.review"/>!!!'></textarea>
                    <input onclick="chkAndAddReview(${productService.checkPermissionAddReview(product.id)}, ${productService.checkExistReview(product.id, pageContext.session.getAttribute('current').getId())})" class="btn btn-primary text-light" type="submit" value="<spring:message code="label.done"/>"/>
                </div>
            </div>
        </sec:authorize>
        <sec:authorize access="!hasRole('ROLE_CUSTOMER')">
            <div  class="center text-danger">
                <h4 class="text-uppercase"><spring:message code="label.no.right.to.review"/>!!! </h4>
            </div>
        </sec:authorize>
    </sec:authorize>
    <sec:authorize access="!isAuthenticated()">
        <div>
            <h4 class="center text-uppercase"><spring:message code="label.please"/> <a href="<c:url value="/login"/>"><spring:message code="label.in"/></a> <spring:message code="label.to.rate"/>!!! </h4>
        </div>
    </sec:authorize>   
    <div id="review"></div>
    <c:url value="/product-detail/${product.id}/report" var="report" />
</div>
<div class="modal fade" id="reasonReport" tabindex="-1" aria-labelledby="reasonReport" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="reasonReport"><spring:message code="label.select.a.reason"/></h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form:form action="${report}" modelAttribute="report" method="post">
                <div class="modal-body">
                    <form:select path="reportDescription">
                        <form:option value="Sản phẩm bị cấm buôn bán" label="Sản phẩm bị cấm buôn bán"/>
                        <form:option value="Hàng giả, hàng nhái" label="Hàng giả, hàng nhái"/>
                        <form:option value="Sản phẩm không rõ nguồn gốc xuất xứ" label="Sản phẩm không rõ nguồn gốc xuất xứ"/>
                        <form:option value="Hình ảnh sản phẩm không rõ ràng" label="Hình ảnh sản phẩm không rõ ràng"/>
                        <form:option value="Sản phẩm có hình ảnh, nội dung phản cảm" label="Sản phẩm có hình ảnh, nội dung phản cảm"/>
                        <form:option value="Sản phẩm có dấu hiệu lừa đảo" label="Sản phẩm có dấu hiệu lừa đảo"/>
                        <form:option value="Tên sản phẩm không phù hợp với hình ảnh sản phẩm" label="Tên sản phẩm không phù hợp với hình ảnh sản phẩm"/>
                        <form:option value="Sản phẩm có dấu hiệu tăng đơn ảo" label="Sản phẩm có dấu hiệu tăng đơn ảo"/>
                        <form:option value="Khác" label="Khác"/>
                    </form:select>
                </div>
                <div class="modal-footer">
                    <c:if test="${productService.checkExistReport(product.id,pageContext.session.getAttribute('currentCustomer').getId()) == 0}">
                        <button type="submit" class="btn btn-primary"><spring:message code="label.done"/></button>
                    </c:if>
                    <c:if test="${productService.checkExistReport(product.id,pageContext.session.getAttribute('currentCustomer').getId()) != 0}">
                        <a onclick="alert('Bạn đã tố cáo sản phẩm này rồi')" class="btn btn-primary"><spring:message code="label.done"/></a>
                    </c:if>
                </div>
            </form:form>
        </div>
    </div>
</div>
<div class="modal fade" id="buyNowModal" tabindex="-1" aria-labelledby="buyNowModal" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="buyNowModal"><spring:message code="label.see.address.again"/></h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h5><spring:message code="label.customer.information"/></h5>
                <p for="fname"><i class="fa fa-user"></i> <spring:message code="label.customer.firstname"/></p>
                <input type="text" class="w-100" id="fname" name="firstname" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getName()}" disabled>

                <p for="email"><i class="fa fa-phone"></i> <spring:message code="label.phone"/></p>
                <input type="text" class="w-100" id="phone" name="phone" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getPhone()}" disabled>

                <p for="email"><i class="fa fa-envelope"></i> <spring:message code="label.email"/></p>
                <input type="text" class="w-100" id="email" name="email" value="${pageContext.session.getAttribute('currentCustomer').getEmail()}" disabled>

                <p for="adr"><i class="fa fa-address-card-o"></i> <spring:message code="label.address"/></p>

                <input type="text" class="w-100" id="adr" name="address" value="${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getAddress()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getWard()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getDistrict()}, ${shipAddress.findShipPriority(pageContext.session.getAttribute('currentCustomer')).getCity().getName()} " disabled > 

            </div>
            <div class="modal-footer">
                <c:url value="/product-detail/buyNow" var="buynow"/>
                <form action="${buynow}">
                    <input name="amount" value="${product.price}" hidden="true"/>
                    <input name="idProduct" value="${product.id}" hidden="true"/>
                    <button type="submit" class="btn btn-dark text-uppercase mr-2 px-4" class="btn btn-warning"><spring:message code="label.buy.now"/></button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script>
                            window.onload = function () {
                                loadReview('${endpoint}');
                            };
                            var today = new Date();
                            var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
                            var time = today.getHours() + ":" + today.getMinutes();

                            document.getElementById("clock").innerHTML = time;
                            document.getElementById("calendar").innerHTML = date;

                            function clickBuyNow(productId, sellerId, productName, productImg, productPrice) {
                                addProductIntoCart(productId, sellerId, productName, productImg, productPrice);
                                window.location.href = "http://localhost:8080/WebEcommerce/customer/checkout";
                            }
                            function chkAndAddReview(pCheckBuy, pCheckExist) {
                                let pCountAlert = 0;

                                // Kiem tra xem khach hang da mua san pham hay chua
                                if (pCheckBuy == 0) {
                                    alert("Vui lòng mua sản phẩm để có quyền đánh giá!");
                                    pCountAlert++;
                                }

                                // Kiem tra khach hang da danh gia san pham chua
                                if (pCheckExist != 0) {
                                    alert("Bạn đã đánh giá sản phẩm này rồi!");
                                    pCountAlert++;
                                }
                                console.log(pCountAlert);
                                if (pCountAlert == 0) {
                                    addReview('${endpoint}',${product.id});
                                    window.location.reload();
                                }
                            }

</script>