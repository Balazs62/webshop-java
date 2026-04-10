<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="shared/admin-header.jsp" %>

<div class="container py-4">
    <div class="row">
        <div class="col-12 mb-4">
            <h2 class="fw-bold"><i class="bi bi-person-gear me-2"></i>Adminisztrátori beállítások</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<c:url value='/admin/dashboard'/>">Vezérlőpult</a></li>
                    <li class="breadcrumb-item active">Profil</li>
                </ol>
            </nav>
        </div>

        <%-- Értesítések --%>
        <div class="col-12">
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show">
                    <i class="bi bi-check-circle-fill me-2"></i>A profilod sikeresen frissült!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger border-0 shadow-sm">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'emailTaken'}">Ez az email cím már használatban van!</c:when>
                        <c:when test="${param.error == 'wrongCurrentPassword'}">A jelenlegi jelszó nem megfelelő!</c:when>
                        <c:when test="${param.error == 'passwordMismatch'}">Az új jelszavak nem egyeznek!</c:when>
                        <c:otherwise>Hiba történt a mentés során!</c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <%-- Adatok kártya --%>
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 text-center p-4 mb-4">
                <div class="py-3">
                    <i class="bi bi-shield-check text-danger" style="font-size: 4rem;"></i>
                    <h4 class="mt-3 mb-0">${user.username}</h4>
                    <span class="badge bg-danger-subtle text-danger rounded-pill mt-2">Rendszergazda</span>
                </div>
                <hr>
                <div class="text-start small text-muted">
                    <p class="mb-1"><strong>Regisztrálva:</strong> ${user.createdDate}</p>
                    <p class="mb-0"><strong>Email:</strong> ${user.email}</p>
                </div>
            </div>
        </div>

        <%-- Szerkesztés kártya --%>
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 pt-2">
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/profile/update'/>" method="post">
                        
                        <h5 class="card-title mb-4 border-bottom pb-2">Alapadatok</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Felhasználónév</label>
                                <input type="text" class="form-control bg-light" value="${user.username}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Email cím</label>
                                <input type="email" name="email" class="form-control" value="${user.email}" required>
                            </div>
                        </div>

                        <h5 class="card-title mt-5 mb-4 border-bottom pb-2 text-danger">Biztonság</h5>
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-semibold small">Jelenlegi jelszó</label>
                                <input type="password" name="currentPassword" class="form-control" placeholder="Add meg a módosításhoz">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Új jelszó</label>
                                <input type="password" name="newPassword" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Új jelszó megerősítése</label>
                                <input type="password" name="confirmPassword" class="form-control">
                            </div>
                        </div>

                        <div class="mt-5 d-flex justify-content-between align-items-center">
                            <span class="text-muted small italic">* A változtatások érvényesítéséhez újra be kell jelentkezned.</span>
                            <button type="submit" class="btn btn-danger rounded-pill px-5 shadow-sm">
                                <i class="bi bi-save me-2"></i>Mentés
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="shared/admin-footer.jsp" %>