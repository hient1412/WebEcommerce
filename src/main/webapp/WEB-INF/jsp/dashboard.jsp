<%-- 
    Document   : dashboard
    Created on : Oct 4, 2022, 10:58:22 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${seller.idAccount.active == 0}">
    <a id="aclick" href="<c:url value="/access-denied"/>"></a>
</c:if>
<script>
setTimeout(locate,0)
function locate() {
    document.getElementById("aclick").click();
}
</script>
