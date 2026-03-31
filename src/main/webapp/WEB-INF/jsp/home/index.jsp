<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>

<%@ include file="../shared/header.jsp" %>

<div class="text-center mb-5 mt-4">
    <h1 class="display-4 fw-bold">Termékeink</h1>
</div>

<div class="row row-cols-1 row-cols-md-3 g-4">
    <c:forEach items="${products}" var="p">
        <div class="col">
            <div class="card h-100 shadow-sm border-0 p-2">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">${p.name}</h5>
                    <p class="card-text text-muted small">${p.description}</p>
                    
                    <div class="mt-auto">
                        <p class="fs-5 fw-bold text-primary">
                            <fmt:formatNumber value="${p.basePrice}" type="currency" currencySymbol="Ft" maxFractionDigits="0"/>
                        </p>
                         <form action="/cart/add" method="post">
                            <input type="hidden" name="productId" value="${p.id}">
                            
                            <label class="small text-muted mb-1">Méret választása:</label>
                            <select name="size" class="form-select form-select-sm mb-3" required>
                                <c:forEach items="${p.productVariants}" var="v">
                                    <option value="${v.size}">${v.size} (${v.stockQuantity} db)</option>
                                </c:forEach>
                            </select>
                            
                            <button type="submit" class="btn btn-dark w-100">
                                <i class="bi bi-cart-plus"></i> Kosárba
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<%@ include file="../shared/footer.jsp" %>