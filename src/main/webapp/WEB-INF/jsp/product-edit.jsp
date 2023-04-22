<%-- 
    Document   : product-edit
    Created on : Sep 30, 2022, 12:04:15 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="label.description" var="description"/>
<c:url value="/seller/product-edit" var="action"/>
<div class="row container d-flex justify-content-center">
    <div class="card">
        <div class="card-body">
            <h1 class="center text-uppercase"><spring:message code="label.edit.product"/></h1>
            <form:form action="${action}" method="post" modelAttribute="product" accept-charset="utf-8" enctype="multipart/form-data">
                <form:input hidden="true" path="id" value="${product.id}"/>
                <div class="form-group row">
                    <div class="col">
                        <label><spring:message code="label.product.name"/></label>
                        <form:input type="text" path="name" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col">
                        <label><spring:message code="label.price"/></label>
                        <form:input type="number" path="price" class="form-control" autocomplete="off"/>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-6 col-lg-3">
                        <label><spring:message code="label.quantity"/></label>
                        <form:input type="number" path="quantity" class="form-control" autocomplete="off" required="required"/>
                    </div>
                    <div class="col-6 col-lg-3">
                        <label><spring:message code="label.brand"/></label>
                        <form:input type="text" path="manufacturer" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col-6 col-lg-3">
                        <label><spring:message code="label.product.type"/></label>
                        <form:select class="form-control" path="idCategory">
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}"> ${c.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-6 col-lg-3">
                        <label><spring:message code="label.active"/></label>
                        <form:select class="form-control" path="active">
                            <form:option value="1"> <spring:message code="label.un.hide"/></form:option>>
                            <form:option value="0"> <spring:message code="label.hide"/></form:option>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="image"><spring:message code="label.image"/></label>
                    <c:if test="${product.imageCollection.size() != 0}">
                        <br><spring:message code="label.previous.image"/>:<br><br>
                    </c:if>
                    <c:forEach items="${product.imageCollection}" var="p">
                        <c:if test="${p.image.startsWith('http')}">
                            <span class="ml-2"><img src="${p.image}" class="border border-dark" width="70" height="60" ></span>
                            </c:if>
                        </c:forEach>
                    <br><br>(<spring:message code="label.only.upload.image"/>)<span style="color: red">*</span>
                    <form:input type="file" accept="image/*, .jpg,.png"  multiple="multiple" path="file" id="image" class="form-control"/>
                </div>
                <div class="form-group">
                    <form:textarea type="text" autocomplete="off" class="form-control input-lg" path="description" placeholder='${description}'/>
                </div>
                <br>
                <div>
                    <button type="submit" class="btn btn-primary btn-lg btn-block"><spring:message code="label.done"/></button>
                </div>
            </form:form>
            <c:if test="${errMessage != null}">
                <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>
        </div>
    </div>
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