<%-- 
    Document   : admin-stats-cate
    Created on : Oct 17, 2022, 3:57:07 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="center p-4">
    <div class="col-md-12"><h2 class="text-uppercase"><spring:message code="label.stats.product"/></h2></div>
</div>
<c:if test="${countAdminProCate.size() == 0}">
    <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
        <spring:message code="label.no.data"/>
    </div>
</c:if>
<c:if test="${countAdminProCate.size() != 0}">
    <div class="row pb-4">
        <div class="col-md-5"> 
            <br>
            <table class="table table-bordered center">
                <thead>
                    <tr>
                        <th><spring:message code="label.type.id"/></th>
                        <th><spring:message code="label.product.type"/></th>
                        <th><spring:message code="label.quantity"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${countAdminProCate}" var="c">
                        <tr>
                            <td>${c[0]}</td>
                            <td>${c[1]}</td>
                            <td>${c[2]}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table> 
        </div>
        <div class="col-md-7">
            <canvas id="myChart"></canvas>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="<c:url value="/js/stats.js"/>"></script>
<script>
    window.onload = function () {
        let data = [];
        let label = [];

    <c:forEach items="${countAdminProCate}" var="c">
        data.push(${c[2]});
        label.push('${c[1]}');
    </c:forEach>

        adminStatsCategories(label, data);
    };
</script>