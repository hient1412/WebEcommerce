<%-- 
    Document   : list-product-upload
    Created on : Sep 29, 2022, 4:26:19 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<c:if test="${errMessage != 'Chưa có sản phẩm'}">
    <c:if test="${errMessage != null}">
        <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
            ${errMessage}
        </div>
    </c:if>
</c:if>
<spring:message code="label.no.product" var="noProduct"/>
<div>
    <h1 class="center p-4"><spring:message code="label.search"/></h1>
    <div class="p-4" style="background-color: #ccc">
        <form action="" >
            <div class="row row-cols-1 row-cols-md-2 row-cols-sm-2">
                <div class="col">
                    <label><spring:message code="label.keyword"/></label>
                    <input class="w-50" type="text" name="kw" autocomplete="off"/>
                </div>
                <div class="col">
                    <label><spring:message code="label.quantity"/></label>
                    <input class="w-25" type="number" name="quantityMin" placeholder="Min"/>
                    <label>-</label>
                    <input class="w-25" type="number" name="quantityMax" placeholder="Max"/>
                </div>
                <div class="col">
                    <label for="cat"><spring:message code="label.product.type"/></label>
                    <select id="cat"name="cat">
                        <option value="" selected><spring:message code="label.no.selected"/></option>
                        <c:forEach items="${cateBySeller}" var="c">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col">
                    <label for="active"><spring:message code="label.active"/></label>
                    <select id="active"name="active">
                        <option value="" selected><spring:message code="label.all"/></option>
                        <option value="1"><spring:message code="label.normal"/></option>
                        <option value="0"><spring:message code="label.hidden"/></option>
                    </select>
                </div>
                <div class="col">
                    <label for="adminBan"><spring:message code="label.product.violate"/></label>
                    <select id="adminBan" name="adminBan">
                        <option value="" selected><spring:message code="label.no.selected"/></option>
                        <option value="1"><spring:message code="label.product.violated"/></option>
                        <option value="0"><spring:message code="label.product.not.violated"/></option>
                    </select>
                </div>
            </div>
            <div class="center"> 
                <input type="submit" class="mt-4 p-1" value='<spring:message code="label.search"/>'/>
                <input type="button" class="p-1" onclick="clearFilter()" value='<spring:message code="label.clear"/>'/>
            </div>
        </form>
    </div>
</div>

<div>
    <c:choose>
        <c:when test="${product.size() != 0}">
            <c:if test="${errMessage == 'Chưa có sản phẩm'}">
                <h3 class="center p-3">
                    <i class="text-danger">${noProduct}</i>
                </h3>
            </c:if>
            <c:if test="${errMessage != 'Chưa có sản phẩm'}">
                <div class="product-list">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3">
                        <c:forEach items="${product}" var="p">
                            <div class="col">
                                <div class="white-box mt-3">
                                    <div class="product-img">
                                        <img src="${p.imageCollection.get(0).image}">
                                    </div>
                                    <div class="product-bottom">
                                        <div class="product-name">${p.name}
                                            <c:if test="${p.active == 0}">
                                                <div class="text-primary" ><h6><spring:message code="label.active"/>: <spring:message code="label.hidden"/> </h6></div>
                                            </c:if></div>
                                        <div><h6><spring:message code="label.product.type"/>: ${p.idCategory.name}</h6></div>
                                        <div class="price">
                                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                                <span id="vndPrice" name="vndPrice">
                                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${p.price}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                                <span id="usdPrice" name="usdPrice" >
                                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(p.price)}" maxFractionDigits="3" type="number"/>
                                                </span>
                                            </c:if>
                                        </div>
                                        <a class="blue-btn"" href="<c:url value="/product-detail/${p.id}"/>"><spring:message code="label.product.see.detail"/></a>
                                    </div>
                                    <div class="row mt-3 center">
                                        <c:if test="${p.adminBan == 0}">
                                            <p><br></p>
                                            </c:if>
                                            <c:if test="${p.adminBan == 1}">
                                            <p  class="text-white bg-danger"><spring:message code="label.product.violated"/></p>
                                        </c:if>
                                    </div>
                                    <div class="row mt-3 center">
                                        <div class="col">
                                            <a title='<spring:message code="label.edit"/>' href="<c:url value="/seller/product-edit"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa-regular fa-pen-to-square"></i><br><spring:message code="label.edit"/> </a>
                                        </div>
                                        <div class="col">
                                            <c:if test="${p.active == '1'}">
                                                <a title='<spring:message code="label.hide"/>' href="<c:url value="/seller/product-hide"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-eye-slash" aria-hidden="true"></i><br><spring:message code="label.hide"/></a>
                                                </c:if>
                                                <c:if test="${p.active == '0'}">
                                                <a title='<spring:message code="label.un.hide"/>' href="<c:url value="/seller/product-show"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-eye" aria-hidden="true"></i><br><spring:message code="label.un.hide"/></a>
                                                </c:if>
                                        </div>
                                        <div class="col">
                                            <a title='<spring:message code="label.delete"/>' href="<c:url value="/seller/product-delete"/>?id=${p.id}" data-toggle="tooltip" class="text-primary"><i class="fa fa-trash" aria-hidden="true"></i><br><spring:message code="label.delete"/></a>
                                        </div>
                                    </div>

                                </div>
                            </div> 
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="pagination justify-content-center mt-4">
                        <ul class="pagination">
                            <c:forEach begin="1" end="${Math.ceil(counterS/count)}" var="i">
                                <li onclick="paginationClick('page', ${i})" class="page-item"><a class="page-link">${i}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>    
            </c:if>
        </c:when>
        <c:when test="${product.size() == 0}">
            <h3 class="center p-3">
                <i class="text-danger"><spring:message code="label.no.product"/></i>
            </h3>
        </c:when>
    </c:choose>
</div>
<c:if test="${seller.idAccount.active == 0}">
    <a id="aclick" href="<c:url value="/access-denied"/>"></a>
</c:if>
<script>
    setTimeout(locate, 0)
    function locate() {
        document.getElementById("aclick").click();
    }
</script>
<script>
    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "") {
                    $(obj).removeAttr("name");
                }
            });
        });
    });
</script>