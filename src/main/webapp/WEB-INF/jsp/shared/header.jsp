<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <%-- Dinamikus címke: ha nincs megadva 'title', akkor csak Webshop --%>
    <title><c:out value="${not empty title ? title : 'Kezdőlap'}" /> - Webshop</title>
    
    <%-- Statikus erőforrások JSP-s elérése --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="<c:url value='/css/site.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/layout.css'/>" /> 
</head>
<body>
    <header class="sticky-top">
        <nav class="navbar navbar-expand-sm navbar-light navbar-glass py-3 mb-4 bg-white border-bottom shadow-sm">
            <div class="container">
                <a class="navbar-brand fs-4 fw-bold text-primary" href="<c:url value='/'/>">
                    <i class="bi bi-bag-heart-fill me-2"></i>Webshop
                </a>
                
                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse"
                        data-bs-target=".navbar-collapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                    <ul class="navbar-nav flex-grow-1 ms-4">
                        <li class="nav-item">
                            <a class="nav-link px-3 fw-medium" href="<c:url value='/'/>">Kínálat</a>
                        </li>
                    </ul>
                    
                    <ul class="navbar-nav align-items-center">
                        
                        <li class="nav-item me-3">
                            <a class="nav-link position-relative" href="<c:url value='/cart/view'/>">
                                <i class="bi bi-cart3 fs-5"></i> 
                                <span class="ms-1">Kosár</span>
								<span id="cart-count-badge" 
								      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
								      style="font-size: 0.65rem; transition: transform 0.2s; ${ (empty sessionScope.cartCount or sessionScope.cartCount == 0) ? 'display: none;' : 'display: inline-block;' }">
								    <c:out value="${not empty sessionScope.cartCount ? sessionScope.cartCount : '0'}" />
								</span>
                            </a>
                        </li>

                        <c:choose>
                            <c:when test="${not empty sessionScope.username}">
                                <li class="nav-item me-3">
                                    <a class="nav-link text-primary fw-bold" href="<c:url value='/account/profile'/>">
                                        <i class="bi bi-person-circle me-1"></i>
                                        <c:out value="${sessionScope.username}" />
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
								    <c:when test="${not empty sessionScope.user}">
								        <li class="nav-item dropdown me-3">
								            <a class="nav-link dropdown-toggle text-primary fw-bold" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								                <i class="bi bi-person-circle me-1"></i>
								                <c:out value="${sessionScope.user.username}" />
								            </a>
								            <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="navbarDropdown">
								                <li><a class="dropdown-item" href="<c:url value='/profile'/>"><i class="bi bi-person me-2"></i>Profilom</a></li>
								                <li><a class="dropdown-item" href="<c:url value='/my-orders'/>"><i class="bi bi-receipt me-2"></i>Rendeléseim</a></li>
								                <li><hr class="dropdown-divider"></li>
								                <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Kijelentkezés</a></li>
								            </ul>
								        </li>
								    </c:when>
								    
								    <c:otherwise>
								        <li class="nav-item ms-2">
								            <a class="btn btn-primary rounded-pill px-4" href="<c:url value='/login'/>">Bejelentkezés</a>
								        </li>
								        <li class="nav-item ms-2">
								            <a class="btn btn-primary rounded-pill px-4" href="<c:url value='/register'/>">Regisztráció</a>
								        </li>
								    </c:otherwise>
								</c:choose>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container">
        <main role="main" class="pb-3">