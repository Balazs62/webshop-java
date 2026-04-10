<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark" style="width: 100%; min-height: 100vh;">
    <a href="<c:url value='/admin/dashboard'/>" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="bi bi-shield-lock-fill me-2"></i>
        <span class="fs-4">Admin Panel</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="<c:url value='/admin/dashboard'/>" class="nav-link text-white">
                <i class="bi bi-speedometer2 me-2"></i> Vezérlőpult
            </a>
        </li>
        <li>
            <a href="<c:url value='/admin/orders/list'/>" class="nav-link text-white">
                <i class="bi bi-cart-check me-2"></i> Rendelések
            </a>
        </li>
        <li>
            <a href="<c:url value='/admin/products/list'/>" class="nav-link text-white">
                <i class="bi bi-tags me-2"></i> Termékek
            </a>
        </li>
        <li>
            <a href="<c:url value='/admin/users/list'/>" class="nav-link text-white">
                <i class="bi bi-people me-2"></i> Felhasználók
            </a>
        </li>
    </ul>
    <hr>
</div>