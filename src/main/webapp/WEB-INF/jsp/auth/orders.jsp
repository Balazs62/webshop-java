<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../shared/header.jsp" %>

<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-box-seam text-primary me-2"></i>Rendeléseim</h2>
        <a href="<c:url value='/profile'/>" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Vissza a profilhoz
        </a>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="text-center py-5 border rounded bg-light">
                <i class="bi bi-cart-x text-muted" style="font-size: 4rem;"></i>
                <p class="lead mt-3 text-muted">Még nincs leadott rendelésed.</p>
                <a href="<c:url value='/'/>" class="btn btn-primary">Vásárlás megkezdése</a>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="accordion shadow-sm" id="ordersAccordion">
                <%-- JAVÍTVA: forEach szóköz nélkül --%>
                <c:forEach var="order" items="${orders}" varStatus="status">
                    <div class="accordion-item border-0 mb-3 shadow-sm">
                        <h2 class="accordion-header">
                            <button class="accordion-button ${status.first ? '' : 'collapsed'} bg-white" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#order-${order.id}">
                                <div class="d-flex justify-content-between w-100 align-items-center pe-3">
                                    <div>
                                        <span class="fw-bold text-dark">#${order.id}</span>
                                        <c:if test="${not empty order.orderDate}">
                                            <span class="ms-3 text-muted small">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                <c:set var="d" value="${order.orderDate.toString()}" />
                                                <c:out value="${d.length() >= 10 ? d.substring(0,10).replace('-', '.') : d}"/>. 
                                                <c:out value="${d.length() >= 16 ? d.substring(11,16) : ''}"/>
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="text-end">
                                        <span class="badge ${order.status == 'PENDING' ? 'bg-warning text-dark' : 'bg-success'} rounded-pill px-3 me-3">
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING'}">Feldolgozás alatt</c:when>
                                                <c:otherwise>Teljesítve</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="fw-bold text-primary"><fmt:formatNumber value="${order.totalPrice}" type="number" /> Ft</span>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        
                        <div id="order-${order.id}" class="accordion-collapse collapse ${status.first ? 'show' : ''}" data-bs-parent="#ordersAccordion">
                            <div class="accordion-body bg-light-subtle">
                                <div class="row g-4">
                                    <div class="col-md-7">
                                        <h6 class="border-bottom pb-2 mb-3 fw-bold">Rendelt termékek</h6>
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="d-flex justify-content-between align-items-center mb-2 bg-white p-2 rounded border-start border-primary border-4 shadow-sm">
                                                <div>
                                                    <span class="fw-bold">
                                                        <c:choose>
                                                            <%-- JAVÍTVA: item.productVariant használata a getProductVariant() getterhez --%>
                                                            <c:when test="${not empty item.productVariant && not empty item.productVariant.product}">
                                                                <c:out value="${item.productVariant.product.name}" />
                                                            </c:when>
                                                            <c:otherwise><span class="text-danger italic">Törölt termék</span></c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <c:if test="${not empty item.productVariant}">
                                                        <small class="text-muted ms-2">(Méret: ${item.productVariant.size})</small>
                                                    </c:if>
                                                    <div class="small text-muted">
                                                        ${item.quantity} db &times; <fmt:formatNumber value="${item.price}" type="number" /> Ft
                                                    </div>
                                                </div>
                                                <div class="fw-bold text-dark text-nowrap">
                                                    <fmt:formatNumber value="${item.price * item.quantity}" type="number" /> Ft
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <div class="col-md-5">
                                        <div class="bg-white p-3 rounded shadow-sm border">
                                            <h6 class="border-bottom pb-2 mb-3 text-secondary small fw-bold text-uppercase">Rendelés részletei</h6>
                                            
                                            <p class="small mb-1"><strong>Szállítási cím:</strong></p>
                                            <address class="small text-muted mb-3">
                                                ${order.shippingAddress.zipCode} ${order.shippingAddress.city},<br>
                                                ${order.shippingAddress.street} ${order.shippingAddress.houseNumber}.
                                                <c:if test="${not empty order.shippingAddress.floor}"><br>Emelet: ${order.shippingAddress.floor}</c:if>
                                                <c:if test="${not empty order.shippingAddress.door}"> Ajtó: ${order.shippingAddress.door}</c:if>
                                            </address>

                                            <p class="small mb-1"><strong>Fizetési mód:</strong></p>
                                            <p class="small text-muted mb-0">
                                                <c:choose>
                                                    <c:when test="${order.paymentMethod == 'COD'}"><i class="bi bi-cash me-1"></i> Utánvét</c:when>
                                                    <c:when test="${order.paymentMethod == 'CARD'}"><i class="bi bi-credit-card me-1"></i> Bankkártya</c:when>
                                                    <c:otherwise><i class="bi bi-bank me-1"></i> Átutalás</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../shared/footer.jsp" %>