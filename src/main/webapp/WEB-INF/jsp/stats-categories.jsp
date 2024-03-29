<%-- 
    Document   : stats-categories
    Created on : Oct 4, 2022, 7:21:50 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="center p-4">
    <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.stats.product"/></h2></div>
</div>
<c:if test="${countcate.size() == 0}">
    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
        <spring:message code="label.no.data"/>
    </div>
</c:if>
<c:if test="${countcate.size() != 0}">
    <div class="row pb-4 justify-content-center">
        <div class="col-md-8">
            <canvas id="myChart"></canvas>
        </div>
    </div>
    <div class="col-md-12"> 
        <br>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th><spring:message code="label.type.id"/></th>
                    <th><spring:message code="label.product.type"/></th>
                    <th><spring:message code="label.quantity"/></th>
                    <th><spring:message code="label.price"/></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${countcate}" var="c">
                    <tr>
                        <td>${c[0]}</td>
                        <td>${c[1]}</td>
                        <td>${c[2]}</td>
                        <td>
                            <c:if test="${pageContext.response.locale.language == 'vi'}">
                                <span id="vndPrice" name="vndPrice">
                                    <span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${c[3]}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                            <c:if test="${pageContext.response.locale.language == 'en'}">
                                <span id="usdPrice" name="usdPrice" >
                                    <span>$</span> <fmt:formatNumber value="${pUsdPriceOfProduct.convertCurrency(c[3])}" maxFractionDigits="3" type="number"/>
                                </span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
    </div>
</c:if>
<c:if test="${seller.idAccount.active == 0}">
    <a id="aclick" href="<c:url value="/access-denied"/>"></a>
</c:if>
<script>
    setTimeout(locate, 0)
    function locate() {
        document.getElementById("aclick").click();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="<c:url value="/js/stats.js"/>"></script>
<script>
    window.onload = function () {
        let data = [];
        let label = [];

    <c:forEach items="${countcate}" var="c">
        data.push(${c[2]});
        label.push('${c[1]}');
    </c:forEach>

        statsCategories(label, data);
    };
</script>