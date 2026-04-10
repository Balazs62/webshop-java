<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Adminisztráció - <c:out value="${not empty title ? title : 'Vezérlőpult'}" /></title>
    
    <%-- Bootstrap és Ikonok --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <%-- Ugyanazok a stílusfájlok a konzisztencia miatt --%>
    <link rel="stylesheet" href="<c:url value='/css/site.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/layout.css'/>" /> 
    
    <style>
        /* Admin-specifikus finomítások */
        .admin-badge {
            font-size: 0.7rem;
            vertical-align: middle;
            margin-left: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .navbar-admin {
            border-bottom: 2px solid #dc3545; /* Pirosas sáv jelzi az Admin módot */
        }
    </style>
</head>
<body>
    <header class="sticky-top">
        <%-- Navbar-glass és shadow-sm megtartva, hogy passzoljon a főoldalhoz --%>
        <nav class="navbar navbar-expand-sm navbar-light navbar-glass py-3 mb-4 bg-white navbar-admin shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand fs-4 fw-bold text-dark" href="<c:url value='/admin/dashboard'/>">
                    <i class="bi bi-shield-lock-fill text-danger me-2"></i>Admin Panel
                    <span class="badge bg-danger admin-badge">Rendszergazda</span>
                </a>
                
                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse"
                        data-bs-target=".navbar-collapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                    <ul class="navbar-nav flex-grow-1">
                        <%-- Itt maradhat üres, vagy tehetsz ide gyorslinkeket --%>
                    </ul>
                    
                    <ul class="navbar-nav align-items-center">
                        <%-- Admin profil adatok --%>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-dark fw-bold" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1 text-danger"></i>
                                <%-- Spring Security-vel kérjük le a nevet --%>
                                <sec:authentication property="principal.username" />
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="adminDropdown">
                                <li>
                                    <h6 class="dropdown-header">Adminisztrátor</h6>
                                </li>
								<li><a class="dropdown-item" href="<c:url value='/admin/profile'/>">
								    <i class="bi bi-gear me-2"></i>Beállítások
								</a>
								</li>
                                <li>
                                    <form action="<c:url value='/logout'/>" method="post" class="m-0">
                                        <button type="submit" class="dropdown-item text-danger">
                                            <i class="bi bi-box-arrow-right me-2"></i>Kijelentkezés
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container-fluid px-4">
        <main role="main" class="pb-3">