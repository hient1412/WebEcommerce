<%-- 
    Document   : stats-categories
    Created on : Oct 4, 2022, 7:21:50 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="center p-4">
    <div class="col-md-12"><h2>THỐNG KÊ THEO LOẠI SẢN PHẨM</h2></div>
</div>
<div class="row pb-4">
    <div class="col-md-5"> 
        <br>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th>Mã loại</th>
                    <th>Loại sản phẩm</th>
                    <th>Số lượng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${countcate}" var="c">
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