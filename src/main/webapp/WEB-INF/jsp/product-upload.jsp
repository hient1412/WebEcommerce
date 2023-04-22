<%-- 
    Document   : product-upload
    Created on : Sep 29, 2022, 3:32:32 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="label.description" var="description"/>
<div class="row container d-flex justify-content-center p-4">
    <div class="card">
        <div class="card-body">
            <h1 class="center text-uppercase"><spring:message code="label.upload.product"/></h1>
            <form:form action="" method="post" modelAttribute="product" enctype="multipart/form-data">
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
                    <div class="col-6 col-lg-4">
                        <label><spring:message code="label.quantity"/></label>
                        <form:input type="number" value="1" path="quantity" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col-6 col-lg-4">
                        <label><spring:message code="label.brand"/></label>
                        <form:input type="text" path="manufacturer" class="form-control" autocomplete="off"/>
                    </div>
                    <div class="col-12 col-lg-4">
                        <label><spring:message code="label.product.type"/></label>
                        <form:select class="form-control" path="idCategory">
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}"> ${c.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label><spring:message code="label.image"/></label>
                    <br>(<spring:message code="label.only.upload.image"/>)<span style="color: red">*</span><br>
                    <form:input type="file" accept="image/*, .jpg,.png" multiple="multiple" path="file" class="form-control" required="required"/>
                </div>
                <div>
                    <label><spring:message code="label.description"/></label>
                    <form:textarea type="text" autocomplete="off" class="form-control input-lg" path="description" placeholder="${description}"/>
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