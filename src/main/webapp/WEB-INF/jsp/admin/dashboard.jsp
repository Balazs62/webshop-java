<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Admin fejléc --%>
<%@ include file="shared/admin-header.jsp" %>

<div class="container-fluid p-0">
    <div class="row g-0">
        
        <%-- BAL OLDAL: SIDEBAR (Sötét marad a kontraszt miatt) --%>
        <div class="col-md-3 col-lg-2">
            <%@ include file="shared/sidebar.jsp" %>
        </div>

        <%-- JOBB OLDAL: FŐ TARTALOM --%>
        <main class="col-md-9 col-lg-10 px-md-4 py-4 bg-light min-vh-100">
            
            <%-- Minimalista fejléc rész --%>
            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                <div>
                    <h4 class="fw-bold text-dark mb-1">Vezérlőpult</h4>
                    <span class="text-muted small">Üdv, <c:out value="${adminName}"/> • <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy. MMMM d." /></span>
                </div>
                <div class="d-flex align-items-center bg-white border rounded-pill px-3 py-1 shadow-sm">
                    <div class="spinner-grow spinner-grow-sm text-success me-2" style="width: 8px; height: 8px;"></div>
                    <small class="fw-bold text-secondary">${liveUsers} aktív látogató</small>
                </div>
            </div>

            <%-- Letisztult Statisztikai kártyák --%>
            <div class="row g-3">
                
                <%-- Kártya: Bevétel --%>
                <div class="col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 bg-light p-3 rounded-3">
                                    <i class="bi bi-wallet2 text-dark fs-4"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-muted small mb-1 uppercase fw-medium">Összes bevétel</p>
                                    <h5 class="mb-0 fw-bold">
                                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="Ft" maxFractionDigits="0"/>
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Kártya: Rendelések --%>
                <div class="col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 bg-light p-3 rounded-3">
                                    <i class="bi bi-bag-check text-dark fs-4"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-muted small mb-1 uppercase fw-medium">Rendelések</p>
                                    <h5 class="mb-0 fw-bold">${totalOrders} db</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Kártya: Felhasználók --%>
                <div class="col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 bg-light p-3 rounded-3">
                                    <i class="bi bi-person text-dark fs-4"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-muted small mb-1 uppercase fw-medium">Vásárlók</p>
                                    <h5 class="mb-0 fw-bold">${totalUsers} fő</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Kártya: Termékek --%>
                <div class="col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 bg-light p-3 rounded-3">
                                    <i class="bi bi-box-seam text-dark fs-4"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-muted small mb-1 uppercase fw-medium">Termékek</p>
                                    <h5 class="mb-0 fw-bold">${totalProducts} db</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <%-- Gyors gombok - Szintén letisztult stílusban --%>
            <div class="mt-5">
                <h6 class="text-muted fw-bold mb-3 small">GYORS MŰVELETEK</h6>
                <div class="d-flex gap-2">
                    <a href="<c:url value='/admin/products/list'/>" class="btn btn-white border shadow-sm px-4 py-2 rounded-3 text-dark">
                        <i class="bi bi-plus-lg me-2"></i>Új termék
                    </a>
                    <a href="<c:url value='/admin/orders/list'/>" class="btn btn-white border shadow-sm px-4 py-2 rounded-3 text-dark">
                        <i class="bi bi-card-list me-2"></i>Rendelések kezelése
                    </a>
                </div>
            </div>

        </main>
    </div>
</div>

<%-- Admin lábléc --%>
<%@ include file="shared/admin-footer.jsp" %>