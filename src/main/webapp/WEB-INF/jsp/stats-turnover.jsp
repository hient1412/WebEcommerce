<%-- 
    Document   : stats-turnover
    Created on : Oct 5, 2022, 1:54:14 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <div class="center p-4">
        <div class="col-md-12"><h2>THỐNG KÊ DOANH THU TỪNG SẢN PHẨM</h2></div>
    </div>

    <div class="m-4">
        <form action="">
            <div class="row">
            <div class="col form-group">
                <label for="kw">Từ khóa</label>
                <input type="text" autocomplete="off" class="form-control" id="kw" name="kw">
            </div>
            <div class="col form-group">
                <label for="fromDate">Từ ngày</label>
                <input type="date" class="form-control" id="fromDate" name="fromDate">
            </div>
            <div class="col form-group">
                <label for="toDate">Đến ngày</label>
                <input  type="date" class="form-control" id="toDate" name="toDate">
            </div>
            <div class="center">
                <input type="submit" value="Thực hiện"/>
            </div>
            </div>
        </form>
    </div>
    <div class="m-4">
        <canvas id="myChart"></canvas>
    </div>
    <div class="row pb-4 m-4">
        <br>
        <table class="table table-bordered center">
            <thead>
                <tr>
                    <th>Mã sản phẩm</th>
                    <th>Tên</th>
                    <th>Số tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${statsProduct}" var="s">
                    <tr>
                        <td>${s[0]}</td>
                        <td>${s[1]}</td>
                        <td><span style="text-decoration: underline">đ</span> <fmt:formatNumber value="${s[2]}" maxFractionDigits="3" type="number"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
    </div>
<script>
    window.onload = function () {

        let data = [];
        let label = [];

    <c:forEach items="${statsProduct}" var="a">
        data.push('${a[1]}');
        label.push(${a[2]});
    </c:forEach>

        statsProduct(data, label);
    };
</script>
