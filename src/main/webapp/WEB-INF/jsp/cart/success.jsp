<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="../shared/header.jsp" %>

<div class="container mt-5 mb-5 text-center d-flex flex-column justify-content-center align-items-center" style="min-height: 50vh;">
    
    <div class="mb-4">
        <i class="bi bi-check-circle-fill text-success shadow-sm rounded-circle bg-white" style="font-size: 6rem;"></i>
    </div>
    
    <h1 class="display-5 fw-bold text-dark mb-3">Sikeres rendelés!</h1>
    
    <p class="lead text-muted mb-5" style="max-width: 600px;">
        Köszönjük a vásárlást! A rendelésedet sikeresen rögzítettük a rendszerünkben. 
        A rendelésed állapotát bármikor nyomon követheted a profilodban.
    </p>
    
    <div class="d-flex gap-3 justify-content-center flex-wrap">
        <a href="<c:url value='/'/>" class="btn btn-outline-primary btn-lg px-4 py-2 shadow-sm rounded-pill fw-bold">
            <i class="bi bi-house-door me-2"></i>Vissza a főoldalra
        </a>
        
        <a href="<c:url value='/profile'/>" class="btn btn-primary btn-lg px-4 py-2 shadow-sm rounded-pill fw-bold">
            <i class="bi bi-person-lines-fill me-2"></i>Rendeléseim megtekintése
        </a>
    </div>

</div>

<%@ include file="../shared/footer.jsp" %>