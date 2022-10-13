<%--
    Document   : product-detail
    Created on : Sep 25, 2022, 6:11:22 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <div class="price d-flex flex-row align-items-center"> <span class="act-price">$20</span>
                            <div class="ml-2"> <small class="dis-price"><span style="text-decoration: underline">đ</span><fmt:formatNumber value="${product.price}" maxFractionDigits="3" type="number"/></small> <span>40% OFF</span> </div>
                        </div>
                    </div>
                    <div>
                        <h4>Mô tả sản phẩm</h4>
                        <p>${product.description}</p>
                    </div>
                    <!--                    <div class="sizes mt-5">
                                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                                        </div>-->
                    <div class="product-count">
                        <label for="quantity">Số lượng</label>
                        <form action="# " style="display: flex;">
                            <div class="qtyminus">-</div>
                            <input type="number" id="quantity" value="1" class="qty" >
                            <div class="qtyplus">+</div>
                        </form>
                    </div>

                    <div class="cart mt-4 align-items-center">
                        <a class="btn btn-dark text-uppercase mr-2 px-4" href="javascript:;" class="btn btn-warning" onclick="addProductIntoCart(${product.id}, '${product.name}', ${product.price})">Thêm vào giỏ hàng</a>
                        <button class="btn btn-dark text-uppercase mr-2 px-4">Mua ngay</button>
                    </div>
                </div>
            </div>

            <c:if test="${buyALotSeller.size() != 0}">
                <div class="row center pt-3">
                    <h1>Top sản phẩm bán chạy</h1>
                </div>
                <c:forEach items="${buyALotSeller}" var="p">
                    <div class="col-md-3 col-sm-6">
                        <div class="white-box mt-3">
                            <div class="wishlist-icon">
                                <img src="https://pngimage.net/wp-content/uploads/2018/06/wishlist-icon-png-3.png"/>
                            </div>
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
        <div class="row">
            <div class="col-md-1">
                <div class="product-img-2">
                    <img class="rounded-circle img-fluid" src="data:image/png;base64,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">
                </div>
            </div>
            <div class="col-md-3">
                <h4>${seller.name}</h4>
                <a href="#" class="btn btn-dark">Nhắn tin</a>
                <a class="btn btn-info" href="<c:url value="/seller-detail/${seller.id}"/>">Xem shop</a>
            </div>
            <div class="col-md-4">
                <p>Đánh giá: </p>
                <p>Sản phẩm </p>
            </div>
            <div class="col-md-4">
                <p>Tham gia: </p>
                <p>Đã bán: </p>
            </div>
        </div>
    </div>
    <c:url value="/api/product/${product.id}/review" var="endpoint"/>
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
        <!--        <div id="rating">
                    <ul class="list-inline d-flex">
        <c:forEach begin="1" end="5">
            <li>&#9733;</li>
        </c:forEach>
</ul>
</div>-->
        <div class="d-flex flex-row">
            <textarea type="text" id="inputReview" class="form-control mr-3" placeholder="Nhập đánh giá"></textarea>
            <input onclick="addReview('${endpoint}',${product.id})" class="btn btn-primary text-light" type="submit" value="Gửi đánh giá"/>
        </div>
    </div>

</div>
<div id="review">

</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script>
                $(".qtyminus").on("click", function () {
                    var now = $(".qty").val();
                    if ($.isNumeric(now)) {
                        if (parseInt(now) - 1 > 0)
                        {
                            now--;
                        }
                        $(".qty").val(now);
                    }
                });
                $(".qtyplus").on("click", function () {
                    var now = $(".qty").val();
                    if ($.isNumeric(now)) {
                        $(".qty").val(parseInt(now) + 1);
                    }
                });
                window.onload = function () {
                    loadReview('${endpoint}');
                };
                var today = new Date();
                var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
                var time = today.getHours() + ":" + today.getMinutes();

                document.getElementById("clock").innerHTML = time;
                document.getElementById("calendar").innerHTML = date;

</script>