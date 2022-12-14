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
<div class="container">
    <c:if test="${ac.role == 'ROLE_ADMIN'}">
        <div class="row">
            <div class="container">
                <div class="center">
                    <div class="mt-4 text-primary">
                        <h4>${ad.name}</h4>
                    </div>
                    <div>
                        <c:if test="${!ad.email.isEmpty() == true}">
                            <p>Email: ${ad.email} </p>
                        </c:if>
                    </div>
                    <div>
                        <c:if test="${!ad.phone.isEmpty() == true}">
                            <p>Số điện thoại: ${ad.phone} </p>
                        </c:if>
                    </div>
                    <div>
                        <div >
                            <p>Giới tính: ${ad.gender} </p>
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
                                    <p><h5>Email</h5> ${cus.email} </p>
                                </c:if>
                            </div>
                            <div >
                                <c:if test="${!cus.phone.isEmpty() == true}">
                                    <p><h5>Số điện thoại</h5> ${cus.phone} </p>
                                </c:if>
                            </div>
                            <div >
                                <p><h5>Quê quán</h5> ${cus.location.name} </p>
                            </div>
                            <div>
                                <p><h5>Ngày sinh</h5> <fmt:formatDate value="${cus.dob}" type="date" pattern="dd-MM-yyyy"/> </p>
                            </div>
                            <div >
                                <p><h5>Giới tính</h5> ${cus.gender} </p>
                            </div>
                            <div>
                                <c:if test="${!cus.description.isEmpty() == true}">
                                    <p><h5>Mô tả chi tiết</h5> ${cus.description} </p>
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
                                            <p><h5>Địa chỉ:</h5> ${sel.address}</p>
                                        </div>
                                        <div>
                                            <p><h5>Nơi bán:</h5>${sel.idLocation.name}</p>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.email.isEmpty() == true}">
                                                <p><h5>Email</h5> ${sel.email} </p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.phone.isEmpty() == true}">
                                                <p><h5>Số điện thoại</h5> ${sel.phone} </p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <c:if test="${!sel.description.isEmpty() == true}">
                                                <p><h5>Mô tả chi tiết</h5> ${sel.description} </p>
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