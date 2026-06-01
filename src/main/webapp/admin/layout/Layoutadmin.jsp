<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty root}">
    <c:set var="root" value="${pageContext.request.contextPath}" scope="request"/>
</c:if>

<div class="admin-container">
    <!-- ===== SIDEBAR ===== -->
    <%@ include file="/admin/layout/admin-sidebar.jsp" %>

    <!-- ===== MAIN CONTENT ===== -->
    <div class="admin-main">
        <!-- ===== HEADER ===== -->
        <%@ include file="/admin/layout/admin-header.jsp" %>

<%--        <main class="admin-content">    --%>