<%--
    Document   : personal
    Created on : Oct 18, 2022, 10:25:17 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="container">
    <c:if test="${ac.role == 'ROLE_ADMIN'}">
        <div class="row py-5">
            <div class="container">
                <div class="center border border-dark py-2">
                    <div class="mt-4 text-primary">
                        <h4>${ad.name}</h4>
                    </div>
                    <div>
                        <c:if test="${!ad.email.isEmpty() == true}">
                            <p><spring:message code="label.email"/>: ${ad.email}</p>
                        </c:if>
                    </div>
                    <div>
                        <c:if test="${!ad.phone.isEmpty() == true}">
                            <p><spring:message code="label.phone"/>: ${ad.phone}</p>
                        </c:if>
                    </div>
                    <div>
                        <div >
                            <p><spring:message code="label.gender"/>: ${ad.gender}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:choose>
            <c:when test="${ac.role == 'ROLE_CUSTOMER'}">
                <div class="row mb-5">
                    <div class="col-lg-5 mb-5 mb-lg-0 bg-light mt-5">
                        <div class="ml-3 p-3" style="font-size: 20px">
                            <div class="mt-4 text-primary">
                                <h4>${cus.lastName} ${cus.firstName}</h4>
                            </div>
                            <div >
                                <c:if test="${!cus.email.isEmpty() == true}">
                                    <h5><spring:message code="label.email"/></h5><p>${cus.email}</p>
                                </c:if>
                            </div>
                            <div >
                                <c:if test="${!cus.phone.isEmpty() == true}">
                                    <h5><spring:message code="label.phone"/></h5><p>${cus.phone}</p>
                                </c:if>
                            </div>
                            <div >
                                <h5><spring:message code="label.hometown"/></h5><p>${cus.location.name}</p>
                            </div>
                            <div>
                                <h5><spring:message code="label.dob"/></h5><p><fmt:formatDate value="${cus.dob}" type="date" pattern="dd-MM-yyyy"/></p>
                            </div>
                            <div >
                                <h5><spring:message code="label.gender"/></h5><p>${cus.gender}</p>
                            </div>
                            <div>
                                <c:if test="${!cus.description.isEmpty() == true}">
                                    <h5><spring:message code="label.description"/></h5><p style="word-break: break-all;"> ${cus.description}</p>
                                </c:if>
                            </div>
                        </c:when>
                        <c:when test="${ac.role == 'ROLE_SELLER'}">
                            <div class="row mb-5">
                                <div class="col-lg-5 mb-5 mb-lg-0 bg-light mt-5">
                                    <div class="ml-3 p-3" style="font-size: 20px">
                                        <div class="mt-4 text-primary">
                                            <h4>${sel.name}</h4>
                                        </div>
                                        <div>
                                            <h5><spring:message code="label.address"/>:</h5><p>${sel.address}</p>
                                        </div>
                                        <div>
                                            <h5><spring:message code="label.location"/>:</h5><p>${sel.idLocation.name}</p>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.email.isEmpty() == true}">
                                                <h5><spring:message code="label.email"/></h5><p>${sel.email}</p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.phone.isEmpty() == true}">
                                                <h5><spring:message code="label.phone"/></h5><p>${sel.phone}</p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.description.isEmpty() == true}">
                                                <h5><spring:message code="label.description"/></h5><p style="word-break: break-all;">${sel.description}</p>
                                            </c:if>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${ac.role == 'ROLE_CUSTOMER'}">
                                <div class="col-lg-7 mt-5">
                                    <img class="img-fluid" src="${cus.avatar}" />
                                </div>
                            </c:when>
                            <c:when test="${ac.role == 'ROLE_SELLER'}">
                                <div class="col-lg-7 mt-5">
                                    <img class="img-fluid" src="${sel.avatar}" />
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${errMessage != null}">
            <div class="text-danger" style="text-align: center; font-size: 20px; padding: 10px;">
                <p>${errMessage}</p>
            </div>
        </c:if>
    </div>
</div>