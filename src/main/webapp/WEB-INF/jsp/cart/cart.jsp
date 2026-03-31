<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>

<%@ include file="../shared/header.jsp" %>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<div class="container mt-5">
    <h2>Kosarad tartalma</h2>
    
    <c:choose>
        <c:when test="${not empty cart}">
            <table class="table table-hover mt-4">
                <thead class="table-dark">
                    <tr>
                        <th>Termék</th>
                        <th>Méret</th>
                        <th>Ár</th>
                        <th>Mennyiség</th>
                        <th>Összesen</th>
                        <th>Törlés</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cart}" var="item">
                        <tr>
                            <td>${item.name}</td>
                            <td><span class="badge bg-secondary">${item.size}</span></td>
                            <td>${item.price} Ft</td>
                            <td style="min-width: 120px;">
							    <div class="d-flex align-items-center gap-2">
							        <form action="<c:url value='/cart/update'/>" method="post">
							            <input type="hidden" name="productId" value="${item.productId}">
							            <input type="hidden" name="size" value="${item.size}">
							            <input type="hidden" name="action" value="decrease">
							            <button type="submit" class="btn btn-outline-secondary btn-sm" 
							                    ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
							        </form>
							
							        <span class="fw-bold">${item.quantity}</span>
							
							        <form action="<c:url value='/cart/update'/>" method="post">
							            <input type="hidden" name="productId" value="${item.productId}">
							            <input type="hidden" name="size" value="${item.size}">
							            <input type="hidden" name="action" value="increase">
							            <button type="submit" class="btn btn-outline-secondary btn-sm">+</button>
							        </form>
							    </div>
							</td>
							
                            <td class="fw-bold">${item.price * item.quantity} Ft</td>
                            <td>
							    <form action="<c:url value='/cart/remove'/>" method="post" style="display:inline;">
							        <input type="hidden" name="productId" value="${item.productId}">
							        <input type="hidden" name="size" value="${item.size}">
							        <button type="submit" class="btn btn-outline-danger btn-sm border-0">
							            <i class="bi bi-trash3"></i> </button>
							    </form>
							</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
			<div class="text-end mt-4">
			    <a href="<c:url value='/cart/checkout'/>" class="btn btn-success btn-lg shadow-sm px-5">
			        Pénztárhoz <i class="bi bi-arrow-right-short"></i>
			    </a>
			</div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info mt-4">A kosarad jelenleg üres.</div>
            <a href="<c:url value='/' />" class="btn btn-primary">Vissza a vásárláshoz</a>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../shared/footer.jsp" %>