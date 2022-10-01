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
                    <div class="mt-4 mb-4"> <span class="text-uppercase text-muted brand">Orianz</span>
                        <h3 class="text-uppercase">${product.name}</h3>
                        <div class="price d-flex flex-row align-items-center"> <span class="act-price">$20</span>
                            <div class="ml-2"> <small class="dis-price"><span style="text-decoration: underline">đ</span><fmt:formatNumber value="${product.price}" maxFractionDigits="3" type="number"/></small> <span>40% OFF</span> </div>
                        </div>
                    </div>
                    <p class="about">${product.description}</p>
                    <!--                    <div class="sizes mt-5">
                                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                                        </div>-->
                    <div class="product-count">
                        <label for="quantity">Quantity</label>
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
                <div class="row center p-4 m-4">
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
    <div>
        <ul>
            <c:forEach begin="1" end="5" var="i">
                <li  title="Đánh giá" id="rating" class="d-inline rating" style="cursor: pointer; color: #ccc; font-size: 30px">&#9733;</li>
                </c:forEach>
        </ul>
    </div>
    <c:url value="/api/product/${product.id}/review" var="endpoint"/>
    <!--    <sec:authorize access="isAuthenticated()">
    -->           
    <div>
        <div class="d-flex flex-row add-comment-section mt-4 mb-4">
            <textarea type="text" id="inputReview" class="form-control mr-3" placeholder="Nhập bình luận"></textarea>
            <input onclick="addReview('${endpoint}',${product.id})" class="btn btn-primary" type="submit" value="Gửi bình luận"/>
        </div>
    </div>
    <!--
</sec:authorize>     
<sec:authorize access="!isAuthenticated()">
<div>
    <h4 class="center">VUI LÒNG <a href="<c:url value="/login"/>">ĐĂNG NHẬP</a> ĐỂ CÓ THỂ BÌNH LUẬN!!! </h4>
</div>
</sec:authorize>     

    -->
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

</script>