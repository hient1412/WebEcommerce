<%--
    Document   : product-detail
    Created on : Sep 25, 2022, 6:11:22 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                </div>
            </div>
            <div class="col-md-6">
                <br>
                <div class="row product p-4" style="height: 635px;">
                    <div class="mt-4 mb-4">
                        <h3 class="text-uppercase">${product.name}</h3>
                        <c:if test="${countRating != 0}">
                            <span>${avgRating} <label style="color: yellow; font-size: 20px">&#9733;</label></span>
                        </c:if>
                        <c:if test="${countRating == 0}">
                            <span><i>(Chưa có lượt đánh giá)</i></span>
                        </c:if>
                        <div class="price d-flex flex-row align-items-center"> <span class="act-price"><span style="text-decoration: underline">đ</span><fmt:formatNumber value="${product.price}" maxFractionDigits="3" type="number"/></span>
                        </div>
                        <!--                        <h3 class="text-uppercase">product.name</h3>
                                                <div class="price d-flex flex-row align-items-center"> <span class="act-price">$20</span>
                                                    <div class="ml-2"> <small class="dis-price"><span style="text-decoration: underline">đ</span>product.price</small> <span>40% OFF</span> </div>
                                                </div>-->
                    </div>
                    <div>
                        <h4>Mô tả sản phẩm</h4>
                        <p>${product.description}</p>
                    </div>
                    <!--                    <div class="sizes mt-5">
                                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                                        </div>-->
                    <c:if test="${product.isDelete == 0}">
                        <div class="cart mt-4 align-items-center">
                            <a class="btn btn-dark text-uppercase mr-2 px-4" href="javascript:;" class="btn btn-warning" onclick="addProductIntoCart(${product.id}, '${seller.id}', '${product.name}', '${product.imageCollection.get(0).image}', ${product.price})">Thêm vào giỏ hàng</a>
                            <button class="btn btn-dark text-uppercase mr-2 px-4">Mua ngay</button>
                        </div>
                    </c:if>
                </div>
            </div>

            <c:if test="${buyALotSeller.size() != 0}">
                <div class="row center pt-3">
                    <h1>Top sản phẩm bán chạy</h1>
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
                                    <span style="text-decoration: underline">đ</span><fmt:formatNumber value="${p[2]}" maxFractionDigits="3" type="number"/>
                                </div>
                                <a class="blue-btn"" href="<c:url value="/product-detail/${p[0]}"/>">Xem chi tiết</a>
                                <div class="pt-4"><span class="text-danger">Số lượt bán: ${p[4]}</span></div>
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
                <a href="#" class="btn btn-dark">Nhắn tin</a>
                <a class="btn btn-info" href="<c:url value="/seller-detail/${seller.id}"/>">Xem shop</a>
            </div>
            <div class="col-6 col-lg-4 center">
                <h5><i class="fa fa-map-marker" aria-hidden="true"></i> ${seller.idLocation.name}</h5>
                <span>Địa chỉ</span>
            </div>
        </div>
    </div>
    <h3>ĐÁNH GIÁ SẢN PHẨM</h3>
    <c:if test="${countRating != 0}">
        <div class="py-2">
            <span>${avgRating}/5 <label style="color: yellow; font-size: 20px">&#9733;</label></span> <span>(${countRating} lượt đánh giá)</span>
        </div>
    </c:if>
    <c:if test="${countRating == 0}">
        <div class="py-2">
            <span><i>(Chưa có lượt đánh giá)</i></span>
        </div>
    </c:if>
    <c:url value="/api/product/${product.id}/review" var="endpoint"/>
    <sec:authorize access="isAuthenticated()">
        <sec:authorize access="hasRole('ROLE_CUSTOMER')">
            <div class="row mt-4 mb-4">
                <h4>Viết đánh giá của bạn</h4>
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
                    <textarea type="text" id="inputReview" class="form-control mr-3" placeholder="Nhập đánh giá"></textarea>
                    <input onclick="addReview('${endpoint}',${product.id})" class="btn btn-primary text-light" type="submit" value="Gửi đánh giá"/>
                </div>
            </div>

        </div>
    </sec:authorize>
    <sec:authorize access="!hasRole('ROLE_CUSTOMER')">
        <div  class="center text-danger">
            <h4>KHÔNG CÓ QUYỀN VIẾT ĐÁNH GIÁ!!! </h4>
        </div>
    </sec:authorize>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <div>
        <h4 class="center">VUI LÒNG <a href="<c:url value="/login"/>">ĐĂNG NHẬP</a> ĐỂ CÓ THỂ ĐÁNH GIÁ!!! </h4>
    </div>
</sec:authorize>     
<div id="review">

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
</script>