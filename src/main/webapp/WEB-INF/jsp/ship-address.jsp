<%-- 
    Document   : change-password
    Created on : Oct 25, 2022, 1:50:19 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-5">
    <div class="white-box">
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                ${errMessage}
            </div>
        </c:if>
        <h1 class="text-center">Danh sách địa chỉ của tôi</h1>
        <c:if test="${listShip == 0}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                Không có sẳn địa chỉ nào!!
            </div>
        </c:if>
        <c:if test="${listShip != 0}">
        <c:url value="/api/customer/${customerId}/address" var="endpoint"/>

        <div id="ship">

        </div>
        </c:if>
        <div class="form-group center mt-4">
            <a class="btn btn-link" href="<c:url value="/customer/ship-address-add"/>"><p><i class="fa-regular fa-square-plus"></i> Thêm địa chỉ khác</p></a>
        </div>
    </div>
</div>
<script>
    window.onload = function () {
        loadShipAddress('${endpoint}');
    };
</script>