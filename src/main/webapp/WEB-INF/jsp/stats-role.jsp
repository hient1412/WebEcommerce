<%-- 
    Document   : stats-role
    Created on : Oct 4, 2022, 8:29:27 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="center p-4">
    <div class="col-md-12"><h2>THỐNG KÊ LOẠI TÀI KHOẢN</h2></div>
</div>
<div class="row pb-4">
    <div class="col-12 col-lg-5"> 
        <br>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th>Loại tài khoản</th>
                    <th>Số lượng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${countRole}" var="a">
                    <tr>
                        <td>${a[0]}</td>
                        <td>${a[1]}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
    </div>
    <div class="col-12 col-lg-7">
        <canvas id="myChart"></canvas>
    </div>
</div>
<script>
    window.onload = function () {
        
        let data = [];
        let label = [];

    <c:forEach items="${countRole}" var="a">
        data.push('${a[0]}');
        label.push(${a[1]});
    </c:forEach>
        
        statsRole(data,label);
    };
</script>